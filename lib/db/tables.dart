// lib/db/tables.dart
//
// Defines the two Drift tables: UsersTable and ChildrenTable.
// These are the local SQLite schemas — they mirror the Firestore structure
// but add an `isSynced` flag to track what still needs uploading.

import 'package:drift/drift.dart';

/// Local users table — stores Firebase user data offline.
/// `id` is the Firebase UID (string), not auto-increment.
/// `isSynced` = true means Firestore already has this record.
class UsersTable extends Table {
  TextColumn get id => text()(); // Firebase UID
  TextColumn get name => text()();
  TextColumn get email => text()();
  BoolColumn get isPremiumUser => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local children table — stores child records offline.
/// `id` is auto-incremented locally.
/// `firebaseId` is populated once the record is successfully synced to Firestore.
/// `isSynced` = false means this record is pending upload.
class ChildrenTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firebaseId => text().nullable()(); // null until synced
  TextColumn get userId => text()();               // references UsersTable.id
  TextColumn get name => text()();
  TextColumn get birthDate => text()();            // stored as ISO8601 string
  TextColumn get gender => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}
