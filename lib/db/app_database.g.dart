// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPremiumUserMeta =
      const VerificationMeta('isPremiumUser');
  @override
  late final GeneratedColumn<bool> isPremiumUser = GeneratedColumn<bool>(
      'is_premium_user', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_premium_user" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, isPremiumUser, createdAt, updatedAt, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_table';
  @override
  VerificationContext validateIntegrity(Insertable<UsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('is_premium_user')) {
      context.handle(
          _isPremiumUserMeta,
          isPremiumUser.isAcceptableOrUnknown(
              data['is_premium_user']!, _isPremiumUserMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      isPremiumUser: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_premium_user'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final String id;
  final String name;
  final String email;
  final bool isPremiumUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const UsersTableData(
      {required this.id,
      required this.name,
      required this.email,
      required this.isPremiumUser,
      required this.createdAt,
      required this.updatedAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['is_premium_user'] = Variable<bool>(isPremiumUser);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      isPremiumUser: Value(isPremiumUser),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory UsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      isPremiumUser: serializer.fromJson<bool>(json['isPremiumUser']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'isPremiumUser': serializer.toJson<bool>(isPremiumUser),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  UsersTableData copyWith(
          {String? id,
          String? name,
          String? email,
          bool? isPremiumUser,
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isSynced}) =>
      UsersTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        isPremiumUser: isPremiumUser ?? this.isPremiumUser,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isSynced: isSynced ?? this.isSynced,
      );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      isPremiumUser: data.isPremiumUser.present
          ? data.isPremiumUser.value
          : this.isPremiumUser,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('isPremiumUser: $isPremiumUser, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, email, isPremiumUser, createdAt, updatedAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.isPremiumUser == this.isPremiumUser &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<bool> isPremiumUser;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.isPremiumUser = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersTableCompanion.insert({
    required String id,
    required String name,
    required String email,
    this.isPremiumUser = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UsersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<bool>? isPremiumUser,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (isPremiumUser != null) 'is_premium_user': isPremiumUser,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? email,
      Value<bool>? isPremiumUser,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isSynced,
      Value<int>? rowid}) {
    return UsersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isPremiumUser.present) {
      map['is_premium_user'] = Variable<bool>(isPremiumUser.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('isPremiumUser: $isPremiumUser, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildrenTableTable extends ChildrenTable
    with TableInfo<$ChildrenTableTable, ChildrenTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildrenTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firebaseIdMeta =
      const VerificationMeta('firebaseId');
  @override
  late final GeneratedColumn<String> firebaseId = GeneratedColumn<String>(
      'firebase_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
      'birth_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, firebaseId, userId, name, birthDate, gender, createdAt, isSynced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'children_table';
  @override
  VerificationContext validateIntegrity(Insertable<ChildrenTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('firebase_id')) {
      context.handle(
          _firebaseIdMeta,
          firebaseId.isAcceptableOrUnknown(
              data['firebase_id']!, _firebaseIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChildrenTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildrenTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firebaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}firebase_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birth_date'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
    );
  }

  @override
  $ChildrenTableTable createAlias(String alias) {
    return $ChildrenTableTable(attachedDatabase, alias);
  }
}

class ChildrenTableData extends DataClass
    implements Insertable<ChildrenTableData> {
  final int id;
  final String? firebaseId;
  final String userId;
  final String name;
  final String birthDate;
  final String gender;
  final DateTime createdAt;
  final bool isSynced;
  const ChildrenTableData(
      {required this.id,
      this.firebaseId,
      required this.userId,
      required this.name,
      required this.birthDate,
      required this.gender,
      required this.createdAt,
      required this.isSynced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || firebaseId != null) {
      map['firebase_id'] = Variable<String>(firebaseId);
    }
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['birth_date'] = Variable<String>(birthDate);
    map['gender'] = Variable<String>(gender);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  ChildrenTableCompanion toCompanion(bool nullToAbsent) {
    return ChildrenTableCompanion(
      id: Value(id),
      firebaseId: firebaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(firebaseId),
      userId: Value(userId),
      name: Value(name),
      birthDate: Value(birthDate),
      gender: Value(gender),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory ChildrenTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildrenTableData(
      id: serializer.fromJson<int>(json['id']),
      firebaseId: serializer.fromJson<String?>(json['firebaseId']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      birthDate: serializer.fromJson<String>(json['birthDate']),
      gender: serializer.fromJson<String>(json['gender']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firebaseId': serializer.toJson<String?>(firebaseId),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'birthDate': serializer.toJson<String>(birthDate),
      'gender': serializer.toJson<String>(gender),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  ChildrenTableData copyWith(
          {int? id,
          Value<String?> firebaseId = const Value.absent(),
          String? userId,
          String? name,
          String? birthDate,
          String? gender,
          DateTime? createdAt,
          bool? isSynced}) =>
      ChildrenTableData(
        id: id ?? this.id,
        firebaseId: firebaseId.present ? firebaseId.value : this.firebaseId,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        createdAt: createdAt ?? this.createdAt,
        isSynced: isSynced ?? this.isSynced,
      );
  ChildrenTableData copyWithCompanion(ChildrenTableCompanion data) {
    return ChildrenTableData(
      id: data.id.present ? data.id.value : this.id,
      firebaseId:
          data.firebaseId.present ? data.firebaseId.value : this.firebaseId,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      gender: data.gender.present ? data.gender.value : this.gender,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenTableData(')
          ..write('id: $id, ')
          ..write('firebaseId: $firebaseId, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, firebaseId, userId, name, birthDate, gender, createdAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildrenTableData &&
          other.id == this.id &&
          other.firebaseId == this.firebaseId &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.birthDate == this.birthDate &&
          other.gender == this.gender &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class ChildrenTableCompanion extends UpdateCompanion<ChildrenTableData> {
  final Value<int> id;
  final Value<String?> firebaseId;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> birthDate;
  final Value<String> gender;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  const ChildrenTableCompanion({
    this.id = const Value.absent(),
    this.firebaseId = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  ChildrenTableCompanion.insert({
    this.id = const Value.absent(),
    this.firebaseId = const Value.absent(),
    required String userId,
    required String name,
    required String birthDate,
    required String gender,
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name),
        birthDate = Value(birthDate),
        gender = Value(gender),
        createdAt = Value(createdAt);
  static Insertable<ChildrenTableData> custom({
    Expression<int>? id,
    Expression<String>? firebaseId,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? birthDate,
    Expression<String>? gender,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firebaseId != null) 'firebase_id': firebaseId,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (birthDate != null) 'birth_date': birthDate,
      if (gender != null) 'gender': gender,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  ChildrenTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? firebaseId,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? birthDate,
      Value<String>? gender,
      Value<DateTime>? createdAt,
      Value<bool>? isSynced}) {
    return ChildrenTableCompanion(
      id: id ?? this.id,
      firebaseId: firebaseId ?? this.firebaseId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firebaseId.present) {
      map['firebase_id'] = Variable<String>(firebaseId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenTableCompanion(')
          ..write('id: $id, ')
          ..write('firebaseId: $firebaseId, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $ChildrenTableTable childrenTable = $ChildrenTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [usersTable, childrenTable];
}

typedef $$UsersTableTableCreateCompanionBuilder = UsersTableCompanion Function({
  required String id,
  required String name,
  required String email,
  Value<bool> isPremiumUser,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> isSynced,
  Value<int> rowid,
});
typedef $$UsersTableTableUpdateCompanionBuilder = UsersTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> email,
  Value<bool> isPremiumUser,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isSynced,
  Value<int> rowid,
});

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPremiumUser => $composableBuilder(
      column: $table.isPremiumUser, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPremiumUser => $composableBuilder(
      column: $table.isPremiumUser,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get isPremiumUser => $composableBuilder(
      column: $table.isPremiumUser, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$UsersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (
      UsersTableData,
      BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>
    ),
    UsersTableData,
    PrefetchHooks Function()> {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<bool> isPremiumUser = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersTableCompanion(
            id: id,
            name: name,
            email: email,
            isPremiumUser: isPremiumUser,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String email,
            Value<bool> isPremiumUser = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> isSynced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersTableCompanion.insert(
            id: id,
            name: name,
            email: email,
            isPremiumUser: isPremiumUser,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isSynced: isSynced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (
      UsersTableData,
      BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>
    ),
    UsersTableData,
    PrefetchHooks Function()>;
typedef $$ChildrenTableTableCreateCompanionBuilder = ChildrenTableCompanion
    Function({
  Value<int> id,
  Value<String?> firebaseId,
  required String userId,
  required String name,
  required String birthDate,
  required String gender,
  required DateTime createdAt,
  Value<bool> isSynced,
});
typedef $$ChildrenTableTableUpdateCompanionBuilder = ChildrenTableCompanion
    Function({
  Value<int> id,
  Value<String?> firebaseId,
  Value<String> userId,
  Value<String> name,
  Value<String> birthDate,
  Value<String> gender,
  Value<DateTime> createdAt,
  Value<bool> isSynced,
});

class $$ChildrenTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firebaseId => $composableBuilder(
      column: $table.firebaseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));
}

class $$ChildrenTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firebaseId => $composableBuilder(
      column: $table.firebaseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));
}

class $$ChildrenTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firebaseId => $composableBuilder(
      column: $table.firebaseId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$ChildrenTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildrenTableTable,
    ChildrenTableData,
    $$ChildrenTableTableFilterComposer,
    $$ChildrenTableTableOrderingComposer,
    $$ChildrenTableTableAnnotationComposer,
    $$ChildrenTableTableCreateCompanionBuilder,
    $$ChildrenTableTableUpdateCompanionBuilder,
    (
      ChildrenTableData,
      BaseReferences<_$AppDatabase, $ChildrenTableTable, ChildrenTableData>
    ),
    ChildrenTableData,
    PrefetchHooks Function()> {
  $$ChildrenTableTableTableManager(_$AppDatabase db, $ChildrenTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildrenTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildrenTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildrenTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> firebaseId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> birthDate = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
          }) =>
              ChildrenTableCompanion(
            id: id,
            firebaseId: firebaseId,
            userId: userId,
            name: name,
            birthDate: birthDate,
            gender: gender,
            createdAt: createdAt,
            isSynced: isSynced,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> firebaseId = const Value.absent(),
            required String userId,
            required String name,
            required String birthDate,
            required String gender,
            required DateTime createdAt,
            Value<bool> isSynced = const Value.absent(),
          }) =>
              ChildrenTableCompanion.insert(
            id: id,
            firebaseId: firebaseId,
            userId: userId,
            name: name,
            birthDate: birthDate,
            gender: gender,
            createdAt: createdAt,
            isSynced: isSynced,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChildrenTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildrenTableTable,
    ChildrenTableData,
    $$ChildrenTableTableFilterComposer,
    $$ChildrenTableTableOrderingComposer,
    $$ChildrenTableTableAnnotationComposer,
    $$ChildrenTableTableCreateCompanionBuilder,
    $$ChildrenTableTableUpdateCompanionBuilder,
    (
      ChildrenTableData,
      BaseReferences<_$AppDatabase, $ChildrenTableTable, ChildrenTableData>
    ),
    ChildrenTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$ChildrenTableTableTableManager get childrenTable =>
      $$ChildrenTableTableTableManager(_db, _db.childrenTable);
}
