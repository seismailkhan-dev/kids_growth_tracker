// lib/db/app_database.dart
//
// The central Drift database class. All local reads/writes go through here.
//
// Why Drift?
//  - Type-safe SQL queries generated at compile time
//  - Works fully offline — data is persisted to device storage
//  - Easy migrations and reactive streams
//
// Run code generation once after any table change:
//   flutter pub run build_runner build --delete-conflicting-outputs

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

// The part directive links the generated file produced by drift_dev.
part 'app_database.g.dart';

/// Top-level accessor — use AppDatabase.instance everywhere.
/// Using a singleton avoids opening multiple connections to the same file.
AppDatabase? _instance;

@DriftDatabase(tables: [UsersTable, ChildrenTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static AppDatabase get instance {
    _instance ??= AppDatabase._internal();
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  // ─── User Queries ────────────────────────────────────────────────────────

  /// Insert or replace the user row. Called right after Firebase sign-in.
  Future<void> upsertUser(UsersTableCompanion user) =>
      into(usersTable).insertOnConflictUpdate(user);

  /// Load the locally stored user by Firebase UID.
  Future<UsersTableData?> getUser(String uid) =>
      (select(usersTable)..where((t) => t.id.equals(uid))).getSingleOrNull();

  /// Mark user as synced after Firestore write succeeds.
  Future<void> markUserSynced(String uid) =>
      (update(usersTable)..where((t) => t.id.equals(uid)))
          .write(const UsersTableCompanion(isSynced: Value(true)));

  // ─── Children Queries ────────────────────────────────────────────────────

  /// Watch all children for a user — returns a reactive stream.
  /// UI rebuilds automatically when data changes (offline-first pattern).
  Stream<List<ChildrenTableData>> watchChildren(String userId) =>
      (select(childrenTable)..where((t) => t.userId.equals(userId))).watch();

  /// Insert a new child locally. Returns the auto-generated local id.
  Future<int> insertChild(ChildrenTableCompanion child) =>
      into(childrenTable).insert(child);

  /// Fetch all children that have not yet been uploaded to Firestore.
  Future<List<ChildrenTableData>> getUnsyncedChildren(String userId) =>
      (select(childrenTable)
            ..where((t) => t.userId.equals(userId) & t.isSynced.equals(false)))
          .get();

  /// After a successful Firestore write, store the remote ID and flip isSynced.
  Future<void> markChildSynced(int localId, String firebaseId) =>
      (update(childrenTable)..where((t) => t.id.equals(localId))).write(
        ChildrenTableCompanion(
          firebaseId: Value(firebaseId),
          isSynced: const Value(true),
        ),
      );
}

/// Opens (or creates) the SQLite database file on the device.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
