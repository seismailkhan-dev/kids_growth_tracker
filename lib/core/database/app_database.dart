// lib/database/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:family_health_tracker/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
part 'app_database.g.dart';

// Step 2a: Define Tables
class Users extends Table {
  TextColumn get id => text()(); // Firebase UID
  TextColumn get name => text()();
  TextColumn get email => text()();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Children extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firebaseId => text().nullable()(); // Firestore ID
  TextColumn get userId => text()(); // Foreign key to Users.id
  TextColumn get name => text()();
  TextColumn get gender => text()();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get photoPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

class GrowthRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get childId => text()();
  RealColumn get height => real()();
  RealColumn get weight => real()();
  RealColumn get headCircumference => real().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// // Step 2b: Define Database
// @DriftDatabase(tables: [Users, Children, GrowthRecords])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());
//
//   @override
//   int get schemaVersion => 1;
//
//   // Step 2c: User CRUD Example
//   Future<int> insertUser(UsersCompanion user) => into(users).insert(user);
//
//   Future<User?> getUserById(String id) =>
//       (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
//
//   Future<List<User>> getAllUsers() => select(users).get();
// }

// // Step 2d: Open connection
// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File('${dbFolder.path}/app_database.sqlite');
//
//     return FlutterQueryExecutor(
//       path: file.path,
//       logStatements: true,
//     );
//   });
// }