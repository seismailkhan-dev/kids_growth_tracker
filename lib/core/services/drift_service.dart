import 'package:drift/drift.dart';

import '../../db/app_database.dart';
import '../../models/user.dart';

class DriftService {
  final AppDatabase _db = AppDatabase.instance;

  Future<void> saveUser(UserModel user) => _db.upsertUser(
    UsersTableCompanion(
      id: Value(user.id),
      name: Value(user.name),
      email: Value(user.email),
      isPremiumUser: Value(user.isPremiumUser),
      createdAt: Value(user.createdAt),
      updatedAt: Value(user.updatedAt),
      isSynced: Value(user.isSynced),
    ),
  );

  Future<UserModel?> getUser(String uid) async {
    final row = await _db.getUser(uid);
    if (row == null) return null;
    return UserModel(
      id: row.id,
      name: row.name,
      email: row.email,
      isPremiumUser: row.isPremiumUser,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isSynced: row.isSynced,
    );
  }


  Future<UserModel?> getLastLoggedInUser() async {
    final rows = await _db.select(_db.usersTable).get();
    if (rows.isEmpty) return null;

    final row = rows.first; // single-user app
    return UserModel(
      id: row.id,
      name: row.name,
      email: row.email,
      isPremiumUser: row.isPremiumUser,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isSynced: row.isSynced,
    );
  }


  Future<UserModel?> getUserByEmail(String email) async {
    final row = await (_db.select(_db.usersTable)
      ..where((t) => t.email.equals(email)))
        .getSingleOrNull();

    if (row == null) return null;

    return UserModel(
      id: row.id,
      name: row.name,
      email: row.email,
      isPremiumUser: row.isPremiumUser,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isSynced: row.isSynced,
    );
  }

  Future<void> markUserSynced(String uid) =>
      _db.markUserSynced(uid);
}