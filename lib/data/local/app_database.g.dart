// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
    'salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _biometricEnabledMeta = const VerificationMeta(
    'biometricEnabled',
  );
  @override
  late final GeneratedColumn<bool> biometricEnabled = GeneratedColumn<bool>(
    'biometric_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("biometric_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _failedAttemptsMeta = const VerificationMeta(
    'failedAttempts',
  );
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
    'failed_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lockedUntilMeta = const VerificationMeta(
    'lockedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> lockedUntil = GeneratedColumn<DateTime>(
    'locked_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    role,
    pinHash,
    salt,
    biometricEnabled,
    isActive,
    failedAttempts,
    lockedUntil,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
        _saltMeta,
        salt.isAcceptableOrUnknown(data['salt']!, _saltMeta),
      );
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('biometric_enabled')) {
      context.handle(
        _biometricEnabledMeta,
        biometricEnabled.isAcceptableOrUnknown(
          data['biometric_enabled']!,
          _biometricEnabledMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
        _failedAttemptsMeta,
        failedAttempts.isAcceptableOrUnknown(
          data['failed_attempts']!,
          _failedAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('locked_until')) {
      context.handle(
        _lockedUntilMeta,
        lockedUntil.isAcceptableOrUnknown(
          data['locked_until']!,
          _lockedUntilMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      )!,
      salt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}salt'],
      )!,
      biometricEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}biometric_enabled'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      failedAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failed_attempts'],
      )!,
      lockedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}locked_until'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final int id;
  final String username;
  final String role;
  final String pinHash;
  final String salt;
  final bool biometricEnabled;
  final bool isActive;
  final int failedAttempts;
  final DateTime? lockedUntil;
  final DateTime updatedAt;
  final String deviceId;
  const UserRow({
    required this.id,
    required this.username,
    required this.role,
    required this.pinHash,
    required this.salt,
    required this.biometricEnabled,
    required this.isActive,
    required this.failedAttempts,
    this.lockedUntil,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['role'] = Variable<String>(role);
    map['pin_hash'] = Variable<String>(pinHash);
    map['salt'] = Variable<String>(salt);
    map['biometric_enabled'] = Variable<bool>(biometricEnabled);
    map['is_active'] = Variable<bool>(isActive);
    map['failed_attempts'] = Variable<int>(failedAttempts);
    if (!nullToAbsent || lockedUntil != null) {
      map['locked_until'] = Variable<DateTime>(lockedUntil);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      role: Value(role),
      pinHash: Value(pinHash),
      salt: Value(salt),
      biometricEnabled: Value(biometricEnabled),
      isActive: Value(isActive),
      failedAttempts: Value(failedAttempts),
      lockedUntil: lockedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(lockedUntil),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      role: serializer.fromJson<String>(json['role']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      salt: serializer.fromJson<String>(json['salt']),
      biometricEnabled: serializer.fromJson<bool>(json['biometricEnabled']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
      lockedUntil: serializer.fromJson<DateTime?>(json['lockedUntil']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'role': serializer.toJson<String>(role),
      'pinHash': serializer.toJson<String>(pinHash),
      'salt': serializer.toJson<String>(salt),
      'biometricEnabled': serializer.toJson<bool>(biometricEnabled),
      'isActive': serializer.toJson<bool>(isActive),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
      'lockedUntil': serializer.toJson<DateTime?>(lockedUntil),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  UserRow copyWith({
    int? id,
    String? username,
    String? role,
    String? pinHash,
    String? salt,
    bool? biometricEnabled,
    bool? isActive,
    int? failedAttempts,
    Value<DateTime?> lockedUntil = const Value.absent(),
    DateTime? updatedAt,
    String? deviceId,
  }) => UserRow(
    id: id ?? this.id,
    username: username ?? this.username,
    role: role ?? this.role,
    pinHash: pinHash ?? this.pinHash,
    salt: salt ?? this.salt,
    biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    isActive: isActive ?? this.isActive,
    failedAttempts: failedAttempts ?? this.failedAttempts,
    lockedUntil: lockedUntil.present ? lockedUntil.value : this.lockedUntil,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      role: data.role.present ? data.role.value : this.role,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      salt: data.salt.present ? data.salt.value : this.salt,
      biometricEnabled: data.biometricEnabled.present
          ? data.biometricEnabled.value
          : this.biometricEnabled,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
      lockedUntil: data.lockedUntil.present
          ? data.lockedUntil.value
          : this.lockedUntil,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('role: $role, ')
          ..write('pinHash: $pinHash, ')
          ..write('salt: $salt, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('isActive: $isActive, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('lockedUntil: $lockedUntil, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    role,
    pinHash,
    salt,
    biometricEnabled,
    isActive,
    failedAttempts,
    lockedUntil,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.username == this.username &&
          other.role == this.role &&
          other.pinHash == this.pinHash &&
          other.salt == this.salt &&
          other.biometricEnabled == this.biometricEnabled &&
          other.isActive == this.isActive &&
          other.failedAttempts == this.failedAttempts &&
          other.lockedUntil == this.lockedUntil &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> role;
  final Value<String> pinHash;
  final Value<String> salt;
  final Value<bool> biometricEnabled;
  final Value<bool> isActive;
  final Value<int> failedAttempts;
  final Value<DateTime?> lockedUntil;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.role = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.salt = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.isActive = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.lockedUntil = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String role,
    required String pinHash,
    required String salt,
    this.biometricEnabled = const Value.absent(),
    this.isActive = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.lockedUntil = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : username = Value(username),
       role = Value(role),
       pinHash = Value(pinHash),
       salt = Value(salt),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<UserRow> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? role,
    Expression<String>? pinHash,
    Expression<String>? salt,
    Expression<bool>? biometricEnabled,
    Expression<bool>? isActive,
    Expression<int>? failedAttempts,
    Expression<DateTime>? lockedUntil,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (role != null) 'role': role,
      if (pinHash != null) 'pin_hash': pinHash,
      if (salt != null) 'salt': salt,
      if (biometricEnabled != null) 'biometric_enabled': biometricEnabled,
      if (isActive != null) 'is_active': isActive,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (lockedUntil != null) 'locked_until': lockedUntil,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? role,
    Value<String>? pinHash,
    Value<String>? salt,
    Value<bool>? biometricEnabled,
    Value<bool>? isActive,
    Value<int>? failedAttempts,
    Value<DateTime?>? lockedUntil,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      role: role ?? this.role,
      pinHash: pinHash ?? this.pinHash,
      salt: salt ?? this.salt,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      isActive: isActive ?? this.isActive,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      lockedUntil: lockedUntil ?? this.lockedUntil,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (biometricEnabled.present) {
      map['biometric_enabled'] = Variable<bool>(biometricEnabled.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (lockedUntil.present) {
      map['locked_until'] = Variable<DateTime>(lockedUntil.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('role: $role, ')
          ..write('pinHash: $pinHash, ')
          ..write('salt: $salt, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('isActive: $isActive, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('lockedUntil: $lockedUntil, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $ProdiTable extends Prodi with TableInfo<$ProdiTable, ProdiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kodeMeta = const VerificationMeta('kode');
  @override
  late final GeneratedColumn<String> kode = GeneratedColumn<String>(
    'kode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, kode, nama, updatedAt, deviceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prodi';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProdiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kode')) {
      context.handle(
        _kodeMeta,
        kode.isAcceptableOrUnknown(data['kode']!, _kodeMeta),
      );
    } else if (isInserting) {
      context.missing(_kodeMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProdiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kode'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $ProdiTable createAlias(String alias) {
    return $ProdiTable(attachedDatabase, alias);
  }
}

class ProdiRow extends DataClass implements Insertable<ProdiRow> {
  final int id;
  final String kode;
  final String nama;
  final DateTime updatedAt;
  final String deviceId;
  const ProdiRow({
    required this.id,
    required this.kode,
    required this.nama,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kode'] = Variable<String>(kode);
    map['nama'] = Variable<String>(nama);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  ProdiCompanion toCompanion(bool nullToAbsent) {
    return ProdiCompanion(
      id: Value(id),
      kode: Value(kode),
      nama: Value(nama),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory ProdiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProdiRow(
      id: serializer.fromJson<int>(json['id']),
      kode: serializer.fromJson<String>(json['kode']),
      nama: serializer.fromJson<String>(json['nama']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kode': serializer.toJson<String>(kode),
      'nama': serializer.toJson<String>(nama),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  ProdiRow copyWith({
    int? id,
    String? kode,
    String? nama,
    DateTime? updatedAt,
    String? deviceId,
  }) => ProdiRow(
    id: id ?? this.id,
    kode: kode ?? this.kode,
    nama: nama ?? this.nama,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  ProdiRow copyWithCompanion(ProdiCompanion data) {
    return ProdiRow(
      id: data.id.present ? data.id.value : this.id,
      kode: data.kode.present ? data.kode.value : this.kode,
      nama: data.nama.present ? data.nama.value : this.nama,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProdiRow(')
          ..write('id: $id, ')
          ..write('kode: $kode, ')
          ..write('nama: $nama, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kode, nama, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdiRow &&
          other.id == this.id &&
          other.kode == this.kode &&
          other.nama == this.nama &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class ProdiCompanion extends UpdateCompanion<ProdiRow> {
  final Value<int> id;
  final Value<String> kode;
  final Value<String> nama;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const ProdiCompanion({
    this.id = const Value.absent(),
    this.kode = const Value.absent(),
    this.nama = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  ProdiCompanion.insert({
    this.id = const Value.absent(),
    required String kode,
    required String nama,
    required DateTime updatedAt,
    required String deviceId,
  }) : kode = Value(kode),
       nama = Value(nama),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<ProdiRow> custom({
    Expression<int>? id,
    Expression<String>? kode,
    Expression<String>? nama,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kode != null) 'kode': kode,
      if (nama != null) 'nama': nama,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  ProdiCompanion copyWith({
    Value<int>? id,
    Value<String>? kode,
    Value<String>? nama,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return ProdiCompanion(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kode.present) {
      map['kode'] = Variable<String>(kode.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdiCompanion(')
          ..write('id: $id, ')
          ..write('kode: $kode, ')
          ..write('nama: $nama, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $DosensTable extends Dosens with TableInfo<$DosensTable, DosenRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DosensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nidnMeta = const VerificationMeta('nidn');
  @override
  late final GeneratedColumn<String> nidn = GeneratedColumn<String>(
    'nidn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _prodiIdMeta = const VerificationMeta(
    'prodiId',
  );
  @override
  late final GeneratedColumn<int> prodiId = GeneratedColumn<int>(
    'prodi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES prodi (id)',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nidn,
    nama,
    userId,
    prodiId,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dosens';
  @override
  VerificationContext validateIntegrity(
    Insertable<DosenRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nidn')) {
      context.handle(
        _nidnMeta,
        nidn.isAcceptableOrUnknown(data['nidn']!, _nidnMeta),
      );
    } else if (isInserting) {
      context.missing(_nidnMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('prodi_id')) {
      context.handle(
        _prodiIdMeta,
        prodiId.isAcceptableOrUnknown(data['prodi_id']!, _prodiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_prodiIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DosenRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DosenRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nidn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nidn'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      prodiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prodi_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $DosensTable createAlias(String alias) {
    return $DosensTable(attachedDatabase, alias);
  }
}

class DosenRow extends DataClass implements Insertable<DosenRow> {
  final int id;
  final String nidn;
  final String nama;
  final int? userId;
  final int prodiId;
  final DateTime updatedAt;
  final String deviceId;
  const DosenRow({
    required this.id,
    required this.nidn,
    required this.nama,
    this.userId,
    required this.prodiId,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nidn'] = Variable<String>(nidn);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['prodi_id'] = Variable<int>(prodiId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  DosensCompanion toCompanion(bool nullToAbsent) {
    return DosensCompanion(
      id: Value(id),
      nidn: Value(nidn),
      nama: Value(nama),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      prodiId: Value(prodiId),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory DosenRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DosenRow(
      id: serializer.fromJson<int>(json['id']),
      nidn: serializer.fromJson<String>(json['nidn']),
      nama: serializer.fromJson<String>(json['nama']),
      userId: serializer.fromJson<int?>(json['userId']),
      prodiId: serializer.fromJson<int>(json['prodiId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nidn': serializer.toJson<String>(nidn),
      'nama': serializer.toJson<String>(nama),
      'userId': serializer.toJson<int?>(userId),
      'prodiId': serializer.toJson<int>(prodiId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  DosenRow copyWith({
    int? id,
    String? nidn,
    String? nama,
    Value<int?> userId = const Value.absent(),
    int? prodiId,
    DateTime? updatedAt,
    String? deviceId,
  }) => DosenRow(
    id: id ?? this.id,
    nidn: nidn ?? this.nidn,
    nama: nama ?? this.nama,
    userId: userId.present ? userId.value : this.userId,
    prodiId: prodiId ?? this.prodiId,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  DosenRow copyWithCompanion(DosensCompanion data) {
    return DosenRow(
      id: data.id.present ? data.id.value : this.id,
      nidn: data.nidn.present ? data.nidn.value : this.nidn,
      nama: data.nama.present ? data.nama.value : this.nama,
      userId: data.userId.present ? data.userId.value : this.userId,
      prodiId: data.prodiId.present ? data.prodiId.value : this.prodiId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DosenRow(')
          ..write('id: $id, ')
          ..write('nidn: $nidn, ')
          ..write('nama: $nama, ')
          ..write('userId: $userId, ')
          ..write('prodiId: $prodiId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nidn, nama, userId, prodiId, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DosenRow &&
          other.id == this.id &&
          other.nidn == this.nidn &&
          other.nama == this.nama &&
          other.userId == this.userId &&
          other.prodiId == this.prodiId &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class DosensCompanion extends UpdateCompanion<DosenRow> {
  final Value<int> id;
  final Value<String> nidn;
  final Value<String> nama;
  final Value<int?> userId;
  final Value<int> prodiId;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const DosensCompanion({
    this.id = const Value.absent(),
    this.nidn = const Value.absent(),
    this.nama = const Value.absent(),
    this.userId = const Value.absent(),
    this.prodiId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  DosensCompanion.insert({
    this.id = const Value.absent(),
    required String nidn,
    required String nama,
    this.userId = const Value.absent(),
    required int prodiId,
    required DateTime updatedAt,
    required String deviceId,
  }) : nidn = Value(nidn),
       nama = Value(nama),
       prodiId = Value(prodiId),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<DosenRow> custom({
    Expression<int>? id,
    Expression<String>? nidn,
    Expression<String>? nama,
    Expression<int>? userId,
    Expression<int>? prodiId,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nidn != null) 'nidn': nidn,
      if (nama != null) 'nama': nama,
      if (userId != null) 'user_id': userId,
      if (prodiId != null) 'prodi_id': prodiId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  DosensCompanion copyWith({
    Value<int>? id,
    Value<String>? nidn,
    Value<String>? nama,
    Value<int?>? userId,
    Value<int>? prodiId,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return DosensCompanion(
      id: id ?? this.id,
      nidn: nidn ?? this.nidn,
      nama: nama ?? this.nama,
      userId: userId ?? this.userId,
      prodiId: prodiId ?? this.prodiId,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nidn.present) {
      map['nidn'] = Variable<String>(nidn.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (prodiId.present) {
      map['prodi_id'] = Variable<int>(prodiId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DosensCompanion(')
          ..write('id: $id, ')
          ..write('nidn: $nidn, ')
          ..write('nama: $nama, ')
          ..write('userId: $userId, ')
          ..write('prodiId: $prodiId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $MahasiswaTable extends Mahasiswa
    with TableInfo<$MahasiswaTable, MahasiswaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MahasiswaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nimMeta = const VerificationMeta('nim');
  @override
  late final GeneratedColumn<String> nim = GeneratedColumn<String>(
    'nim',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prodiIdMeta = const VerificationMeta(
    'prodiId',
  );
  @override
  late final GeneratedColumn<int> prodiId = GeneratedColumn<int>(
    'prodi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES prodi (id)',
    ),
  );
  static const VerificationMeta _angkatanMeta = const VerificationMeta(
    'angkatan',
  );
  @override
  late final GeneratedColumn<int> angkatan = GeneratedColumn<int>(
    'angkatan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('aktif'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _noHpMeta = const VerificationMeta('noHp');
  @override
  late final GeneratedColumn<String> noHp = GeneratedColumn<String>(
    'no_hp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fotoPathMeta = const VerificationMeta(
    'fotoPath',
  );
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
    'foto_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dosenWaliIdMeta = const VerificationMeta(
    'dosenWaliId',
  );
  @override
  late final GeneratedColumn<int> dosenWaliId = GeneratedColumn<int>(
    'dosen_wali_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dosens (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('seed'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nim,
    nama,
    prodiId,
    angkatan,
    status,
    email,
    noHp,
    fotoPath,
    dosenWaliId,
    userId,
    isDeleted,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mahasiswa';
  @override
  VerificationContext validateIntegrity(
    Insertable<MahasiswaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nim')) {
      context.handle(
        _nimMeta,
        nim.isAcceptableOrUnknown(data['nim']!, _nimMeta),
      );
    } else if (isInserting) {
      context.missing(_nimMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('prodi_id')) {
      context.handle(
        _prodiIdMeta,
        prodiId.isAcceptableOrUnknown(data['prodi_id']!, _prodiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_prodiIdMeta);
    }
    if (data.containsKey('angkatan')) {
      context.handle(
        _angkatanMeta,
        angkatan.isAcceptableOrUnknown(data['angkatan']!, _angkatanMeta),
      );
    } else if (isInserting) {
      context.missing(_angkatanMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('no_hp')) {
      context.handle(
        _noHpMeta,
        noHp.isAcceptableOrUnknown(data['no_hp']!, _noHpMeta),
      );
    }
    if (data.containsKey('foto_path')) {
      context.handle(
        _fotoPathMeta,
        fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta),
      );
    }
    if (data.containsKey('dosen_wali_id')) {
      context.handle(
        _dosenWaliIdMeta,
        dosenWaliId.isAcceptableOrUnknown(
          data['dosen_wali_id']!,
          _dosenWaliIdMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MahasiswaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MahasiswaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nim: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nim'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      prodiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prodi_id'],
      )!,
      angkatan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}angkatan'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      noHp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}no_hp'],
      )!,
      fotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foto_path'],
      ),
      dosenWaliId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dosen_wali_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $MahasiswaTable createAlias(String alias) {
    return $MahasiswaTable(attachedDatabase, alias);
  }
}

class MahasiswaRow extends DataClass implements Insertable<MahasiswaRow> {
  final int id;
  final String nim;
  final String nama;
  final int prodiId;
  final int angkatan;
  final String status;
  final String email;
  final String noHp;
  final String? fotoPath;
  final int? dosenWaliId;
  final int? userId;
  final bool isDeleted;
  final DateTime updatedAt;
  final String deviceId;
  const MahasiswaRow({
    required this.id,
    required this.nim,
    required this.nama,
    required this.prodiId,
    required this.angkatan,
    required this.status,
    required this.email,
    required this.noHp,
    this.fotoPath,
    this.dosenWaliId,
    this.userId,
    required this.isDeleted,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nim'] = Variable<String>(nim);
    map['nama'] = Variable<String>(nama);
    map['prodi_id'] = Variable<int>(prodiId);
    map['angkatan'] = Variable<int>(angkatan);
    map['status'] = Variable<String>(status);
    map['email'] = Variable<String>(email);
    map['no_hp'] = Variable<String>(noHp);
    if (!nullToAbsent || fotoPath != null) {
      map['foto_path'] = Variable<String>(fotoPath);
    }
    if (!nullToAbsent || dosenWaliId != null) {
      map['dosen_wali_id'] = Variable<int>(dosenWaliId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  MahasiswaCompanion toCompanion(bool nullToAbsent) {
    return MahasiswaCompanion(
      id: Value(id),
      nim: Value(nim),
      nama: Value(nama),
      prodiId: Value(prodiId),
      angkatan: Value(angkatan),
      status: Value(status),
      email: Value(email),
      noHp: Value(noHp),
      fotoPath: fotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoPath),
      dosenWaliId: dosenWaliId == null && nullToAbsent
          ? const Value.absent()
          : Value(dosenWaliId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      isDeleted: Value(isDeleted),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory MahasiswaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MahasiswaRow(
      id: serializer.fromJson<int>(json['id']),
      nim: serializer.fromJson<String>(json['nim']),
      nama: serializer.fromJson<String>(json['nama']),
      prodiId: serializer.fromJson<int>(json['prodiId']),
      angkatan: serializer.fromJson<int>(json['angkatan']),
      status: serializer.fromJson<String>(json['status']),
      email: serializer.fromJson<String>(json['email']),
      noHp: serializer.fromJson<String>(json['noHp']),
      fotoPath: serializer.fromJson<String?>(json['fotoPath']),
      dosenWaliId: serializer.fromJson<int?>(json['dosenWaliId']),
      userId: serializer.fromJson<int?>(json['userId']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nim': serializer.toJson<String>(nim),
      'nama': serializer.toJson<String>(nama),
      'prodiId': serializer.toJson<int>(prodiId),
      'angkatan': serializer.toJson<int>(angkatan),
      'status': serializer.toJson<String>(status),
      'email': serializer.toJson<String>(email),
      'noHp': serializer.toJson<String>(noHp),
      'fotoPath': serializer.toJson<String?>(fotoPath),
      'dosenWaliId': serializer.toJson<int?>(dosenWaliId),
      'userId': serializer.toJson<int?>(userId),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  MahasiswaRow copyWith({
    int? id,
    String? nim,
    String? nama,
    int? prodiId,
    int? angkatan,
    String? status,
    String? email,
    String? noHp,
    Value<String?> fotoPath = const Value.absent(),
    Value<int?> dosenWaliId = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    bool? isDeleted,
    DateTime? updatedAt,
    String? deviceId,
  }) => MahasiswaRow(
    id: id ?? this.id,
    nim: nim ?? this.nim,
    nama: nama ?? this.nama,
    prodiId: prodiId ?? this.prodiId,
    angkatan: angkatan ?? this.angkatan,
    status: status ?? this.status,
    email: email ?? this.email,
    noHp: noHp ?? this.noHp,
    fotoPath: fotoPath.present ? fotoPath.value : this.fotoPath,
    dosenWaliId: dosenWaliId.present ? dosenWaliId.value : this.dosenWaliId,
    userId: userId.present ? userId.value : this.userId,
    isDeleted: isDeleted ?? this.isDeleted,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  MahasiswaRow copyWithCompanion(MahasiswaCompanion data) {
    return MahasiswaRow(
      id: data.id.present ? data.id.value : this.id,
      nim: data.nim.present ? data.nim.value : this.nim,
      nama: data.nama.present ? data.nama.value : this.nama,
      prodiId: data.prodiId.present ? data.prodiId.value : this.prodiId,
      angkatan: data.angkatan.present ? data.angkatan.value : this.angkatan,
      status: data.status.present ? data.status.value : this.status,
      email: data.email.present ? data.email.value : this.email,
      noHp: data.noHp.present ? data.noHp.value : this.noHp,
      fotoPath: data.fotoPath.present ? data.fotoPath.value : this.fotoPath,
      dosenWaliId: data.dosenWaliId.present
          ? data.dosenWaliId.value
          : this.dosenWaliId,
      userId: data.userId.present ? data.userId.value : this.userId,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MahasiswaRow(')
          ..write('id: $id, ')
          ..write('nim: $nim, ')
          ..write('nama: $nama, ')
          ..write('prodiId: $prodiId, ')
          ..write('angkatan: $angkatan, ')
          ..write('status: $status, ')
          ..write('email: $email, ')
          ..write('noHp: $noHp, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('dosenWaliId: $dosenWaliId, ')
          ..write('userId: $userId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nim,
    nama,
    prodiId,
    angkatan,
    status,
    email,
    noHp,
    fotoPath,
    dosenWaliId,
    userId,
    isDeleted,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MahasiswaRow &&
          other.id == this.id &&
          other.nim == this.nim &&
          other.nama == this.nama &&
          other.prodiId == this.prodiId &&
          other.angkatan == this.angkatan &&
          other.status == this.status &&
          other.email == this.email &&
          other.noHp == this.noHp &&
          other.fotoPath == this.fotoPath &&
          other.dosenWaliId == this.dosenWaliId &&
          other.userId == this.userId &&
          other.isDeleted == this.isDeleted &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class MahasiswaCompanion extends UpdateCompanion<MahasiswaRow> {
  final Value<int> id;
  final Value<String> nim;
  final Value<String> nama;
  final Value<int> prodiId;
  final Value<int> angkatan;
  final Value<String> status;
  final Value<String> email;
  final Value<String> noHp;
  final Value<String?> fotoPath;
  final Value<int?> dosenWaliId;
  final Value<int?> userId;
  final Value<bool> isDeleted;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const MahasiswaCompanion({
    this.id = const Value.absent(),
    this.nim = const Value.absent(),
    this.nama = const Value.absent(),
    this.prodiId = const Value.absent(),
    this.angkatan = const Value.absent(),
    this.status = const Value.absent(),
    this.email = const Value.absent(),
    this.noHp = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.dosenWaliId = const Value.absent(),
    this.userId = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  MahasiswaCompanion.insert({
    this.id = const Value.absent(),
    required String nim,
    required String nama,
    required int prodiId,
    required int angkatan,
    this.status = const Value.absent(),
    this.email = const Value.absent(),
    this.noHp = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.dosenWaliId = const Value.absent(),
    this.userId = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime updatedAt,
    this.deviceId = const Value.absent(),
  }) : nim = Value(nim),
       nama = Value(nama),
       prodiId = Value(prodiId),
       angkatan = Value(angkatan),
       updatedAt = Value(updatedAt);
  static Insertable<MahasiswaRow> custom({
    Expression<int>? id,
    Expression<String>? nim,
    Expression<String>? nama,
    Expression<int>? prodiId,
    Expression<int>? angkatan,
    Expression<String>? status,
    Expression<String>? email,
    Expression<String>? noHp,
    Expression<String>? fotoPath,
    Expression<int>? dosenWaliId,
    Expression<int>? userId,
    Expression<bool>? isDeleted,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nim != null) 'nim': nim,
      if (nama != null) 'nama': nama,
      if (prodiId != null) 'prodi_id': prodiId,
      if (angkatan != null) 'angkatan': angkatan,
      if (status != null) 'status': status,
      if (email != null) 'email': email,
      if (noHp != null) 'no_hp': noHp,
      if (fotoPath != null) 'foto_path': fotoPath,
      if (dosenWaliId != null) 'dosen_wali_id': dosenWaliId,
      if (userId != null) 'user_id': userId,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  MahasiswaCompanion copyWith({
    Value<int>? id,
    Value<String>? nim,
    Value<String>? nama,
    Value<int>? prodiId,
    Value<int>? angkatan,
    Value<String>? status,
    Value<String>? email,
    Value<String>? noHp,
    Value<String?>? fotoPath,
    Value<int?>? dosenWaliId,
    Value<int?>? userId,
    Value<bool>? isDeleted,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return MahasiswaCompanion(
      id: id ?? this.id,
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      prodiId: prodiId ?? this.prodiId,
      angkatan: angkatan ?? this.angkatan,
      status: status ?? this.status,
      email: email ?? this.email,
      noHp: noHp ?? this.noHp,
      fotoPath: fotoPath ?? this.fotoPath,
      dosenWaliId: dosenWaliId ?? this.dosenWaliId,
      userId: userId ?? this.userId,
      isDeleted: isDeleted ?? this.isDeleted,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nim.present) {
      map['nim'] = Variable<String>(nim.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (prodiId.present) {
      map['prodi_id'] = Variable<int>(prodiId.value);
    }
    if (angkatan.present) {
      map['angkatan'] = Variable<int>(angkatan.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (noHp.present) {
      map['no_hp'] = Variable<String>(noHp.value);
    }
    if (fotoPath.present) {
      map['foto_path'] = Variable<String>(fotoPath.value);
    }
    if (dosenWaliId.present) {
      map['dosen_wali_id'] = Variable<int>(dosenWaliId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MahasiswaCompanion(')
          ..write('id: $id, ')
          ..write('nim: $nim, ')
          ..write('nama: $nama, ')
          ..write('prodiId: $prodiId, ')
          ..write('angkatan: $angkatan, ')
          ..write('status: $status, ')
          ..write('email: $email, ')
          ..write('noHp: $noHp, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('dosenWaliId: $dosenWaliId, ')
          ..write('userId: $userId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $TahunAjaranTable extends TahunAjaran
    with TableInfo<$TahunAjaranTable, TahunAjaranRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TahunAjaranTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<String> tahun = GeneratedColumn<String>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterMeta = const VerificationMeta(
    'semester',
  );
  @override
  late final GeneratedColumn<int> semester = GeneratedColumn<int>(
    'semester',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tahun,
    semester,
    isActive,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tahun_ajaran';
  @override
  VerificationContext validateIntegrity(
    Insertable<TahunAjaranRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('semester')) {
      context.handle(
        _semesterMeta,
        semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TahunAjaranRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TahunAjaranRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tahun'],
      )!,
      semester: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $TahunAjaranTable createAlias(String alias) {
    return $TahunAjaranTable(attachedDatabase, alias);
  }
}

class TahunAjaranRow extends DataClass implements Insertable<TahunAjaranRow> {
  final int id;
  final String tahun;
  final int semester;
  final bool isActive;
  final DateTime updatedAt;
  final String deviceId;
  const TahunAjaranRow({
    required this.id,
    required this.tahun,
    required this.semester,
    required this.isActive,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tahun'] = Variable<String>(tahun);
    map['semester'] = Variable<int>(semester);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  TahunAjaranCompanion toCompanion(bool nullToAbsent) {
    return TahunAjaranCompanion(
      id: Value(id),
      tahun: Value(tahun),
      semester: Value(semester),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory TahunAjaranRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TahunAjaranRow(
      id: serializer.fromJson<int>(json['id']),
      tahun: serializer.fromJson<String>(json['tahun']),
      semester: serializer.fromJson<int>(json['semester']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tahun': serializer.toJson<String>(tahun),
      'semester': serializer.toJson<int>(semester),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  TahunAjaranRow copyWith({
    int? id,
    String? tahun,
    int? semester,
    bool? isActive,
    DateTime? updatedAt,
    String? deviceId,
  }) => TahunAjaranRow(
    id: id ?? this.id,
    tahun: tahun ?? this.tahun,
    semester: semester ?? this.semester,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  TahunAjaranRow copyWithCompanion(TahunAjaranCompanion data) {
    return TahunAjaranRow(
      id: data.id.present ? data.id.value : this.id,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      semester: data.semester.present ? data.semester.value : this.semester,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TahunAjaranRow(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('semester: $semester, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tahun, semester, isActive, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TahunAjaranRow &&
          other.id == this.id &&
          other.tahun == this.tahun &&
          other.semester == this.semester &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class TahunAjaranCompanion extends UpdateCompanion<TahunAjaranRow> {
  final Value<int> id;
  final Value<String> tahun;
  final Value<int> semester;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const TahunAjaranCompanion({
    this.id = const Value.absent(),
    this.tahun = const Value.absent(),
    this.semester = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  TahunAjaranCompanion.insert({
    this.id = const Value.absent(),
    required String tahun,
    required int semester,
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : tahun = Value(tahun),
       semester = Value(semester),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<TahunAjaranRow> custom({
    Expression<int>? id,
    Expression<String>? tahun,
    Expression<int>? semester,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tahun != null) 'tahun': tahun,
      if (semester != null) 'semester': semester,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  TahunAjaranCompanion copyWith({
    Value<int>? id,
    Value<String>? tahun,
    Value<int>? semester,
    Value<bool>? isActive,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return TahunAjaranCompanion(
      id: id ?? this.id,
      tahun: tahun ?? this.tahun,
      semester: semester ?? this.semester,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<String>(tahun.value);
    }
    if (semester.present) {
      map['semester'] = Variable<int>(semester.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TahunAjaranCompanion(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('semester: $semester, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $MataKuliahTable extends MataKuliah
    with TableInfo<$MataKuliahTable, MataKuliahRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MataKuliahTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kodeMeta = const VerificationMeta('kode');
  @override
  late final GeneratedColumn<String> kode = GeneratedColumn<String>(
    'kode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sksMeta = const VerificationMeta('sks');
  @override
  late final GeneratedColumn<int> sks = GeneratedColumn<int>(
    'sks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterMeta = const VerificationMeta(
    'semester',
  );
  @override
  late final GeneratedColumn<int> semester = GeneratedColumn<int>(
    'semester',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prodiIdMeta = const VerificationMeta(
    'prodiId',
  );
  @override
  late final GeneratedColumn<int> prodiId = GeneratedColumn<int>(
    'prodi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES prodi (id)',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kode,
    nama,
    sks,
    semester,
    prodiId,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mata_kuliah';
  @override
  VerificationContext validateIntegrity(
    Insertable<MataKuliahRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kode')) {
      context.handle(
        _kodeMeta,
        kode.isAcceptableOrUnknown(data['kode']!, _kodeMeta),
      );
    } else if (isInserting) {
      context.missing(_kodeMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('sks')) {
      context.handle(
        _sksMeta,
        sks.isAcceptableOrUnknown(data['sks']!, _sksMeta),
      );
    } else if (isInserting) {
      context.missing(_sksMeta);
    }
    if (data.containsKey('semester')) {
      context.handle(
        _semesterMeta,
        semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterMeta);
    }
    if (data.containsKey('prodi_id')) {
      context.handle(
        _prodiIdMeta,
        prodiId.isAcceptableOrUnknown(data['prodi_id']!, _prodiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_prodiIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MataKuliahRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MataKuliahRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kode'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      sks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sks'],
      )!,
      semester: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester'],
      )!,
      prodiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prodi_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $MataKuliahTable createAlias(String alias) {
    return $MataKuliahTable(attachedDatabase, alias);
  }
}

class MataKuliahRow extends DataClass implements Insertable<MataKuliahRow> {
  final int id;
  final String kode;
  final String nama;
  final int sks;
  final int semester;
  final int prodiId;
  final DateTime updatedAt;
  final String deviceId;
  const MataKuliahRow({
    required this.id,
    required this.kode,
    required this.nama,
    required this.sks,
    required this.semester,
    required this.prodiId,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kode'] = Variable<String>(kode);
    map['nama'] = Variable<String>(nama);
    map['sks'] = Variable<int>(sks);
    map['semester'] = Variable<int>(semester);
    map['prodi_id'] = Variable<int>(prodiId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  MataKuliahCompanion toCompanion(bool nullToAbsent) {
    return MataKuliahCompanion(
      id: Value(id),
      kode: Value(kode),
      nama: Value(nama),
      sks: Value(sks),
      semester: Value(semester),
      prodiId: Value(prodiId),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory MataKuliahRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MataKuliahRow(
      id: serializer.fromJson<int>(json['id']),
      kode: serializer.fromJson<String>(json['kode']),
      nama: serializer.fromJson<String>(json['nama']),
      sks: serializer.fromJson<int>(json['sks']),
      semester: serializer.fromJson<int>(json['semester']),
      prodiId: serializer.fromJson<int>(json['prodiId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kode': serializer.toJson<String>(kode),
      'nama': serializer.toJson<String>(nama),
      'sks': serializer.toJson<int>(sks),
      'semester': serializer.toJson<int>(semester),
      'prodiId': serializer.toJson<int>(prodiId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  MataKuliahRow copyWith({
    int? id,
    String? kode,
    String? nama,
    int? sks,
    int? semester,
    int? prodiId,
    DateTime? updatedAt,
    String? deviceId,
  }) => MataKuliahRow(
    id: id ?? this.id,
    kode: kode ?? this.kode,
    nama: nama ?? this.nama,
    sks: sks ?? this.sks,
    semester: semester ?? this.semester,
    prodiId: prodiId ?? this.prodiId,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  MataKuliahRow copyWithCompanion(MataKuliahCompanion data) {
    return MataKuliahRow(
      id: data.id.present ? data.id.value : this.id,
      kode: data.kode.present ? data.kode.value : this.kode,
      nama: data.nama.present ? data.nama.value : this.nama,
      sks: data.sks.present ? data.sks.value : this.sks,
      semester: data.semester.present ? data.semester.value : this.semester,
      prodiId: data.prodiId.present ? data.prodiId.value : this.prodiId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MataKuliahRow(')
          ..write('id: $id, ')
          ..write('kode: $kode, ')
          ..write('nama: $nama, ')
          ..write('sks: $sks, ')
          ..write('semester: $semester, ')
          ..write('prodiId: $prodiId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, kode, nama, sks, semester, prodiId, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MataKuliahRow &&
          other.id == this.id &&
          other.kode == this.kode &&
          other.nama == this.nama &&
          other.sks == this.sks &&
          other.semester == this.semester &&
          other.prodiId == this.prodiId &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class MataKuliahCompanion extends UpdateCompanion<MataKuliahRow> {
  final Value<int> id;
  final Value<String> kode;
  final Value<String> nama;
  final Value<int> sks;
  final Value<int> semester;
  final Value<int> prodiId;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const MataKuliahCompanion({
    this.id = const Value.absent(),
    this.kode = const Value.absent(),
    this.nama = const Value.absent(),
    this.sks = const Value.absent(),
    this.semester = const Value.absent(),
    this.prodiId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  MataKuliahCompanion.insert({
    this.id = const Value.absent(),
    required String kode,
    required String nama,
    required int sks,
    required int semester,
    required int prodiId,
    required DateTime updatedAt,
    required String deviceId,
  }) : kode = Value(kode),
       nama = Value(nama),
       sks = Value(sks),
       semester = Value(semester),
       prodiId = Value(prodiId),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<MataKuliahRow> custom({
    Expression<int>? id,
    Expression<String>? kode,
    Expression<String>? nama,
    Expression<int>? sks,
    Expression<int>? semester,
    Expression<int>? prodiId,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kode != null) 'kode': kode,
      if (nama != null) 'nama': nama,
      if (sks != null) 'sks': sks,
      if (semester != null) 'semester': semester,
      if (prodiId != null) 'prodi_id': prodiId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  MataKuliahCompanion copyWith({
    Value<int>? id,
    Value<String>? kode,
    Value<String>? nama,
    Value<int>? sks,
    Value<int>? semester,
    Value<int>? prodiId,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return MataKuliahCompanion(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      sks: sks ?? this.sks,
      semester: semester ?? this.semester,
      prodiId: prodiId ?? this.prodiId,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kode.present) {
      map['kode'] = Variable<String>(kode.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (sks.present) {
      map['sks'] = Variable<int>(sks.value);
    }
    if (semester.present) {
      map['semester'] = Variable<int>(semester.value);
    }
    if (prodiId.present) {
      map['prodi_id'] = Variable<int>(prodiId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MataKuliahCompanion(')
          ..write('id: $id, ')
          ..write('kode: $kode, ')
          ..write('nama: $nama, ')
          ..write('sks: $sks, ')
          ..write('semester: $semester, ')
          ..write('prodiId: $prodiId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $PrasyaratMkTable extends PrasyaratMk
    with TableInfo<$PrasyaratMkTable, PrasyaratMkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrasyaratMkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mkIdMeta = const VerificationMeta('mkId');
  @override
  late final GeneratedColumn<int> mkId = GeneratedColumn<int>(
    'mk_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mata_kuliah (id)',
    ),
  );
  static const VerificationMeta _prasyaratMkIdMeta = const VerificationMeta(
    'prasyaratMkId',
  );
  @override
  late final GeneratedColumn<int> prasyaratMkId = GeneratedColumn<int>(
    'prasyarat_mk_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mata_kuliah (id)',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    mkId,
    prasyaratMkId,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prasyarat_mk';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrasyaratMkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mk_id')) {
      context.handle(
        _mkIdMeta,
        mkId.isAcceptableOrUnknown(data['mk_id']!, _mkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mkIdMeta);
    }
    if (data.containsKey('prasyarat_mk_id')) {
      context.handle(
        _prasyaratMkIdMeta,
        prasyaratMkId.isAcceptableOrUnknown(
          data['prasyarat_mk_id']!,
          _prasyaratMkIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prasyaratMkIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mkId, prasyaratMkId};
  @override
  PrasyaratMkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrasyaratMkRow(
      mkId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mk_id'],
      )!,
      prasyaratMkId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prasyarat_mk_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $PrasyaratMkTable createAlias(String alias) {
    return $PrasyaratMkTable(attachedDatabase, alias);
  }
}

class PrasyaratMkRow extends DataClass implements Insertable<PrasyaratMkRow> {
  final int mkId;
  final int prasyaratMkId;
  final DateTime updatedAt;
  final String deviceId;
  const PrasyaratMkRow({
    required this.mkId,
    required this.prasyaratMkId,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mk_id'] = Variable<int>(mkId);
    map['prasyarat_mk_id'] = Variable<int>(prasyaratMkId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  PrasyaratMkCompanion toCompanion(bool nullToAbsent) {
    return PrasyaratMkCompanion(
      mkId: Value(mkId),
      prasyaratMkId: Value(prasyaratMkId),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory PrasyaratMkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrasyaratMkRow(
      mkId: serializer.fromJson<int>(json['mkId']),
      prasyaratMkId: serializer.fromJson<int>(json['prasyaratMkId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mkId': serializer.toJson<int>(mkId),
      'prasyaratMkId': serializer.toJson<int>(prasyaratMkId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  PrasyaratMkRow copyWith({
    int? mkId,
    int? prasyaratMkId,
    DateTime? updatedAt,
    String? deviceId,
  }) => PrasyaratMkRow(
    mkId: mkId ?? this.mkId,
    prasyaratMkId: prasyaratMkId ?? this.prasyaratMkId,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  PrasyaratMkRow copyWithCompanion(PrasyaratMkCompanion data) {
    return PrasyaratMkRow(
      mkId: data.mkId.present ? data.mkId.value : this.mkId,
      prasyaratMkId: data.prasyaratMkId.present
          ? data.prasyaratMkId.value
          : this.prasyaratMkId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrasyaratMkRow(')
          ..write('mkId: $mkId, ')
          ..write('prasyaratMkId: $prasyaratMkId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mkId, prasyaratMkId, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrasyaratMkRow &&
          other.mkId == this.mkId &&
          other.prasyaratMkId == this.prasyaratMkId &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class PrasyaratMkCompanion extends UpdateCompanion<PrasyaratMkRow> {
  final Value<int> mkId;
  final Value<int> prasyaratMkId;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  final Value<int> rowid;
  const PrasyaratMkCompanion({
    this.mkId = const Value.absent(),
    this.prasyaratMkId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrasyaratMkCompanion.insert({
    required int mkId,
    required int prasyaratMkId,
    required DateTime updatedAt,
    required String deviceId,
    this.rowid = const Value.absent(),
  }) : mkId = Value(mkId),
       prasyaratMkId = Value(prasyaratMkId),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<PrasyaratMkRow> custom({
    Expression<int>? mkId,
    Expression<int>? prasyaratMkId,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mkId != null) 'mk_id': mkId,
      if (prasyaratMkId != null) 'prasyarat_mk_id': prasyaratMkId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrasyaratMkCompanion copyWith({
    Value<int>? mkId,
    Value<int>? prasyaratMkId,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
    Value<int>? rowid,
  }) {
    return PrasyaratMkCompanion(
      mkId: mkId ?? this.mkId,
      prasyaratMkId: prasyaratMkId ?? this.prasyaratMkId,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mkId.present) {
      map['mk_id'] = Variable<int>(mkId.value);
    }
    if (prasyaratMkId.present) {
      map['prasyarat_mk_id'] = Variable<int>(prasyaratMkId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrasyaratMkCompanion(')
          ..write('mkId: $mkId, ')
          ..write('prasyaratMkId: $prasyaratMkId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KelasTable extends Kelas with TableInfo<$KelasTable, KelasRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KelasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mkIdMeta = const VerificationMeta('mkId');
  @override
  late final GeneratedColumn<int> mkId = GeneratedColumn<int>(
    'mk_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mata_kuliah (id)',
    ),
  );
  static const VerificationMeta _dosenIdMeta = const VerificationMeta(
    'dosenId',
  );
  @override
  late final GeneratedColumn<int> dosenId = GeneratedColumn<int>(
    'dosen_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dosens (id)',
    ),
  );
  static const VerificationMeta _taIdMeta = const VerificationMeta('taId');
  @override
  late final GeneratedColumn<int> taId = GeneratedColumn<int>(
    'ta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tahun_ajaran (id)',
    ),
  );
  static const VerificationMeta _hariMeta = const VerificationMeta('hari');
  @override
  late final GeneratedColumn<String> hari = GeneratedColumn<String>(
    'hari',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jamMulaiMeta = const VerificationMeta(
    'jamMulai',
  );
  @override
  late final GeneratedColumn<String> jamMulai = GeneratedColumn<String>(
    'jam_mulai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jamSelesaiMeta = const VerificationMeta(
    'jamSelesai',
  );
  @override
  late final GeneratedColumn<String> jamSelesai = GeneratedColumn<String>(
    'jam_selesai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruangMeta = const VerificationMeta('ruang');
  @override
  late final GeneratedColumn<String> ruang = GeneratedColumn<String>(
    'ruang',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mkId,
    dosenId,
    taId,
    hari,
    jamMulai,
    jamSelesai,
    ruang,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kelas';
  @override
  VerificationContext validateIntegrity(
    Insertable<KelasRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mk_id')) {
      context.handle(
        _mkIdMeta,
        mkId.isAcceptableOrUnknown(data['mk_id']!, _mkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mkIdMeta);
    }
    if (data.containsKey('dosen_id')) {
      context.handle(
        _dosenIdMeta,
        dosenId.isAcceptableOrUnknown(data['dosen_id']!, _dosenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dosenIdMeta);
    }
    if (data.containsKey('ta_id')) {
      context.handle(
        _taIdMeta,
        taId.isAcceptableOrUnknown(data['ta_id']!, _taIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taIdMeta);
    }
    if (data.containsKey('hari')) {
      context.handle(
        _hariMeta,
        hari.isAcceptableOrUnknown(data['hari']!, _hariMeta),
      );
    } else if (isInserting) {
      context.missing(_hariMeta);
    }
    if (data.containsKey('jam_mulai')) {
      context.handle(
        _jamMulaiMeta,
        jamMulai.isAcceptableOrUnknown(data['jam_mulai']!, _jamMulaiMeta),
      );
    } else if (isInserting) {
      context.missing(_jamMulaiMeta);
    }
    if (data.containsKey('jam_selesai')) {
      context.handle(
        _jamSelesaiMeta,
        jamSelesai.isAcceptableOrUnknown(data['jam_selesai']!, _jamSelesaiMeta),
      );
    } else if (isInserting) {
      context.missing(_jamSelesaiMeta);
    }
    if (data.containsKey('ruang')) {
      context.handle(
        _ruangMeta,
        ruang.isAcceptableOrUnknown(data['ruang']!, _ruangMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KelasRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KelasRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mkId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mk_id'],
      )!,
      dosenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dosen_id'],
      )!,
      taId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ta_id'],
      )!,
      hari: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hari'],
      )!,
      jamMulai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jam_mulai'],
      )!,
      jamSelesai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jam_selesai'],
      )!,
      ruang: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ruang'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $KelasTable createAlias(String alias) {
    return $KelasTable(attachedDatabase, alias);
  }
}

class KelasRow extends DataClass implements Insertable<KelasRow> {
  final int id;
  final int mkId;
  final int dosenId;
  final int taId;
  final String hari;
  final String jamMulai;
  final String jamSelesai;
  final String ruang;
  final DateTime updatedAt;
  final String deviceId;
  const KelasRow({
    required this.id,
    required this.mkId,
    required this.dosenId,
    required this.taId,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruang,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mk_id'] = Variable<int>(mkId);
    map['dosen_id'] = Variable<int>(dosenId);
    map['ta_id'] = Variable<int>(taId);
    map['hari'] = Variable<String>(hari);
    map['jam_mulai'] = Variable<String>(jamMulai);
    map['jam_selesai'] = Variable<String>(jamSelesai);
    map['ruang'] = Variable<String>(ruang);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  KelasCompanion toCompanion(bool nullToAbsent) {
    return KelasCompanion(
      id: Value(id),
      mkId: Value(mkId),
      dosenId: Value(dosenId),
      taId: Value(taId),
      hari: Value(hari),
      jamMulai: Value(jamMulai),
      jamSelesai: Value(jamSelesai),
      ruang: Value(ruang),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory KelasRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KelasRow(
      id: serializer.fromJson<int>(json['id']),
      mkId: serializer.fromJson<int>(json['mkId']),
      dosenId: serializer.fromJson<int>(json['dosenId']),
      taId: serializer.fromJson<int>(json['taId']),
      hari: serializer.fromJson<String>(json['hari']),
      jamMulai: serializer.fromJson<String>(json['jamMulai']),
      jamSelesai: serializer.fromJson<String>(json['jamSelesai']),
      ruang: serializer.fromJson<String>(json['ruang']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mkId': serializer.toJson<int>(mkId),
      'dosenId': serializer.toJson<int>(dosenId),
      'taId': serializer.toJson<int>(taId),
      'hari': serializer.toJson<String>(hari),
      'jamMulai': serializer.toJson<String>(jamMulai),
      'jamSelesai': serializer.toJson<String>(jamSelesai),
      'ruang': serializer.toJson<String>(ruang),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  KelasRow copyWith({
    int? id,
    int? mkId,
    int? dosenId,
    int? taId,
    String? hari,
    String? jamMulai,
    String? jamSelesai,
    String? ruang,
    DateTime? updatedAt,
    String? deviceId,
  }) => KelasRow(
    id: id ?? this.id,
    mkId: mkId ?? this.mkId,
    dosenId: dosenId ?? this.dosenId,
    taId: taId ?? this.taId,
    hari: hari ?? this.hari,
    jamMulai: jamMulai ?? this.jamMulai,
    jamSelesai: jamSelesai ?? this.jamSelesai,
    ruang: ruang ?? this.ruang,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  KelasRow copyWithCompanion(KelasCompanion data) {
    return KelasRow(
      id: data.id.present ? data.id.value : this.id,
      mkId: data.mkId.present ? data.mkId.value : this.mkId,
      dosenId: data.dosenId.present ? data.dosenId.value : this.dosenId,
      taId: data.taId.present ? data.taId.value : this.taId,
      hari: data.hari.present ? data.hari.value : this.hari,
      jamMulai: data.jamMulai.present ? data.jamMulai.value : this.jamMulai,
      jamSelesai: data.jamSelesai.present
          ? data.jamSelesai.value
          : this.jamSelesai,
      ruang: data.ruang.present ? data.ruang.value : this.ruang,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KelasRow(')
          ..write('id: $id, ')
          ..write('mkId: $mkId, ')
          ..write('dosenId: $dosenId, ')
          ..write('taId: $taId, ')
          ..write('hari: $hari, ')
          ..write('jamMulai: $jamMulai, ')
          ..write('jamSelesai: $jamSelesai, ')
          ..write('ruang: $ruang, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mkId,
    dosenId,
    taId,
    hari,
    jamMulai,
    jamSelesai,
    ruang,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KelasRow &&
          other.id == this.id &&
          other.mkId == this.mkId &&
          other.dosenId == this.dosenId &&
          other.taId == this.taId &&
          other.hari == this.hari &&
          other.jamMulai == this.jamMulai &&
          other.jamSelesai == this.jamSelesai &&
          other.ruang == this.ruang &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class KelasCompanion extends UpdateCompanion<KelasRow> {
  final Value<int> id;
  final Value<int> mkId;
  final Value<int> dosenId;
  final Value<int> taId;
  final Value<String> hari;
  final Value<String> jamMulai;
  final Value<String> jamSelesai;
  final Value<String> ruang;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const KelasCompanion({
    this.id = const Value.absent(),
    this.mkId = const Value.absent(),
    this.dosenId = const Value.absent(),
    this.taId = const Value.absent(),
    this.hari = const Value.absent(),
    this.jamMulai = const Value.absent(),
    this.jamSelesai = const Value.absent(),
    this.ruang = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  KelasCompanion.insert({
    this.id = const Value.absent(),
    required int mkId,
    required int dosenId,
    required int taId,
    required String hari,
    required String jamMulai,
    required String jamSelesai,
    this.ruang = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : mkId = Value(mkId),
       dosenId = Value(dosenId),
       taId = Value(taId),
       hari = Value(hari),
       jamMulai = Value(jamMulai),
       jamSelesai = Value(jamSelesai),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<KelasRow> custom({
    Expression<int>? id,
    Expression<int>? mkId,
    Expression<int>? dosenId,
    Expression<int>? taId,
    Expression<String>? hari,
    Expression<String>? jamMulai,
    Expression<String>? jamSelesai,
    Expression<String>? ruang,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mkId != null) 'mk_id': mkId,
      if (dosenId != null) 'dosen_id': dosenId,
      if (taId != null) 'ta_id': taId,
      if (hari != null) 'hari': hari,
      if (jamMulai != null) 'jam_mulai': jamMulai,
      if (jamSelesai != null) 'jam_selesai': jamSelesai,
      if (ruang != null) 'ruang': ruang,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  KelasCompanion copyWith({
    Value<int>? id,
    Value<int>? mkId,
    Value<int>? dosenId,
    Value<int>? taId,
    Value<String>? hari,
    Value<String>? jamMulai,
    Value<String>? jamSelesai,
    Value<String>? ruang,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return KelasCompanion(
      id: id ?? this.id,
      mkId: mkId ?? this.mkId,
      dosenId: dosenId ?? this.dosenId,
      taId: taId ?? this.taId,
      hari: hari ?? this.hari,
      jamMulai: jamMulai ?? this.jamMulai,
      jamSelesai: jamSelesai ?? this.jamSelesai,
      ruang: ruang ?? this.ruang,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mkId.present) {
      map['mk_id'] = Variable<int>(mkId.value);
    }
    if (dosenId.present) {
      map['dosen_id'] = Variable<int>(dosenId.value);
    }
    if (taId.present) {
      map['ta_id'] = Variable<int>(taId.value);
    }
    if (hari.present) {
      map['hari'] = Variable<String>(hari.value);
    }
    if (jamMulai.present) {
      map['jam_mulai'] = Variable<String>(jamMulai.value);
    }
    if (jamSelesai.present) {
      map['jam_selesai'] = Variable<String>(jamSelesai.value);
    }
    if (ruang.present) {
      map['ruang'] = Variable<String>(ruang.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KelasCompanion(')
          ..write('id: $id, ')
          ..write('mkId: $mkId, ')
          ..write('dosenId: $dosenId, ')
          ..write('taId: $taId, ')
          ..write('hari: $hari, ')
          ..write('jamMulai: $jamMulai, ')
          ..write('jamSelesai: $jamSelesai, ')
          ..write('ruang: $ruang, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $KrsTable extends Krs with TableInfo<$KrsTable, KrsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KrsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _kelasIdMeta = const VerificationMeta(
    'kelasId',
  );
  @override
  late final GeneratedColumn<int> kelasId = GeneratedColumn<int>(
    'kelas_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kelas (id)',
    ),
  );
  static const VerificationMeta _taIdMeta = const VerificationMeta('taId');
  @override
  late final GeneratedColumn<int> taId = GeneratedColumn<int>(
    'ta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tahun_ajaran (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('diambil'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mahasiswaId,
    kelasId,
    taId,
    status,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'krs';
  @override
  VerificationContext validateIntegrity(
    Insertable<KrsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('kelas_id')) {
      context.handle(
        _kelasIdMeta,
        kelasId.isAcceptableOrUnknown(data['kelas_id']!, _kelasIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kelasIdMeta);
    }
    if (data.containsKey('ta_id')) {
      context.handle(
        _taIdMeta,
        taId.isAcceptableOrUnknown(data['ta_id']!, _taIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KrsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KrsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      kelasId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kelas_id'],
      )!,
      taId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ta_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $KrsTable createAlias(String alias) {
    return $KrsTable(attachedDatabase, alias);
  }
}

class KrsRow extends DataClass implements Insertable<KrsRow> {
  final int id;
  final int mahasiswaId;
  final int kelasId;
  final int taId;
  final String status;
  final DateTime updatedAt;
  final String deviceId;
  const KrsRow({
    required this.id,
    required this.mahasiswaId,
    required this.kelasId,
    required this.taId,
    required this.status,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['kelas_id'] = Variable<int>(kelasId);
    map['ta_id'] = Variable<int>(taId);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  KrsCompanion toCompanion(bool nullToAbsent) {
    return KrsCompanion(
      id: Value(id),
      mahasiswaId: Value(mahasiswaId),
      kelasId: Value(kelasId),
      taId: Value(taId),
      status: Value(status),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory KrsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KrsRow(
      id: serializer.fromJson<int>(json['id']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      kelasId: serializer.fromJson<int>(json['kelasId']),
      taId: serializer.fromJson<int>(json['taId']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'kelasId': serializer.toJson<int>(kelasId),
      'taId': serializer.toJson<int>(taId),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  KrsRow copyWith({
    int? id,
    int? mahasiswaId,
    int? kelasId,
    int? taId,
    String? status,
    DateTime? updatedAt,
    String? deviceId,
  }) => KrsRow(
    id: id ?? this.id,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    kelasId: kelasId ?? this.kelasId,
    taId: taId ?? this.taId,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  KrsRow copyWithCompanion(KrsCompanion data) {
    return KrsRow(
      id: data.id.present ? data.id.value : this.id,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      kelasId: data.kelasId.present ? data.kelasId.value : this.kelasId,
      taId: data.taId.present ? data.taId.value : this.taId,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KrsRow(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('kelasId: $kelasId, ')
          ..write('taId: $taId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mahasiswaId, kelasId, taId, status, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KrsRow &&
          other.id == this.id &&
          other.mahasiswaId == this.mahasiswaId &&
          other.kelasId == this.kelasId &&
          other.taId == this.taId &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class KrsCompanion extends UpdateCompanion<KrsRow> {
  final Value<int> id;
  final Value<int> mahasiswaId;
  final Value<int> kelasId;
  final Value<int> taId;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const KrsCompanion({
    this.id = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.kelasId = const Value.absent(),
    this.taId = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  KrsCompanion.insert({
    this.id = const Value.absent(),
    required int mahasiswaId,
    required int kelasId,
    required int taId,
    this.status = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : mahasiswaId = Value(mahasiswaId),
       kelasId = Value(kelasId),
       taId = Value(taId),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<KrsRow> custom({
    Expression<int>? id,
    Expression<int>? mahasiswaId,
    Expression<int>? kelasId,
    Expression<int>? taId,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (kelasId != null) 'kelas_id': kelasId,
      if (taId != null) 'ta_id': taId,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  KrsCompanion copyWith({
    Value<int>? id,
    Value<int>? mahasiswaId,
    Value<int>? kelasId,
    Value<int>? taId,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return KrsCompanion(
      id: id ?? this.id,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      kelasId: kelasId ?? this.kelasId,
      taId: taId ?? this.taId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (kelasId.present) {
      map['kelas_id'] = Variable<int>(kelasId.value);
    }
    if (taId.present) {
      map['ta_id'] = Variable<int>(taId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KrsCompanion(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('kelasId: $kelasId, ')
          ..write('taId: $taId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $NilaiTable extends Nilai with TableInfo<$NilaiTable, NilaiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NilaiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _krsIdMeta = const VerificationMeta('krsId');
  @override
  late final GeneratedColumn<int> krsId = GeneratedColumn<int>(
    'krs_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES krs (id)',
    ),
  );
  static const VerificationMeta _tugasMeta = const VerificationMeta('tugas');
  @override
  late final GeneratedColumn<double> tugas = GeneratedColumn<double>(
    'tugas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _utsMeta = const VerificationMeta('uts');
  @override
  late final GeneratedColumn<double> uts = GeneratedColumn<double>(
    'uts',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _uasMeta = const VerificationMeta('uas');
  @override
  late final GeneratedColumn<double> uas = GeneratedColumn<double>(
    'uas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nilaiAkhirMeta = const VerificationMeta(
    'nilaiAkhir',
  );
  @override
  late final GeneratedColumn<double> nilaiAkhir = GeneratedColumn<double>(
    'nilai_akhir',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hurufMeta = const VerificationMeta('huruf');
  @override
  late final GeneratedColumn<String> huruf = GeneratedColumn<String>(
    'huruf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('E'),
  );
  static const VerificationMeta _bobotMeta = const VerificationMeta('bobot');
  @override
  late final GeneratedColumn<double> bobot = GeneratedColumn<double>(
    'bobot',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    krsId,
    tugas,
    uts,
    uas,
    nilaiAkhir,
    huruf,
    bobot,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nilai';
  @override
  VerificationContext validateIntegrity(
    Insertable<NilaiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('krs_id')) {
      context.handle(
        _krsIdMeta,
        krsId.isAcceptableOrUnknown(data['krs_id']!, _krsIdMeta),
      );
    } else if (isInserting) {
      context.missing(_krsIdMeta);
    }
    if (data.containsKey('tugas')) {
      context.handle(
        _tugasMeta,
        tugas.isAcceptableOrUnknown(data['tugas']!, _tugasMeta),
      );
    }
    if (data.containsKey('uts')) {
      context.handle(
        _utsMeta,
        uts.isAcceptableOrUnknown(data['uts']!, _utsMeta),
      );
    }
    if (data.containsKey('uas')) {
      context.handle(
        _uasMeta,
        uas.isAcceptableOrUnknown(data['uas']!, _uasMeta),
      );
    }
    if (data.containsKey('nilai_akhir')) {
      context.handle(
        _nilaiAkhirMeta,
        nilaiAkhir.isAcceptableOrUnknown(data['nilai_akhir']!, _nilaiAkhirMeta),
      );
    }
    if (data.containsKey('huruf')) {
      context.handle(
        _hurufMeta,
        huruf.isAcceptableOrUnknown(data['huruf']!, _hurufMeta),
      );
    }
    if (data.containsKey('bobot')) {
      context.handle(
        _bobotMeta,
        bobot.isAcceptableOrUnknown(data['bobot']!, _bobotMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NilaiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NilaiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      krsId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}krs_id'],
      )!,
      tugas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tugas'],
      )!,
      uts: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uts'],
      )!,
      uas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uas'],
      )!,
      nilaiAkhir: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}nilai_akhir'],
      )!,
      huruf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}huruf'],
      )!,
      bobot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bobot'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $NilaiTable createAlias(String alias) {
    return $NilaiTable(attachedDatabase, alias);
  }
}

class NilaiRow extends DataClass implements Insertable<NilaiRow> {
  final int id;
  final int krsId;
  final double tugas;
  final double uts;
  final double uas;
  final double nilaiAkhir;
  final String huruf;
  final double bobot;
  final DateTime updatedAt;
  final String deviceId;
  const NilaiRow({
    required this.id,
    required this.krsId,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.nilaiAkhir,
    required this.huruf,
    required this.bobot,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['krs_id'] = Variable<int>(krsId);
    map['tugas'] = Variable<double>(tugas);
    map['uts'] = Variable<double>(uts);
    map['uas'] = Variable<double>(uas);
    map['nilai_akhir'] = Variable<double>(nilaiAkhir);
    map['huruf'] = Variable<String>(huruf);
    map['bobot'] = Variable<double>(bobot);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  NilaiCompanion toCompanion(bool nullToAbsent) {
    return NilaiCompanion(
      id: Value(id),
      krsId: Value(krsId),
      tugas: Value(tugas),
      uts: Value(uts),
      uas: Value(uas),
      nilaiAkhir: Value(nilaiAkhir),
      huruf: Value(huruf),
      bobot: Value(bobot),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory NilaiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NilaiRow(
      id: serializer.fromJson<int>(json['id']),
      krsId: serializer.fromJson<int>(json['krsId']),
      tugas: serializer.fromJson<double>(json['tugas']),
      uts: serializer.fromJson<double>(json['uts']),
      uas: serializer.fromJson<double>(json['uas']),
      nilaiAkhir: serializer.fromJson<double>(json['nilaiAkhir']),
      huruf: serializer.fromJson<String>(json['huruf']),
      bobot: serializer.fromJson<double>(json['bobot']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'krsId': serializer.toJson<int>(krsId),
      'tugas': serializer.toJson<double>(tugas),
      'uts': serializer.toJson<double>(uts),
      'uas': serializer.toJson<double>(uas),
      'nilaiAkhir': serializer.toJson<double>(nilaiAkhir),
      'huruf': serializer.toJson<String>(huruf),
      'bobot': serializer.toJson<double>(bobot),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  NilaiRow copyWith({
    int? id,
    int? krsId,
    double? tugas,
    double? uts,
    double? uas,
    double? nilaiAkhir,
    String? huruf,
    double? bobot,
    DateTime? updatedAt,
    String? deviceId,
  }) => NilaiRow(
    id: id ?? this.id,
    krsId: krsId ?? this.krsId,
    tugas: tugas ?? this.tugas,
    uts: uts ?? this.uts,
    uas: uas ?? this.uas,
    nilaiAkhir: nilaiAkhir ?? this.nilaiAkhir,
    huruf: huruf ?? this.huruf,
    bobot: bobot ?? this.bobot,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  NilaiRow copyWithCompanion(NilaiCompanion data) {
    return NilaiRow(
      id: data.id.present ? data.id.value : this.id,
      krsId: data.krsId.present ? data.krsId.value : this.krsId,
      tugas: data.tugas.present ? data.tugas.value : this.tugas,
      uts: data.uts.present ? data.uts.value : this.uts,
      uas: data.uas.present ? data.uas.value : this.uas,
      nilaiAkhir: data.nilaiAkhir.present
          ? data.nilaiAkhir.value
          : this.nilaiAkhir,
      huruf: data.huruf.present ? data.huruf.value : this.huruf,
      bobot: data.bobot.present ? data.bobot.value : this.bobot,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NilaiRow(')
          ..write('id: $id, ')
          ..write('krsId: $krsId, ')
          ..write('tugas: $tugas, ')
          ..write('uts: $uts, ')
          ..write('uas: $uas, ')
          ..write('nilaiAkhir: $nilaiAkhir, ')
          ..write('huruf: $huruf, ')
          ..write('bobot: $bobot, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    krsId,
    tugas,
    uts,
    uas,
    nilaiAkhir,
    huruf,
    bobot,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NilaiRow &&
          other.id == this.id &&
          other.krsId == this.krsId &&
          other.tugas == this.tugas &&
          other.uts == this.uts &&
          other.uas == this.uas &&
          other.nilaiAkhir == this.nilaiAkhir &&
          other.huruf == this.huruf &&
          other.bobot == this.bobot &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class NilaiCompanion extends UpdateCompanion<NilaiRow> {
  final Value<int> id;
  final Value<int> krsId;
  final Value<double> tugas;
  final Value<double> uts;
  final Value<double> uas;
  final Value<double> nilaiAkhir;
  final Value<String> huruf;
  final Value<double> bobot;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const NilaiCompanion({
    this.id = const Value.absent(),
    this.krsId = const Value.absent(),
    this.tugas = const Value.absent(),
    this.uts = const Value.absent(),
    this.uas = const Value.absent(),
    this.nilaiAkhir = const Value.absent(),
    this.huruf = const Value.absent(),
    this.bobot = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  NilaiCompanion.insert({
    this.id = const Value.absent(),
    required int krsId,
    this.tugas = const Value.absent(),
    this.uts = const Value.absent(),
    this.uas = const Value.absent(),
    this.nilaiAkhir = const Value.absent(),
    this.huruf = const Value.absent(),
    this.bobot = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : krsId = Value(krsId),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<NilaiRow> custom({
    Expression<int>? id,
    Expression<int>? krsId,
    Expression<double>? tugas,
    Expression<double>? uts,
    Expression<double>? uas,
    Expression<double>? nilaiAkhir,
    Expression<String>? huruf,
    Expression<double>? bobot,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (krsId != null) 'krs_id': krsId,
      if (tugas != null) 'tugas': tugas,
      if (uts != null) 'uts': uts,
      if (uas != null) 'uas': uas,
      if (nilaiAkhir != null) 'nilai_akhir': nilaiAkhir,
      if (huruf != null) 'huruf': huruf,
      if (bobot != null) 'bobot': bobot,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  NilaiCompanion copyWith({
    Value<int>? id,
    Value<int>? krsId,
    Value<double>? tugas,
    Value<double>? uts,
    Value<double>? uas,
    Value<double>? nilaiAkhir,
    Value<String>? huruf,
    Value<double>? bobot,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return NilaiCompanion(
      id: id ?? this.id,
      krsId: krsId ?? this.krsId,
      tugas: tugas ?? this.tugas,
      uts: uts ?? this.uts,
      uas: uas ?? this.uas,
      nilaiAkhir: nilaiAkhir ?? this.nilaiAkhir,
      huruf: huruf ?? this.huruf,
      bobot: bobot ?? this.bobot,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (krsId.present) {
      map['krs_id'] = Variable<int>(krsId.value);
    }
    if (tugas.present) {
      map['tugas'] = Variable<double>(tugas.value);
    }
    if (uts.present) {
      map['uts'] = Variable<double>(uts.value);
    }
    if (uas.present) {
      map['uas'] = Variable<double>(uas.value);
    }
    if (nilaiAkhir.present) {
      map['nilai_akhir'] = Variable<double>(nilaiAkhir.value);
    }
    if (huruf.present) {
      map['huruf'] = Variable<String>(huruf.value);
    }
    if (bobot.present) {
      map['bobot'] = Variable<double>(bobot.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NilaiCompanion(')
          ..write('id: $id, ')
          ..write('krsId: $krsId, ')
          ..write('tugas: $tugas, ')
          ..write('uts: $uts, ')
          ..write('uas: $uas, ')
          ..write('nilaiAkhir: $nilaiAkhir, ')
          ..write('huruf: $huruf, ')
          ..write('bobot: $bobot, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $SesiPresensiTable extends SesiPresensi
    with TableInfo<$SesiPresensiTable, SesiPresensiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SesiPresensiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kelasIdMeta = const VerificationMeta(
    'kelasId',
  );
  @override
  late final GeneratedColumn<int> kelasId = GeneratedColumn<int>(
    'kelas_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kelas (id)',
    ),
  );
  static const VerificationMeta _pertemuanKeMeta = const VerificationMeta(
    'pertemuanKe',
  );
  @override
  late final GeneratedColumn<int> pertemuanKe = GeneratedColumn<int>(
    'pertemuan_ke',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrSecretMeta = const VerificationMeta(
    'qrSecret',
  );
  @override
  late final GeneratedColumn<String> qrSecret = GeneratedColumn<String>(
    'qr_secret',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibukaSampaiMeta = const VerificationMeta(
    'dibukaSampai',
  );
  @override
  late final GeneratedColumn<DateTime> dibukaSampai = GeneratedColumn<DateTime>(
    'dibuka_sampai',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kelasId,
    pertemuanKe,
    tanggal,
    qrSecret,
    dibukaSampai,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sesi_presensi';
  @override
  VerificationContext validateIntegrity(
    Insertable<SesiPresensiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kelas_id')) {
      context.handle(
        _kelasIdMeta,
        kelasId.isAcceptableOrUnknown(data['kelas_id']!, _kelasIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kelasIdMeta);
    }
    if (data.containsKey('pertemuan_ke')) {
      context.handle(
        _pertemuanKeMeta,
        pertemuanKe.isAcceptableOrUnknown(
          data['pertemuan_ke']!,
          _pertemuanKeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pertemuanKeMeta);
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('qr_secret')) {
      context.handle(
        _qrSecretMeta,
        qrSecret.isAcceptableOrUnknown(data['qr_secret']!, _qrSecretMeta),
      );
    } else if (isInserting) {
      context.missing(_qrSecretMeta);
    }
    if (data.containsKey('dibuka_sampai')) {
      context.handle(
        _dibukaSampaiMeta,
        dibukaSampai.isAcceptableOrUnknown(
          data['dibuka_sampai']!,
          _dibukaSampaiMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SesiPresensiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SesiPresensiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kelasId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kelas_id'],
      )!,
      pertemuanKe: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pertemuan_ke'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      qrSecret: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_secret'],
      )!,
      dibukaSampai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuka_sampai'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $SesiPresensiTable createAlias(String alias) {
    return $SesiPresensiTable(attachedDatabase, alias);
  }
}

class SesiPresensiRow extends DataClass implements Insertable<SesiPresensiRow> {
  final int id;
  final int kelasId;
  final int pertemuanKe;
  final DateTime tanggal;
  final String qrSecret;
  final DateTime? dibukaSampai;
  final DateTime updatedAt;
  final String deviceId;
  const SesiPresensiRow({
    required this.id,
    required this.kelasId,
    required this.pertemuanKe,
    required this.tanggal,
    required this.qrSecret,
    this.dibukaSampai,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kelas_id'] = Variable<int>(kelasId);
    map['pertemuan_ke'] = Variable<int>(pertemuanKe);
    map['tanggal'] = Variable<DateTime>(tanggal);
    map['qr_secret'] = Variable<String>(qrSecret);
    if (!nullToAbsent || dibukaSampai != null) {
      map['dibuka_sampai'] = Variable<DateTime>(dibukaSampai);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  SesiPresensiCompanion toCompanion(bool nullToAbsent) {
    return SesiPresensiCompanion(
      id: Value(id),
      kelasId: Value(kelasId),
      pertemuanKe: Value(pertemuanKe),
      tanggal: Value(tanggal),
      qrSecret: Value(qrSecret),
      dibukaSampai: dibukaSampai == null && nullToAbsent
          ? const Value.absent()
          : Value(dibukaSampai),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory SesiPresensiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SesiPresensiRow(
      id: serializer.fromJson<int>(json['id']),
      kelasId: serializer.fromJson<int>(json['kelasId']),
      pertemuanKe: serializer.fromJson<int>(json['pertemuanKe']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      qrSecret: serializer.fromJson<String>(json['qrSecret']),
      dibukaSampai: serializer.fromJson<DateTime?>(json['dibukaSampai']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kelasId': serializer.toJson<int>(kelasId),
      'pertemuanKe': serializer.toJson<int>(pertemuanKe),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'qrSecret': serializer.toJson<String>(qrSecret),
      'dibukaSampai': serializer.toJson<DateTime?>(dibukaSampai),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  SesiPresensiRow copyWith({
    int? id,
    int? kelasId,
    int? pertemuanKe,
    DateTime? tanggal,
    String? qrSecret,
    Value<DateTime?> dibukaSampai = const Value.absent(),
    DateTime? updatedAt,
    String? deviceId,
  }) => SesiPresensiRow(
    id: id ?? this.id,
    kelasId: kelasId ?? this.kelasId,
    pertemuanKe: pertemuanKe ?? this.pertemuanKe,
    tanggal: tanggal ?? this.tanggal,
    qrSecret: qrSecret ?? this.qrSecret,
    dibukaSampai: dibukaSampai.present ? dibukaSampai.value : this.dibukaSampai,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  SesiPresensiRow copyWithCompanion(SesiPresensiCompanion data) {
    return SesiPresensiRow(
      id: data.id.present ? data.id.value : this.id,
      kelasId: data.kelasId.present ? data.kelasId.value : this.kelasId,
      pertemuanKe: data.pertemuanKe.present
          ? data.pertemuanKe.value
          : this.pertemuanKe,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      qrSecret: data.qrSecret.present ? data.qrSecret.value : this.qrSecret,
      dibukaSampai: data.dibukaSampai.present
          ? data.dibukaSampai.value
          : this.dibukaSampai,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SesiPresensiRow(')
          ..write('id: $id, ')
          ..write('kelasId: $kelasId, ')
          ..write('pertemuanKe: $pertemuanKe, ')
          ..write('tanggal: $tanggal, ')
          ..write('qrSecret: $qrSecret, ')
          ..write('dibukaSampai: $dibukaSampai, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kelasId,
    pertemuanKe,
    tanggal,
    qrSecret,
    dibukaSampai,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SesiPresensiRow &&
          other.id == this.id &&
          other.kelasId == this.kelasId &&
          other.pertemuanKe == this.pertemuanKe &&
          other.tanggal == this.tanggal &&
          other.qrSecret == this.qrSecret &&
          other.dibukaSampai == this.dibukaSampai &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class SesiPresensiCompanion extends UpdateCompanion<SesiPresensiRow> {
  final Value<int> id;
  final Value<int> kelasId;
  final Value<int> pertemuanKe;
  final Value<DateTime> tanggal;
  final Value<String> qrSecret;
  final Value<DateTime?> dibukaSampai;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const SesiPresensiCompanion({
    this.id = const Value.absent(),
    this.kelasId = const Value.absent(),
    this.pertemuanKe = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.qrSecret = const Value.absent(),
    this.dibukaSampai = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  SesiPresensiCompanion.insert({
    this.id = const Value.absent(),
    required int kelasId,
    required int pertemuanKe,
    required DateTime tanggal,
    required String qrSecret,
    this.dibukaSampai = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : kelasId = Value(kelasId),
       pertemuanKe = Value(pertemuanKe),
       tanggal = Value(tanggal),
       qrSecret = Value(qrSecret),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<SesiPresensiRow> custom({
    Expression<int>? id,
    Expression<int>? kelasId,
    Expression<int>? pertemuanKe,
    Expression<DateTime>? tanggal,
    Expression<String>? qrSecret,
    Expression<DateTime>? dibukaSampai,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kelasId != null) 'kelas_id': kelasId,
      if (pertemuanKe != null) 'pertemuan_ke': pertemuanKe,
      if (tanggal != null) 'tanggal': tanggal,
      if (qrSecret != null) 'qr_secret': qrSecret,
      if (dibukaSampai != null) 'dibuka_sampai': dibukaSampai,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  SesiPresensiCompanion copyWith({
    Value<int>? id,
    Value<int>? kelasId,
    Value<int>? pertemuanKe,
    Value<DateTime>? tanggal,
    Value<String>? qrSecret,
    Value<DateTime?>? dibukaSampai,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return SesiPresensiCompanion(
      id: id ?? this.id,
      kelasId: kelasId ?? this.kelasId,
      pertemuanKe: pertemuanKe ?? this.pertemuanKe,
      tanggal: tanggal ?? this.tanggal,
      qrSecret: qrSecret ?? this.qrSecret,
      dibukaSampai: dibukaSampai ?? this.dibukaSampai,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kelasId.present) {
      map['kelas_id'] = Variable<int>(kelasId.value);
    }
    if (pertemuanKe.present) {
      map['pertemuan_ke'] = Variable<int>(pertemuanKe.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (qrSecret.present) {
      map['qr_secret'] = Variable<String>(qrSecret.value);
    }
    if (dibukaSampai.present) {
      map['dibuka_sampai'] = Variable<DateTime>(dibukaSampai.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SesiPresensiCompanion(')
          ..write('id: $id, ')
          ..write('kelasId: $kelasId, ')
          ..write('pertemuanKe: $pertemuanKe, ')
          ..write('tanggal: $tanggal, ')
          ..write('qrSecret: $qrSecret, ')
          ..write('dibukaSampai: $dibukaSampai, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $PresensiTable extends Presensi
    with TableInfo<$PresensiTable, PresensiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PresensiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sesiIdMeta = const VerificationMeta('sesiId');
  @override
  late final GeneratedColumn<int> sesiId = GeneratedColumn<int>(
    'sesi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sesi_presensi (id)',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metodeMeta = const VerificationMeta('metode');
  @override
  late final GeneratedColumn<String> metode = GeneratedColumn<String>(
    'metode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sesiId,
    mahasiswaId,
    status,
    metode,
    waktu,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'presensi';
  @override
  VerificationContext validateIntegrity(
    Insertable<PresensiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sesi_id')) {
      context.handle(
        _sesiIdMeta,
        sesiId.isAcceptableOrUnknown(data['sesi_id']!, _sesiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sesiIdMeta);
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('metode')) {
      context.handle(
        _metodeMeta,
        metode.isAcceptableOrUnknown(data['metode']!, _metodeMeta),
      );
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sesiId, mahasiswaId},
  ];
  @override
  PresensiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PresensiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sesiId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sesi_id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      metode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metode'],
      )!,
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $PresensiTable createAlias(String alias) {
    return $PresensiTable(attachedDatabase, alias);
  }
}

class PresensiRow extends DataClass implements Insertable<PresensiRow> {
  final int id;
  final int sesiId;
  final int mahasiswaId;
  final String status;
  final String metode;
  final DateTime waktu;
  final DateTime updatedAt;
  final String deviceId;
  const PresensiRow({
    required this.id,
    required this.sesiId,
    required this.mahasiswaId,
    required this.status,
    required this.metode,
    required this.waktu,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sesi_id'] = Variable<int>(sesiId);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['status'] = Variable<String>(status);
    map['metode'] = Variable<String>(metode);
    map['waktu'] = Variable<DateTime>(waktu);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  PresensiCompanion toCompanion(bool nullToAbsent) {
    return PresensiCompanion(
      id: Value(id),
      sesiId: Value(sesiId),
      mahasiswaId: Value(mahasiswaId),
      status: Value(status),
      metode: Value(metode),
      waktu: Value(waktu),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory PresensiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PresensiRow(
      id: serializer.fromJson<int>(json['id']),
      sesiId: serializer.fromJson<int>(json['sesiId']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      status: serializer.fromJson<String>(json['status']),
      metode: serializer.fromJson<String>(json['metode']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sesiId': serializer.toJson<int>(sesiId),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'status': serializer.toJson<String>(status),
      'metode': serializer.toJson<String>(metode),
      'waktu': serializer.toJson<DateTime>(waktu),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  PresensiRow copyWith({
    int? id,
    int? sesiId,
    int? mahasiswaId,
    String? status,
    String? metode,
    DateTime? waktu,
    DateTime? updatedAt,
    String? deviceId,
  }) => PresensiRow(
    id: id ?? this.id,
    sesiId: sesiId ?? this.sesiId,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    status: status ?? this.status,
    metode: metode ?? this.metode,
    waktu: waktu ?? this.waktu,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  PresensiRow copyWithCompanion(PresensiCompanion data) {
    return PresensiRow(
      id: data.id.present ? data.id.value : this.id,
      sesiId: data.sesiId.present ? data.sesiId.value : this.sesiId,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      status: data.status.present ? data.status.value : this.status,
      metode: data.metode.present ? data.metode.value : this.metode,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PresensiRow(')
          ..write('id: $id, ')
          ..write('sesiId: $sesiId, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('status: $status, ')
          ..write('metode: $metode, ')
          ..write('waktu: $waktu, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sesiId,
    mahasiswaId,
    status,
    metode,
    waktu,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresensiRow &&
          other.id == this.id &&
          other.sesiId == this.sesiId &&
          other.mahasiswaId == this.mahasiswaId &&
          other.status == this.status &&
          other.metode == this.metode &&
          other.waktu == this.waktu &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class PresensiCompanion extends UpdateCompanion<PresensiRow> {
  final Value<int> id;
  final Value<int> sesiId;
  final Value<int> mahasiswaId;
  final Value<String> status;
  final Value<String> metode;
  final Value<DateTime> waktu;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const PresensiCompanion({
    this.id = const Value.absent(),
    this.sesiId = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.status = const Value.absent(),
    this.metode = const Value.absent(),
    this.waktu = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  PresensiCompanion.insert({
    this.id = const Value.absent(),
    required int sesiId,
    required int mahasiswaId,
    required String status,
    this.metode = const Value.absent(),
    required DateTime waktu,
    required DateTime updatedAt,
    required String deviceId,
  }) : sesiId = Value(sesiId),
       mahasiswaId = Value(mahasiswaId),
       status = Value(status),
       waktu = Value(waktu),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<PresensiRow> custom({
    Expression<int>? id,
    Expression<int>? sesiId,
    Expression<int>? mahasiswaId,
    Expression<String>? status,
    Expression<String>? metode,
    Expression<DateTime>? waktu,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sesiId != null) 'sesi_id': sesiId,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (status != null) 'status': status,
      if (metode != null) 'metode': metode,
      if (waktu != null) 'waktu': waktu,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  PresensiCompanion copyWith({
    Value<int>? id,
    Value<int>? sesiId,
    Value<int>? mahasiswaId,
    Value<String>? status,
    Value<String>? metode,
    Value<DateTime>? waktu,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return PresensiCompanion(
      id: id ?? this.id,
      sesiId: sesiId ?? this.sesiId,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      status: status ?? this.status,
      metode: metode ?? this.metode,
      waktu: waktu ?? this.waktu,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sesiId.present) {
      map['sesi_id'] = Variable<int>(sesiId.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (metode.present) {
      map['metode'] = Variable<String>(metode.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresensiCompanion(')
          ..write('id: $id, ')
          ..write('sesiId: $sesiId, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('status: $status, ')
          ..write('metode: $metode, ')
          ..write('waktu: $waktu, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $CatatanBimbinganTable extends CatatanBimbingan
    with TableInfo<$CatatanBimbinganTable, CatatanBimbinganRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatatanBimbinganTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _dosenIdMeta = const VerificationMeta(
    'dosenId',
  );
  @override
  late final GeneratedColumn<int> dosenId = GeneratedColumn<int>(
    'dosen_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dosens (id)',
    ),
  );
  static const VerificationMeta _isiMeta = const VerificationMeta('isi');
  @override
  late final GeneratedColumn<String> isi = GeneratedColumn<String>(
    'isi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tindakLanjutMeta = const VerificationMeta(
    'tindakLanjut',
  );
  @override
  late final GeneratedColumn<String> tindakLanjut = GeneratedColumn<String>(
    'tindak_lanjut',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mahasiswaId,
    dosenId,
    isi,
    tindakLanjut,
    tanggal,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catatan_bimbingan';
  @override
  VerificationContext validateIntegrity(
    Insertable<CatatanBimbinganRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('dosen_id')) {
      context.handle(
        _dosenIdMeta,
        dosenId.isAcceptableOrUnknown(data['dosen_id']!, _dosenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dosenIdMeta);
    }
    if (data.containsKey('isi')) {
      context.handle(
        _isiMeta,
        isi.isAcceptableOrUnknown(data['isi']!, _isiMeta),
      );
    } else if (isInserting) {
      context.missing(_isiMeta);
    }
    if (data.containsKey('tindak_lanjut')) {
      context.handle(
        _tindakLanjutMeta,
        tindakLanjut.isAcceptableOrUnknown(
          data['tindak_lanjut']!,
          _tindakLanjutMeta,
        ),
      );
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatatanBimbinganRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatatanBimbinganRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      dosenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dosen_id'],
      )!,
      isi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isi'],
      )!,
      tindakLanjut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tindak_lanjut'],
      ),
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $CatatanBimbinganTable createAlias(String alias) {
    return $CatatanBimbinganTable(attachedDatabase, alias);
  }
}

class CatatanBimbinganRow extends DataClass
    implements Insertable<CatatanBimbinganRow> {
  final int id;
  final int mahasiswaId;
  final int dosenId;
  final String isi;
  final String? tindakLanjut;
  final DateTime tanggal;
  final DateTime updatedAt;
  final String deviceId;
  const CatatanBimbinganRow({
    required this.id,
    required this.mahasiswaId,
    required this.dosenId,
    required this.isi,
    this.tindakLanjut,
    required this.tanggal,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['dosen_id'] = Variable<int>(dosenId);
    map['isi'] = Variable<String>(isi);
    if (!nullToAbsent || tindakLanjut != null) {
      map['tindak_lanjut'] = Variable<String>(tindakLanjut);
    }
    map['tanggal'] = Variable<DateTime>(tanggal);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  CatatanBimbinganCompanion toCompanion(bool nullToAbsent) {
    return CatatanBimbinganCompanion(
      id: Value(id),
      mahasiswaId: Value(mahasiswaId),
      dosenId: Value(dosenId),
      isi: Value(isi),
      tindakLanjut: tindakLanjut == null && nullToAbsent
          ? const Value.absent()
          : Value(tindakLanjut),
      tanggal: Value(tanggal),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory CatatanBimbinganRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatatanBimbinganRow(
      id: serializer.fromJson<int>(json['id']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      dosenId: serializer.fromJson<int>(json['dosenId']),
      isi: serializer.fromJson<String>(json['isi']),
      tindakLanjut: serializer.fromJson<String?>(json['tindakLanjut']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'dosenId': serializer.toJson<int>(dosenId),
      'isi': serializer.toJson<String>(isi),
      'tindakLanjut': serializer.toJson<String?>(tindakLanjut),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  CatatanBimbinganRow copyWith({
    int? id,
    int? mahasiswaId,
    int? dosenId,
    String? isi,
    Value<String?> tindakLanjut = const Value.absent(),
    DateTime? tanggal,
    DateTime? updatedAt,
    String? deviceId,
  }) => CatatanBimbinganRow(
    id: id ?? this.id,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    dosenId: dosenId ?? this.dosenId,
    isi: isi ?? this.isi,
    tindakLanjut: tindakLanjut.present ? tindakLanjut.value : this.tindakLanjut,
    tanggal: tanggal ?? this.tanggal,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  CatatanBimbinganRow copyWithCompanion(CatatanBimbinganCompanion data) {
    return CatatanBimbinganRow(
      id: data.id.present ? data.id.value : this.id,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      dosenId: data.dosenId.present ? data.dosenId.value : this.dosenId,
      isi: data.isi.present ? data.isi.value : this.isi,
      tindakLanjut: data.tindakLanjut.present
          ? data.tindakLanjut.value
          : this.tindakLanjut,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatatanBimbinganRow(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('dosenId: $dosenId, ')
          ..write('isi: $isi, ')
          ..write('tindakLanjut: $tindakLanjut, ')
          ..write('tanggal: $tanggal, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mahasiswaId,
    dosenId,
    isi,
    tindakLanjut,
    tanggal,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatatanBimbinganRow &&
          other.id == this.id &&
          other.mahasiswaId == this.mahasiswaId &&
          other.dosenId == this.dosenId &&
          other.isi == this.isi &&
          other.tindakLanjut == this.tindakLanjut &&
          other.tanggal == this.tanggal &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class CatatanBimbinganCompanion extends UpdateCompanion<CatatanBimbinganRow> {
  final Value<int> id;
  final Value<int> mahasiswaId;
  final Value<int> dosenId;
  final Value<String> isi;
  final Value<String?> tindakLanjut;
  final Value<DateTime> tanggal;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const CatatanBimbinganCompanion({
    this.id = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.dosenId = const Value.absent(),
    this.isi = const Value.absent(),
    this.tindakLanjut = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  CatatanBimbinganCompanion.insert({
    this.id = const Value.absent(),
    required int mahasiswaId,
    required int dosenId,
    required String isi,
    this.tindakLanjut = const Value.absent(),
    required DateTime tanggal,
    required DateTime updatedAt,
    required String deviceId,
  }) : mahasiswaId = Value(mahasiswaId),
       dosenId = Value(dosenId),
       isi = Value(isi),
       tanggal = Value(tanggal),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<CatatanBimbinganRow> custom({
    Expression<int>? id,
    Expression<int>? mahasiswaId,
    Expression<int>? dosenId,
    Expression<String>? isi,
    Expression<String>? tindakLanjut,
    Expression<DateTime>? tanggal,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (dosenId != null) 'dosen_id': dosenId,
      if (isi != null) 'isi': isi,
      if (tindakLanjut != null) 'tindak_lanjut': tindakLanjut,
      if (tanggal != null) 'tanggal': tanggal,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  CatatanBimbinganCompanion copyWith({
    Value<int>? id,
    Value<int>? mahasiswaId,
    Value<int>? dosenId,
    Value<String>? isi,
    Value<String?>? tindakLanjut,
    Value<DateTime>? tanggal,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return CatatanBimbinganCompanion(
      id: id ?? this.id,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      dosenId: dosenId ?? this.dosenId,
      isi: isi ?? this.isi,
      tindakLanjut: tindakLanjut ?? this.tindakLanjut,
      tanggal: tanggal ?? this.tanggal,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (dosenId.present) {
      map['dosen_id'] = Variable<int>(dosenId.value);
    }
    if (isi.present) {
      map['isi'] = Variable<String>(isi.value);
    }
    if (tindakLanjut.present) {
      map['tindak_lanjut'] = Variable<String>(tindakLanjut.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatatanBimbinganCompanion(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('dosenId: $dosenId, ')
          ..write('isi: $isi, ')
          ..write('tindakLanjut: $tindakLanjut, ')
          ..write('tanggal: $tanggal, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $PeringatanTable extends Peringatan
    with TableInfo<$PeringatanTable, PeringatanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeringatanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
    'jenis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skorMeta = const VerificationMeta('skor');
  @override
  late final GeneratedColumn<double> skor = GeneratedColumn<double>(
    'skor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ditanganiMeta = const VerificationMeta(
    'ditangani',
  );
  @override
  late final GeneratedColumn<bool> ditangani = GeneratedColumn<bool>(
    'ditangani',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ditangani" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mahasiswaId,
    jenis,
    skor,
    detail,
    dibuatPada,
    ditangani,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'peringatan';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeringatanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
        _jenisMeta,
        jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta),
      );
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('skor')) {
      context.handle(
        _skorMeta,
        skor.isAcceptableOrUnknown(data['skor']!, _skorMeta),
      );
    } else if (isInserting) {
      context.missing(_skorMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    if (data.containsKey('ditangani')) {
      context.handle(
        _ditanganiMeta,
        ditangani.isAcceptableOrUnknown(data['ditangani']!, _ditanganiMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeringatanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeringatanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      jenis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jenis'],
      )!,
      skor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}skor'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
      ditangani: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ditangani'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $PeringatanTable createAlias(String alias) {
    return $PeringatanTable(attachedDatabase, alias);
  }
}

class PeringatanRow extends DataClass implements Insertable<PeringatanRow> {
  final int id;
  final int mahasiswaId;
  final String jenis;
  final double skor;
  final String detail;
  final DateTime dibuatPada;
  final bool ditangani;
  final DateTime updatedAt;
  final String deviceId;
  const PeringatanRow({
    required this.id,
    required this.mahasiswaId,
    required this.jenis,
    required this.skor,
    required this.detail,
    required this.dibuatPada,
    required this.ditangani,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['jenis'] = Variable<String>(jenis);
    map['skor'] = Variable<double>(skor);
    map['detail'] = Variable<String>(detail);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    map['ditangani'] = Variable<bool>(ditangani);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  PeringatanCompanion toCompanion(bool nullToAbsent) {
    return PeringatanCompanion(
      id: Value(id),
      mahasiswaId: Value(mahasiswaId),
      jenis: Value(jenis),
      skor: Value(skor),
      detail: Value(detail),
      dibuatPada: Value(dibuatPada),
      ditangani: Value(ditangani),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory PeringatanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeringatanRow(
      id: serializer.fromJson<int>(json['id']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      jenis: serializer.fromJson<String>(json['jenis']),
      skor: serializer.fromJson<double>(json['skor']),
      detail: serializer.fromJson<String>(json['detail']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
      ditangani: serializer.fromJson<bool>(json['ditangani']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'jenis': serializer.toJson<String>(jenis),
      'skor': serializer.toJson<double>(skor),
      'detail': serializer.toJson<String>(detail),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
      'ditangani': serializer.toJson<bool>(ditangani),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  PeringatanRow copyWith({
    int? id,
    int? mahasiswaId,
    String? jenis,
    double? skor,
    String? detail,
    DateTime? dibuatPada,
    bool? ditangani,
    DateTime? updatedAt,
    String? deviceId,
  }) => PeringatanRow(
    id: id ?? this.id,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    jenis: jenis ?? this.jenis,
    skor: skor ?? this.skor,
    detail: detail ?? this.detail,
    dibuatPada: dibuatPada ?? this.dibuatPada,
    ditangani: ditangani ?? this.ditangani,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  PeringatanRow copyWithCompanion(PeringatanCompanion data) {
    return PeringatanRow(
      id: data.id.present ? data.id.value : this.id,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      skor: data.skor.present ? data.skor.value : this.skor,
      detail: data.detail.present ? data.detail.value : this.detail,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
      ditangani: data.ditangani.present ? data.ditangani.value : this.ditangani,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeringatanRow(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('jenis: $jenis, ')
          ..write('skor: $skor, ')
          ..write('detail: $detail, ')
          ..write('dibuatPada: $dibuatPada, ')
          ..write('ditangani: $ditangani, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mahasiswaId,
    jenis,
    skor,
    detail,
    dibuatPada,
    ditangani,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeringatanRow &&
          other.id == this.id &&
          other.mahasiswaId == this.mahasiswaId &&
          other.jenis == this.jenis &&
          other.skor == this.skor &&
          other.detail == this.detail &&
          other.dibuatPada == this.dibuatPada &&
          other.ditangani == this.ditangani &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class PeringatanCompanion extends UpdateCompanion<PeringatanRow> {
  final Value<int> id;
  final Value<int> mahasiswaId;
  final Value<String> jenis;
  final Value<double> skor;
  final Value<String> detail;
  final Value<DateTime> dibuatPada;
  final Value<bool> ditangani;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const PeringatanCompanion({
    this.id = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.jenis = const Value.absent(),
    this.skor = const Value.absent(),
    this.detail = const Value.absent(),
    this.dibuatPada = const Value.absent(),
    this.ditangani = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  PeringatanCompanion.insert({
    this.id = const Value.absent(),
    required int mahasiswaId,
    required String jenis,
    required double skor,
    this.detail = const Value.absent(),
    required DateTime dibuatPada,
    this.ditangani = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : mahasiswaId = Value(mahasiswaId),
       jenis = Value(jenis),
       skor = Value(skor),
       dibuatPada = Value(dibuatPada),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<PeringatanRow> custom({
    Expression<int>? id,
    Expression<int>? mahasiswaId,
    Expression<String>? jenis,
    Expression<double>? skor,
    Expression<String>? detail,
    Expression<DateTime>? dibuatPada,
    Expression<bool>? ditangani,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (jenis != null) 'jenis': jenis,
      if (skor != null) 'skor': skor,
      if (detail != null) 'detail': detail,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
      if (ditangani != null) 'ditangani': ditangani,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  PeringatanCompanion copyWith({
    Value<int>? id,
    Value<int>? mahasiswaId,
    Value<String>? jenis,
    Value<double>? skor,
    Value<String>? detail,
    Value<DateTime>? dibuatPada,
    Value<bool>? ditangani,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return PeringatanCompanion(
      id: id ?? this.id,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      jenis: jenis ?? this.jenis,
      skor: skor ?? this.skor,
      detail: detail ?? this.detail,
      dibuatPada: dibuatPada ?? this.dibuatPada,
      ditangani: ditangani ?? this.ditangani,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (skor.present) {
      map['skor'] = Variable<double>(skor.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    if (ditangani.present) {
      map['ditangani'] = Variable<bool>(ditangani.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeringatanCompanion(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('jenis: $jenis, ')
          ..write('skor: $skor, ')
          ..write('detail: $detail, ')
          ..write('dibuatPada: $dibuatPada, ')
          ..write('ditangani: $ditangani, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $AuditLogTable extends AuditLog
    with TableInfo<$AuditLogTable, AuditLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _aksiMeta = const VerificationMeta('aksi');
  @override
  late final GeneratedColumn<String> aksi = GeneratedColumn<String>(
    'aksi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entitasMeta = const VerificationMeta(
    'entitas',
  );
  @override
  late final GeneratedColumn<String> entitas = GeneratedColumn<String>(
    'entitas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entitasIdMeta = const VerificationMeta(
    'entitasId',
  );
  @override
  late final GeneratedColumn<String> entitasId = GeneratedColumn<String>(
    'entitas_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sebelumMeta = const VerificationMeta(
    'sebelum',
  );
  @override
  late final GeneratedColumn<String> sebelum = GeneratedColumn<String>(
    'sebelum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sesudahMeta = const VerificationMeta(
    'sesudah',
  );
  @override
  late final GeneratedColumn<String> sesudah = GeneratedColumn<String>(
    'sesudah',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    aksi,
    entitas,
    entitasId,
    sebelum,
    sesudah,
    waktu,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('aksi')) {
      context.handle(
        _aksiMeta,
        aksi.isAcceptableOrUnknown(data['aksi']!, _aksiMeta),
      );
    } else if (isInserting) {
      context.missing(_aksiMeta);
    }
    if (data.containsKey('entitas')) {
      context.handle(
        _entitasMeta,
        entitas.isAcceptableOrUnknown(data['entitas']!, _entitasMeta),
      );
    } else if (isInserting) {
      context.missing(_entitasMeta);
    }
    if (data.containsKey('entitas_id')) {
      context.handle(
        _entitasIdMeta,
        entitasId.isAcceptableOrUnknown(data['entitas_id']!, _entitasIdMeta),
      );
    }
    if (data.containsKey('sebelum')) {
      context.handle(
        _sebelumMeta,
        sebelum.isAcceptableOrUnknown(data['sebelum']!, _sebelumMeta),
      );
    }
    if (data.containsKey('sesudah')) {
      context.handle(
        _sesudahMeta,
        sesudah.isAcceptableOrUnknown(data['sesudah']!, _sesudahMeta),
      );
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      aksi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aksi'],
      )!,
      entitas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entitas'],
      )!,
      entitasId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entitas_id'],
      ),
      sebelum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sebelum'],
      ),
      sesudah: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sesudah'],
      ),
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
    );
  }

  @override
  $AuditLogTable createAlias(String alias) {
    return $AuditLogTable(attachedDatabase, alias);
  }
}

class AuditLogRow extends DataClass implements Insertable<AuditLogRow> {
  final int id;
  final int? userId;
  final String aksi;
  final String entitas;
  final String? entitasId;
  final String? sebelum;
  final String? sesudah;
  final DateTime waktu;
  const AuditLogRow({
    required this.id,
    this.userId,
    required this.aksi,
    required this.entitas,
    this.entitasId,
    this.sebelum,
    this.sesudah,
    required this.waktu,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['aksi'] = Variable<String>(aksi);
    map['entitas'] = Variable<String>(entitas);
    if (!nullToAbsent || entitasId != null) {
      map['entitas_id'] = Variable<String>(entitasId);
    }
    if (!nullToAbsent || sebelum != null) {
      map['sebelum'] = Variable<String>(sebelum);
    }
    if (!nullToAbsent || sesudah != null) {
      map['sesudah'] = Variable<String>(sesudah);
    }
    map['waktu'] = Variable<DateTime>(waktu);
    return map;
  }

  AuditLogCompanion toCompanion(bool nullToAbsent) {
    return AuditLogCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      aksi: Value(aksi),
      entitas: Value(entitas),
      entitasId: entitasId == null && nullToAbsent
          ? const Value.absent()
          : Value(entitasId),
      sebelum: sebelum == null && nullToAbsent
          ? const Value.absent()
          : Value(sebelum),
      sesudah: sesudah == null && nullToAbsent
          ? const Value.absent()
          : Value(sesudah),
      waktu: Value(waktu),
    );
  }

  factory AuditLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int?>(json['userId']),
      aksi: serializer.fromJson<String>(json['aksi']),
      entitas: serializer.fromJson<String>(json['entitas']),
      entitasId: serializer.fromJson<String?>(json['entitasId']),
      sebelum: serializer.fromJson<String?>(json['sebelum']),
      sesudah: serializer.fromJson<String?>(json['sesudah']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int?>(userId),
      'aksi': serializer.toJson<String>(aksi),
      'entitas': serializer.toJson<String>(entitas),
      'entitasId': serializer.toJson<String?>(entitasId),
      'sebelum': serializer.toJson<String?>(sebelum),
      'sesudah': serializer.toJson<String?>(sesudah),
      'waktu': serializer.toJson<DateTime>(waktu),
    };
  }

  AuditLogRow copyWith({
    int? id,
    Value<int?> userId = const Value.absent(),
    String? aksi,
    String? entitas,
    Value<String?> entitasId = const Value.absent(),
    Value<String?> sebelum = const Value.absent(),
    Value<String?> sesudah = const Value.absent(),
    DateTime? waktu,
  }) => AuditLogRow(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    aksi: aksi ?? this.aksi,
    entitas: entitas ?? this.entitas,
    entitasId: entitasId.present ? entitasId.value : this.entitasId,
    sebelum: sebelum.present ? sebelum.value : this.sebelum,
    sesudah: sesudah.present ? sesudah.value : this.sesudah,
    waktu: waktu ?? this.waktu,
  );
  AuditLogRow copyWithCompanion(AuditLogCompanion data) {
    return AuditLogRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      aksi: data.aksi.present ? data.aksi.value : this.aksi,
      entitas: data.entitas.present ? data.entitas.value : this.entitas,
      entitasId: data.entitasId.present ? data.entitasId.value : this.entitasId,
      sebelum: data.sebelum.present ? data.sebelum.value : this.sebelum,
      sesudah: data.sesudah.present ? data.sesudah.value : this.sesudah,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('aksi: $aksi, ')
          ..write('entitas: $entitas, ')
          ..write('entitasId: $entitasId, ')
          ..write('sebelum: $sebelum, ')
          ..write('sesudah: $sesudah, ')
          ..write('waktu: $waktu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    aksi,
    entitas,
    entitasId,
    sebelum,
    sesudah,
    waktu,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.aksi == this.aksi &&
          other.entitas == this.entitas &&
          other.entitasId == this.entitasId &&
          other.sebelum == this.sebelum &&
          other.sesudah == this.sesudah &&
          other.waktu == this.waktu);
}

class AuditLogCompanion extends UpdateCompanion<AuditLogRow> {
  final Value<int> id;
  final Value<int?> userId;
  final Value<String> aksi;
  final Value<String> entitas;
  final Value<String?> entitasId;
  final Value<String?> sebelum;
  final Value<String?> sesudah;
  final Value<DateTime> waktu;
  const AuditLogCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.aksi = const Value.absent(),
    this.entitas = const Value.absent(),
    this.entitasId = const Value.absent(),
    this.sebelum = const Value.absent(),
    this.sesudah = const Value.absent(),
    this.waktu = const Value.absent(),
  });
  AuditLogCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String aksi,
    required String entitas,
    this.entitasId = const Value.absent(),
    this.sebelum = const Value.absent(),
    this.sesudah = const Value.absent(),
    required DateTime waktu,
  }) : aksi = Value(aksi),
       entitas = Value(entitas),
       waktu = Value(waktu);
  static Insertable<AuditLogRow> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? aksi,
    Expression<String>? entitas,
    Expression<String>? entitasId,
    Expression<String>? sebelum,
    Expression<String>? sesudah,
    Expression<DateTime>? waktu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (aksi != null) 'aksi': aksi,
      if (entitas != null) 'entitas': entitas,
      if (entitasId != null) 'entitas_id': entitasId,
      if (sebelum != null) 'sebelum': sebelum,
      if (sesudah != null) 'sesudah': sesudah,
      if (waktu != null) 'waktu': waktu,
    });
  }

  AuditLogCompanion copyWith({
    Value<int>? id,
    Value<int?>? userId,
    Value<String>? aksi,
    Value<String>? entitas,
    Value<String?>? entitasId,
    Value<String?>? sebelum,
    Value<String?>? sesudah,
    Value<DateTime>? waktu,
  }) {
    return AuditLogCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      aksi: aksi ?? this.aksi,
      entitas: entitas ?? this.entitas,
      entitasId: entitasId ?? this.entitasId,
      sebelum: sebelum ?? this.sebelum,
      sesudah: sesudah ?? this.sesudah,
      waktu: waktu ?? this.waktu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (aksi.present) {
      map['aksi'] = Variable<String>(aksi.value);
    }
    if (entitas.present) {
      map['entitas'] = Variable<String>(entitas.value);
    }
    if (entitasId.present) {
      map['entitas_id'] = Variable<String>(entitasId.value);
    }
    if (sebelum.present) {
      map['sebelum'] = Variable<String>(sebelum.value);
    }
    if (sesudah.present) {
      map['sesudah'] = Variable<String>(sesudah.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('aksi: $aksi, ')
          ..write('entitas: $entitas, ')
          ..write('entitasId: $entitasId, ')
          ..write('sebelum: $sebelum, ')
          ..write('sesudah: $sesudah, ')
          ..write('waktu: $waktu')
          ..write(')'))
        .toString();
  }
}

class $SyncLogTable extends SyncLog with TableInfo<$SyncLogTable, SyncLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arahMeta = const VerificationMeta('arah');
  @override
  late final GeneratedColumn<String> arah = GeneratedColumn<String>(
    'arah',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jumlahRecordMeta = const VerificationMeta(
    'jumlahRecord',
  );
  @override
  late final GeneratedColumn<int> jumlahRecord = GeneratedColumn<int>(
    'jumlah_record',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _konflikMeta = const VerificationMeta(
    'konflik',
  );
  @override
  late final GeneratedColumn<int> konflik = GeneratedColumn<int>(
    'konflik',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceId,
    arah,
    jumlahRecord,
    konflik,
    waktu,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('arah')) {
      context.handle(
        _arahMeta,
        arah.isAcceptableOrUnknown(data['arah']!, _arahMeta),
      );
    } else if (isInserting) {
      context.missing(_arahMeta);
    }
    if (data.containsKey('jumlah_record')) {
      context.handle(
        _jumlahRecordMeta,
        jumlahRecord.isAcceptableOrUnknown(
          data['jumlah_record']!,
          _jumlahRecordMeta,
        ),
      );
    }
    if (data.containsKey('konflik')) {
      context.handle(
        _konflikMeta,
        konflik.isAcceptableOrUnknown(data['konflik']!, _konflikMeta),
      );
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      arah: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arah'],
      )!,
      jumlahRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jumlah_record'],
      )!,
      konflik: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}konflik'],
      )!,
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
    );
  }

  @override
  $SyncLogTable createAlias(String alias) {
    return $SyncLogTable(attachedDatabase, alias);
  }
}

class SyncLogRow extends DataClass implements Insertable<SyncLogRow> {
  final int id;
  final String deviceId;
  final String arah;
  final int jumlahRecord;
  final int konflik;
  final DateTime waktu;
  const SyncLogRow({
    required this.id,
    required this.deviceId,
    required this.arah,
    required this.jumlahRecord,
    required this.konflik,
    required this.waktu,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['device_id'] = Variable<String>(deviceId);
    map['arah'] = Variable<String>(arah);
    map['jumlah_record'] = Variable<int>(jumlahRecord);
    map['konflik'] = Variable<int>(konflik);
    map['waktu'] = Variable<DateTime>(waktu);
    return map;
  }

  SyncLogCompanion toCompanion(bool nullToAbsent) {
    return SyncLogCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      arah: Value(arah),
      jumlahRecord: Value(jumlahRecord),
      konflik: Value(konflik),
      waktu: Value(waktu),
    );
  }

  factory SyncLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLogRow(
      id: serializer.fromJson<int>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      arah: serializer.fromJson<String>(json['arah']),
      jumlahRecord: serializer.fromJson<int>(json['jumlahRecord']),
      konflik: serializer.fromJson<int>(json['konflik']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'arah': serializer.toJson<String>(arah),
      'jumlahRecord': serializer.toJson<int>(jumlahRecord),
      'konflik': serializer.toJson<int>(konflik),
      'waktu': serializer.toJson<DateTime>(waktu),
    };
  }

  SyncLogRow copyWith({
    int? id,
    String? deviceId,
    String? arah,
    int? jumlahRecord,
    int? konflik,
    DateTime? waktu,
  }) => SyncLogRow(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    arah: arah ?? this.arah,
    jumlahRecord: jumlahRecord ?? this.jumlahRecord,
    konflik: konflik ?? this.konflik,
    waktu: waktu ?? this.waktu,
  );
  SyncLogRow copyWithCompanion(SyncLogCompanion data) {
    return SyncLogRow(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      arah: data.arah.present ? data.arah.value : this.arah,
      jumlahRecord: data.jumlahRecord.present
          ? data.jumlahRecord.value
          : this.jumlahRecord,
      konflik: data.konflik.present ? data.konflik.value : this.konflik,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogRow(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('arah: $arah, ')
          ..write('jumlahRecord: $jumlahRecord, ')
          ..write('konflik: $konflik, ')
          ..write('waktu: $waktu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, deviceId, arah, jumlahRecord, konflik, waktu);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLogRow &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.arah == this.arah &&
          other.jumlahRecord == this.jumlahRecord &&
          other.konflik == this.konflik &&
          other.waktu == this.waktu);
}

class SyncLogCompanion extends UpdateCompanion<SyncLogRow> {
  final Value<int> id;
  final Value<String> deviceId;
  final Value<String> arah;
  final Value<int> jumlahRecord;
  final Value<int> konflik;
  final Value<DateTime> waktu;
  const SyncLogCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.arah = const Value.absent(),
    this.jumlahRecord = const Value.absent(),
    this.konflik = const Value.absent(),
    this.waktu = const Value.absent(),
  });
  SyncLogCompanion.insert({
    this.id = const Value.absent(),
    required String deviceId,
    required String arah,
    this.jumlahRecord = const Value.absent(),
    this.konflik = const Value.absent(),
    required DateTime waktu,
  }) : deviceId = Value(deviceId),
       arah = Value(arah),
       waktu = Value(waktu);
  static Insertable<SyncLogRow> custom({
    Expression<int>? id,
    Expression<String>? deviceId,
    Expression<String>? arah,
    Expression<int>? jumlahRecord,
    Expression<int>? konflik,
    Expression<DateTime>? waktu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (arah != null) 'arah': arah,
      if (jumlahRecord != null) 'jumlah_record': jumlahRecord,
      if (konflik != null) 'konflik': konflik,
      if (waktu != null) 'waktu': waktu,
    });
  }

  SyncLogCompanion copyWith({
    Value<int>? id,
    Value<String>? deviceId,
    Value<String>? arah,
    Value<int>? jumlahRecord,
    Value<int>? konflik,
    Value<DateTime>? waktu,
  }) {
    return SyncLogCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      arah: arah ?? this.arah,
      jumlahRecord: jumlahRecord ?? this.jumlahRecord,
      konflik: konflik ?? this.konflik,
      waktu: waktu ?? this.waktu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (arah.present) {
      map['arah'] = Variable<String>(arah.value);
    }
    if (jumlahRecord.present) {
      map['jumlah_record'] = Variable<int>(jumlahRecord.value);
    }
    if (konflik.present) {
      map['konflik'] = Variable<int>(konflik.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('arah: $arah, ')
          ..write('jumlahRecord: $jumlahRecord, ')
          ..write('konflik: $konflik, ')
          ..write('waktu: $waktu')
          ..write(')'))
        .toString();
  }
}

class $PengaturanTable extends Pengaturan
    with TableInfo<$PengaturanTable, PengaturanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PengaturanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kunciMeta = const VerificationMeta('kunci');
  @override
  late final GeneratedColumn<String> kunci = GeneratedColumn<String>(
    'kunci',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nilaiMeta = const VerificationMeta('nilai');
  @override
  late final GeneratedColumn<String> nilai = GeneratedColumn<String>(
    'nilai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [kunci, nilai, updatedAt, deviceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pengaturan';
  @override
  VerificationContext validateIntegrity(
    Insertable<PengaturanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kunci')) {
      context.handle(
        _kunciMeta,
        kunci.isAcceptableOrUnknown(data['kunci']!, _kunciMeta),
      );
    } else if (isInserting) {
      context.missing(_kunciMeta);
    }
    if (data.containsKey('nilai')) {
      context.handle(
        _nilaiMeta,
        nilai.isAcceptableOrUnknown(data['nilai']!, _nilaiMeta),
      );
    } else if (isInserting) {
      context.missing(_nilaiMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {kunci};
  @override
  PengaturanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PengaturanRow(
      kunci: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kunci'],
      )!,
      nilai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nilai'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $PengaturanTable createAlias(String alias) {
    return $PengaturanTable(attachedDatabase, alias);
  }
}

class PengaturanRow extends DataClass implements Insertable<PengaturanRow> {
  final String kunci;
  final String nilai;
  final DateTime updatedAt;
  final String deviceId;
  const PengaturanRow({
    required this.kunci,
    required this.nilai,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kunci'] = Variable<String>(kunci);
    map['nilai'] = Variable<String>(nilai);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  PengaturanCompanion toCompanion(bool nullToAbsent) {
    return PengaturanCompanion(
      kunci: Value(kunci),
      nilai: Value(nilai),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory PengaturanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PengaturanRow(
      kunci: serializer.fromJson<String>(json['kunci']),
      nilai: serializer.fromJson<String>(json['nilai']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kunci': serializer.toJson<String>(kunci),
      'nilai': serializer.toJson<String>(nilai),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  PengaturanRow copyWith({
    String? kunci,
    String? nilai,
    DateTime? updatedAt,
    String? deviceId,
  }) => PengaturanRow(
    kunci: kunci ?? this.kunci,
    nilai: nilai ?? this.nilai,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  PengaturanRow copyWithCompanion(PengaturanCompanion data) {
    return PengaturanRow(
      kunci: data.kunci.present ? data.kunci.value : this.kunci,
      nilai: data.nilai.present ? data.nilai.value : this.nilai,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PengaturanRow(')
          ..write('kunci: $kunci, ')
          ..write('nilai: $nilai, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kunci, nilai, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PengaturanRow &&
          other.kunci == this.kunci &&
          other.nilai == this.nilai &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class PengaturanCompanion extends UpdateCompanion<PengaturanRow> {
  final Value<String> kunci;
  final Value<String> nilai;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  final Value<int> rowid;
  const PengaturanCompanion({
    this.kunci = const Value.absent(),
    this.nilai = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PengaturanCompanion.insert({
    required String kunci,
    required String nilai,
    required DateTime updatedAt,
    required String deviceId,
    this.rowid = const Value.absent(),
  }) : kunci = Value(kunci),
       nilai = Value(nilai),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<PengaturanRow> custom({
    Expression<String>? kunci,
    Expression<String>? nilai,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kunci != null) 'kunci': kunci,
      if (nilai != null) 'nilai': nilai,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PengaturanCompanion copyWith({
    Value<String>? kunci,
    Value<String>? nilai,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
    Value<int>? rowid,
  }) {
    return PengaturanCompanion(
      kunci: kunci ?? this.kunci,
      nilai: nilai ?? this.nilai,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kunci.present) {
      map['kunci'] = Variable<String>(kunci.value);
    }
    if (nilai.present) {
      map['nilai'] = Variable<String>(nilai.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PengaturanCompanion(')
          ..write('kunci: $kunci, ')
          ..write('nilai: $nilai, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PengumumanTable extends Pengumuman
    with TableInfo<$PengumumanTable, PengumumanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PengumumanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isiMeta = const VerificationMeta('isi');
  @override
  late final GeneratedColumn<String> isi = GeneratedColumn<String>(
    'isi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('umum'),
  );
  static const VerificationMeta _tanggalMulaiMeta = const VerificationMeta(
    'tanggalMulai',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalMulai = GeneratedColumn<DateTime>(
    'tanggal_mulai',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tanggalSelesaiMeta = const VerificationMeta(
    'tanggalSelesai',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalSelesai =
      GeneratedColumn<DateTime>(
        'tanggal_selesai',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dibuatOlehMeta = const VerificationMeta(
    'dibuatOleh',
  );
  @override
  late final GeneratedColumn<int> dibuatOleh = GeneratedColumn<int>(
    'dibuat_oleh',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    judul,
    isi,
    kategori,
    tanggalMulai,
    tanggalSelesai,
    dibuatOleh,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pengumuman';
  @override
  VerificationContext validateIntegrity(
    Insertable<PengumumanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('isi')) {
      context.handle(
        _isiMeta,
        isi.isAcceptableOrUnknown(data['isi']!, _isiMeta),
      );
    } else if (isInserting) {
      context.missing(_isiMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    }
    if (data.containsKey('tanggal_mulai')) {
      context.handle(
        _tanggalMulaiMeta,
        tanggalMulai.isAcceptableOrUnknown(
          data['tanggal_mulai']!,
          _tanggalMulaiMeta,
        ),
      );
    }
    if (data.containsKey('tanggal_selesai')) {
      context.handle(
        _tanggalSelesaiMeta,
        tanggalSelesai.isAcceptableOrUnknown(
          data['tanggal_selesai']!,
          _tanggalSelesaiMeta,
        ),
      );
    }
    if (data.containsKey('dibuat_oleh')) {
      context.handle(
        _dibuatOlehMeta,
        dibuatOleh.isAcceptableOrUnknown(data['dibuat_oleh']!, _dibuatOlehMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PengumumanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PengumumanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      isi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isi'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      )!,
      tanggalMulai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_mulai'],
      ),
      tanggalSelesai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_selesai'],
      ),
      dibuatOleh: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dibuat_oleh'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $PengumumanTable createAlias(String alias) {
    return $PengumumanTable(attachedDatabase, alias);
  }
}

class PengumumanRow extends DataClass implements Insertable<PengumumanRow> {
  final int id;
  final String judul;
  final String isi;
  final String kategori;
  final DateTime? tanggalMulai;
  final DateTime? tanggalSelesai;
  final int? dibuatOleh;
  final DateTime updatedAt;
  final String deviceId;
  const PengumumanRow({
    required this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    this.tanggalMulai,
    this.tanggalSelesai,
    this.dibuatOleh,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['judul'] = Variable<String>(judul);
    map['isi'] = Variable<String>(isi);
    map['kategori'] = Variable<String>(kategori);
    if (!nullToAbsent || tanggalMulai != null) {
      map['tanggal_mulai'] = Variable<DateTime>(tanggalMulai);
    }
    if (!nullToAbsent || tanggalSelesai != null) {
      map['tanggal_selesai'] = Variable<DateTime>(tanggalSelesai);
    }
    if (!nullToAbsent || dibuatOleh != null) {
      map['dibuat_oleh'] = Variable<int>(dibuatOleh);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  PengumumanCompanion toCompanion(bool nullToAbsent) {
    return PengumumanCompanion(
      id: Value(id),
      judul: Value(judul),
      isi: Value(isi),
      kategori: Value(kategori),
      tanggalMulai: tanggalMulai == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalMulai),
      tanggalSelesai: tanggalSelesai == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalSelesai),
      dibuatOleh: dibuatOleh == null && nullToAbsent
          ? const Value.absent()
          : Value(dibuatOleh),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory PengumumanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PengumumanRow(
      id: serializer.fromJson<int>(json['id']),
      judul: serializer.fromJson<String>(json['judul']),
      isi: serializer.fromJson<String>(json['isi']),
      kategori: serializer.fromJson<String>(json['kategori']),
      tanggalMulai: serializer.fromJson<DateTime?>(json['tanggalMulai']),
      tanggalSelesai: serializer.fromJson<DateTime?>(json['tanggalSelesai']),
      dibuatOleh: serializer.fromJson<int?>(json['dibuatOleh']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'judul': serializer.toJson<String>(judul),
      'isi': serializer.toJson<String>(isi),
      'kategori': serializer.toJson<String>(kategori),
      'tanggalMulai': serializer.toJson<DateTime?>(tanggalMulai),
      'tanggalSelesai': serializer.toJson<DateTime?>(tanggalSelesai),
      'dibuatOleh': serializer.toJson<int?>(dibuatOleh),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  PengumumanRow copyWith({
    int? id,
    String? judul,
    String? isi,
    String? kategori,
    Value<DateTime?> tanggalMulai = const Value.absent(),
    Value<DateTime?> tanggalSelesai = const Value.absent(),
    Value<int?> dibuatOleh = const Value.absent(),
    DateTime? updatedAt,
    String? deviceId,
  }) => PengumumanRow(
    id: id ?? this.id,
    judul: judul ?? this.judul,
    isi: isi ?? this.isi,
    kategori: kategori ?? this.kategori,
    tanggalMulai: tanggalMulai.present ? tanggalMulai.value : this.tanggalMulai,
    tanggalSelesai: tanggalSelesai.present
        ? tanggalSelesai.value
        : this.tanggalSelesai,
    dibuatOleh: dibuatOleh.present ? dibuatOleh.value : this.dibuatOleh,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  PengumumanRow copyWithCompanion(PengumumanCompanion data) {
    return PengumumanRow(
      id: data.id.present ? data.id.value : this.id,
      judul: data.judul.present ? data.judul.value : this.judul,
      isi: data.isi.present ? data.isi.value : this.isi,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      tanggalMulai: data.tanggalMulai.present
          ? data.tanggalMulai.value
          : this.tanggalMulai,
      tanggalSelesai: data.tanggalSelesai.present
          ? data.tanggalSelesai.value
          : this.tanggalSelesai,
      dibuatOleh: data.dibuatOleh.present
          ? data.dibuatOleh.value
          : this.dibuatOleh,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PengumumanRow(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('isi: $isi, ')
          ..write('kategori: $kategori, ')
          ..write('tanggalMulai: $tanggalMulai, ')
          ..write('tanggalSelesai: $tanggalSelesai, ')
          ..write('dibuatOleh: $dibuatOleh, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    judul,
    isi,
    kategori,
    tanggalMulai,
    tanggalSelesai,
    dibuatOleh,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PengumumanRow &&
          other.id == this.id &&
          other.judul == this.judul &&
          other.isi == this.isi &&
          other.kategori == this.kategori &&
          other.tanggalMulai == this.tanggalMulai &&
          other.tanggalSelesai == this.tanggalSelesai &&
          other.dibuatOleh == this.dibuatOleh &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class PengumumanCompanion extends UpdateCompanion<PengumumanRow> {
  final Value<int> id;
  final Value<String> judul;
  final Value<String> isi;
  final Value<String> kategori;
  final Value<DateTime?> tanggalMulai;
  final Value<DateTime?> tanggalSelesai;
  final Value<int?> dibuatOleh;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const PengumumanCompanion({
    this.id = const Value.absent(),
    this.judul = const Value.absent(),
    this.isi = const Value.absent(),
    this.kategori = const Value.absent(),
    this.tanggalMulai = const Value.absent(),
    this.tanggalSelesai = const Value.absent(),
    this.dibuatOleh = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  PengumumanCompanion.insert({
    this.id = const Value.absent(),
    required String judul,
    required String isi,
    this.kategori = const Value.absent(),
    this.tanggalMulai = const Value.absent(),
    this.tanggalSelesai = const Value.absent(),
    this.dibuatOleh = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : judul = Value(judul),
       isi = Value(isi),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<PengumumanRow> custom({
    Expression<int>? id,
    Expression<String>? judul,
    Expression<String>? isi,
    Expression<String>? kategori,
    Expression<DateTime>? tanggalMulai,
    Expression<DateTime>? tanggalSelesai,
    Expression<int>? dibuatOleh,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (judul != null) 'judul': judul,
      if (isi != null) 'isi': isi,
      if (kategori != null) 'kategori': kategori,
      if (tanggalMulai != null) 'tanggal_mulai': tanggalMulai,
      if (tanggalSelesai != null) 'tanggal_selesai': tanggalSelesai,
      if (dibuatOleh != null) 'dibuat_oleh': dibuatOleh,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  PengumumanCompanion copyWith({
    Value<int>? id,
    Value<String>? judul,
    Value<String>? isi,
    Value<String>? kategori,
    Value<DateTime?>? tanggalMulai,
    Value<DateTime?>? tanggalSelesai,
    Value<int?>? dibuatOleh,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return PengumumanCompanion(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      kategori: kategori ?? this.kategori,
      tanggalMulai: tanggalMulai ?? this.tanggalMulai,
      tanggalSelesai: tanggalSelesai ?? this.tanggalSelesai,
      dibuatOleh: dibuatOleh ?? this.dibuatOleh,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (isi.present) {
      map['isi'] = Variable<String>(isi.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (tanggalMulai.present) {
      map['tanggal_mulai'] = Variable<DateTime>(tanggalMulai.value);
    }
    if (tanggalSelesai.present) {
      map['tanggal_selesai'] = Variable<DateTime>(tanggalSelesai.value);
    }
    if (dibuatOleh.present) {
      map['dibuat_oleh'] = Variable<int>(dibuatOleh.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PengumumanCompanion(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('isi: $isi, ')
          ..write('kategori: $kategori, ')
          ..write('tanggalMulai: $tanggalMulai, ')
          ..write('tanggalSelesai: $tanggalSelesai, ')
          ..write('dibuatOleh: $dibuatOleh, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $AgendaAkademikTable extends AgendaAkademik
    with TableInfo<$AgendaAkademikTable, AgendaAkademikRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgendaAkademikTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
    'jenis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('umum'),
  );
  static const VerificationMeta _tanggalMulaiMeta = const VerificationMeta(
    'tanggalMulai',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalMulai = GeneratedColumn<DateTime>(
    'tanggal_mulai',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalSelesaiMeta = const VerificationMeta(
    'tanggalSelesai',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalSelesai =
      GeneratedColumn<DateTime>(
        'tanggal_selesai',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pengingatMenitMeta = const VerificationMeta(
    'pengingatMenit',
  );
  @override
  late final GeneratedColumn<int> pengingatMenit = GeneratedColumn<int>(
    'pengingat_menit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    judul,
    jenis,
    tanggalMulai,
    tanggalSelesai,
    pengingatMenit,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agenda_akademik';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgendaAkademikRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
        _jenisMeta,
        jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta),
      );
    }
    if (data.containsKey('tanggal_mulai')) {
      context.handle(
        _tanggalMulaiMeta,
        tanggalMulai.isAcceptableOrUnknown(
          data['tanggal_mulai']!,
          _tanggalMulaiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tanggalMulaiMeta);
    }
    if (data.containsKey('tanggal_selesai')) {
      context.handle(
        _tanggalSelesaiMeta,
        tanggalSelesai.isAcceptableOrUnknown(
          data['tanggal_selesai']!,
          _tanggalSelesaiMeta,
        ),
      );
    }
    if (data.containsKey('pengingat_menit')) {
      context.handle(
        _pengingatMenitMeta,
        pengingatMenit.isAcceptableOrUnknown(
          data['pengingat_menit']!,
          _pengingatMenitMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgendaAkademikRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgendaAkademikRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      jenis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jenis'],
      )!,
      tanggalMulai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_mulai'],
      )!,
      tanggalSelesai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_selesai'],
      ),
      pengingatMenit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pengingat_menit'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $AgendaAkademikTable createAlias(String alias) {
    return $AgendaAkademikTable(attachedDatabase, alias);
  }
}

class AgendaAkademikRow extends DataClass
    implements Insertable<AgendaAkademikRow> {
  final int id;
  final String judul;
  final String jenis;
  final DateTime tanggalMulai;
  final DateTime? tanggalSelesai;
  final int pengingatMenit;
  final DateTime updatedAt;
  final String deviceId;
  const AgendaAkademikRow({
    required this.id,
    required this.judul,
    required this.jenis,
    required this.tanggalMulai,
    this.tanggalSelesai,
    required this.pengingatMenit,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['judul'] = Variable<String>(judul);
    map['jenis'] = Variable<String>(jenis);
    map['tanggal_mulai'] = Variable<DateTime>(tanggalMulai);
    if (!nullToAbsent || tanggalSelesai != null) {
      map['tanggal_selesai'] = Variable<DateTime>(tanggalSelesai);
    }
    map['pengingat_menit'] = Variable<int>(pengingatMenit);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  AgendaAkademikCompanion toCompanion(bool nullToAbsent) {
    return AgendaAkademikCompanion(
      id: Value(id),
      judul: Value(judul),
      jenis: Value(jenis),
      tanggalMulai: Value(tanggalMulai),
      tanggalSelesai: tanggalSelesai == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalSelesai),
      pengingatMenit: Value(pengingatMenit),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory AgendaAkademikRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgendaAkademikRow(
      id: serializer.fromJson<int>(json['id']),
      judul: serializer.fromJson<String>(json['judul']),
      jenis: serializer.fromJson<String>(json['jenis']),
      tanggalMulai: serializer.fromJson<DateTime>(json['tanggalMulai']),
      tanggalSelesai: serializer.fromJson<DateTime?>(json['tanggalSelesai']),
      pengingatMenit: serializer.fromJson<int>(json['pengingatMenit']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'judul': serializer.toJson<String>(judul),
      'jenis': serializer.toJson<String>(jenis),
      'tanggalMulai': serializer.toJson<DateTime>(tanggalMulai),
      'tanggalSelesai': serializer.toJson<DateTime?>(tanggalSelesai),
      'pengingatMenit': serializer.toJson<int>(pengingatMenit),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  AgendaAkademikRow copyWith({
    int? id,
    String? judul,
    String? jenis,
    DateTime? tanggalMulai,
    Value<DateTime?> tanggalSelesai = const Value.absent(),
    int? pengingatMenit,
    DateTime? updatedAt,
    String? deviceId,
  }) => AgendaAkademikRow(
    id: id ?? this.id,
    judul: judul ?? this.judul,
    jenis: jenis ?? this.jenis,
    tanggalMulai: tanggalMulai ?? this.tanggalMulai,
    tanggalSelesai: tanggalSelesai.present
        ? tanggalSelesai.value
        : this.tanggalSelesai,
    pengingatMenit: pengingatMenit ?? this.pengingatMenit,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  AgendaAkademikRow copyWithCompanion(AgendaAkademikCompanion data) {
    return AgendaAkademikRow(
      id: data.id.present ? data.id.value : this.id,
      judul: data.judul.present ? data.judul.value : this.judul,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      tanggalMulai: data.tanggalMulai.present
          ? data.tanggalMulai.value
          : this.tanggalMulai,
      tanggalSelesai: data.tanggalSelesai.present
          ? data.tanggalSelesai.value
          : this.tanggalSelesai,
      pengingatMenit: data.pengingatMenit.present
          ? data.pengingatMenit.value
          : this.pengingatMenit,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgendaAkademikRow(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('jenis: $jenis, ')
          ..write('tanggalMulai: $tanggalMulai, ')
          ..write('tanggalSelesai: $tanggalSelesai, ')
          ..write('pengingatMenit: $pengingatMenit, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    judul,
    jenis,
    tanggalMulai,
    tanggalSelesai,
    pengingatMenit,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgendaAkademikRow &&
          other.id == this.id &&
          other.judul == this.judul &&
          other.jenis == this.jenis &&
          other.tanggalMulai == this.tanggalMulai &&
          other.tanggalSelesai == this.tanggalSelesai &&
          other.pengingatMenit == this.pengingatMenit &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class AgendaAkademikCompanion extends UpdateCompanion<AgendaAkademikRow> {
  final Value<int> id;
  final Value<String> judul;
  final Value<String> jenis;
  final Value<DateTime> tanggalMulai;
  final Value<DateTime?> tanggalSelesai;
  final Value<int> pengingatMenit;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const AgendaAkademikCompanion({
    this.id = const Value.absent(),
    this.judul = const Value.absent(),
    this.jenis = const Value.absent(),
    this.tanggalMulai = const Value.absent(),
    this.tanggalSelesai = const Value.absent(),
    this.pengingatMenit = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  AgendaAkademikCompanion.insert({
    this.id = const Value.absent(),
    required String judul,
    this.jenis = const Value.absent(),
    required DateTime tanggalMulai,
    this.tanggalSelesai = const Value.absent(),
    this.pengingatMenit = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : judul = Value(judul),
       tanggalMulai = Value(tanggalMulai),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<AgendaAkademikRow> custom({
    Expression<int>? id,
    Expression<String>? judul,
    Expression<String>? jenis,
    Expression<DateTime>? tanggalMulai,
    Expression<DateTime>? tanggalSelesai,
    Expression<int>? pengingatMenit,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (judul != null) 'judul': judul,
      if (jenis != null) 'jenis': jenis,
      if (tanggalMulai != null) 'tanggal_mulai': tanggalMulai,
      if (tanggalSelesai != null) 'tanggal_selesai': tanggalSelesai,
      if (pengingatMenit != null) 'pengingat_menit': pengingatMenit,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  AgendaAkademikCompanion copyWith({
    Value<int>? id,
    Value<String>? judul,
    Value<String>? jenis,
    Value<DateTime>? tanggalMulai,
    Value<DateTime?>? tanggalSelesai,
    Value<int>? pengingatMenit,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return AgendaAkademikCompanion(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      jenis: jenis ?? this.jenis,
      tanggalMulai: tanggalMulai ?? this.tanggalMulai,
      tanggalSelesai: tanggalSelesai ?? this.tanggalSelesai,
      pengingatMenit: pengingatMenit ?? this.pengingatMenit,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (tanggalMulai.present) {
      map['tanggal_mulai'] = Variable<DateTime>(tanggalMulai.value);
    }
    if (tanggalSelesai.present) {
      map['tanggal_selesai'] = Variable<DateTime>(tanggalSelesai.value);
    }
    if (pengingatMenit.present) {
      map['pengingat_menit'] = Variable<int>(pengingatMenit.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgendaAkademikCompanion(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('jenis: $jenis, ')
          ..write('tanggalMulai: $tanggalMulai, ')
          ..write('tanggalSelesai: $tanggalSelesai, ')
          ..write('pengingatMenit: $pengingatMenit, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $JadwalUjianTable extends JadwalUjian
    with TableInfo<$JadwalUjianTable, JadwalUjianRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JadwalUjianTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kelasIdMeta = const VerificationMeta(
    'kelasId',
  );
  @override
  late final GeneratedColumn<int> kelasId = GeneratedColumn<int>(
    'kelas_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kelas (id)',
    ),
  );
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
    'jenis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jamMulaiMeta = const VerificationMeta(
    'jamMulai',
  );
  @override
  late final GeneratedColumn<String> jamMulai = GeneratedColumn<String>(
    'jam_mulai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jamSelesaiMeta = const VerificationMeta(
    'jamSelesai',
  );
  @override
  late final GeneratedColumn<String> jamSelesai = GeneratedColumn<String>(
    'jam_selesai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruangMeta = const VerificationMeta('ruang');
  @override
  late final GeneratedColumn<String> ruang = GeneratedColumn<String>(
    'ruang',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kelasId,
    jenis,
    tanggal,
    jamMulai,
    jamSelesai,
    ruang,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jadwal_ujian';
  @override
  VerificationContext validateIntegrity(
    Insertable<JadwalUjianRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kelas_id')) {
      context.handle(
        _kelasIdMeta,
        kelasId.isAcceptableOrUnknown(data['kelas_id']!, _kelasIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kelasIdMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
        _jenisMeta,
        jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta),
      );
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('jam_mulai')) {
      context.handle(
        _jamMulaiMeta,
        jamMulai.isAcceptableOrUnknown(data['jam_mulai']!, _jamMulaiMeta),
      );
    } else if (isInserting) {
      context.missing(_jamMulaiMeta);
    }
    if (data.containsKey('jam_selesai')) {
      context.handle(
        _jamSelesaiMeta,
        jamSelesai.isAcceptableOrUnknown(data['jam_selesai']!, _jamSelesaiMeta),
      );
    } else if (isInserting) {
      context.missing(_jamSelesaiMeta);
    }
    if (data.containsKey('ruang')) {
      context.handle(
        _ruangMeta,
        ruang.isAcceptableOrUnknown(data['ruang']!, _ruangMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JadwalUjianRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JadwalUjianRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kelasId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kelas_id'],
      )!,
      jenis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jenis'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      jamMulai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jam_mulai'],
      )!,
      jamSelesai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jam_selesai'],
      )!,
      ruang: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ruang'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $JadwalUjianTable createAlias(String alias) {
    return $JadwalUjianTable(attachedDatabase, alias);
  }
}

class JadwalUjianRow extends DataClass implements Insertable<JadwalUjianRow> {
  final int id;
  final int kelasId;
  final String jenis;
  final DateTime tanggal;
  final String jamMulai;
  final String jamSelesai;
  final String ruang;
  final DateTime updatedAt;
  final String deviceId;
  const JadwalUjianRow({
    required this.id,
    required this.kelasId,
    required this.jenis,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruang,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kelas_id'] = Variable<int>(kelasId);
    map['jenis'] = Variable<String>(jenis);
    map['tanggal'] = Variable<DateTime>(tanggal);
    map['jam_mulai'] = Variable<String>(jamMulai);
    map['jam_selesai'] = Variable<String>(jamSelesai);
    map['ruang'] = Variable<String>(ruang);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  JadwalUjianCompanion toCompanion(bool nullToAbsent) {
    return JadwalUjianCompanion(
      id: Value(id),
      kelasId: Value(kelasId),
      jenis: Value(jenis),
      tanggal: Value(tanggal),
      jamMulai: Value(jamMulai),
      jamSelesai: Value(jamSelesai),
      ruang: Value(ruang),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory JadwalUjianRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JadwalUjianRow(
      id: serializer.fromJson<int>(json['id']),
      kelasId: serializer.fromJson<int>(json['kelasId']),
      jenis: serializer.fromJson<String>(json['jenis']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      jamMulai: serializer.fromJson<String>(json['jamMulai']),
      jamSelesai: serializer.fromJson<String>(json['jamSelesai']),
      ruang: serializer.fromJson<String>(json['ruang']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kelasId': serializer.toJson<int>(kelasId),
      'jenis': serializer.toJson<String>(jenis),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'jamMulai': serializer.toJson<String>(jamMulai),
      'jamSelesai': serializer.toJson<String>(jamSelesai),
      'ruang': serializer.toJson<String>(ruang),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  JadwalUjianRow copyWith({
    int? id,
    int? kelasId,
    String? jenis,
    DateTime? tanggal,
    String? jamMulai,
    String? jamSelesai,
    String? ruang,
    DateTime? updatedAt,
    String? deviceId,
  }) => JadwalUjianRow(
    id: id ?? this.id,
    kelasId: kelasId ?? this.kelasId,
    jenis: jenis ?? this.jenis,
    tanggal: tanggal ?? this.tanggal,
    jamMulai: jamMulai ?? this.jamMulai,
    jamSelesai: jamSelesai ?? this.jamSelesai,
    ruang: ruang ?? this.ruang,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  JadwalUjianRow copyWithCompanion(JadwalUjianCompanion data) {
    return JadwalUjianRow(
      id: data.id.present ? data.id.value : this.id,
      kelasId: data.kelasId.present ? data.kelasId.value : this.kelasId,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      jamMulai: data.jamMulai.present ? data.jamMulai.value : this.jamMulai,
      jamSelesai: data.jamSelesai.present
          ? data.jamSelesai.value
          : this.jamSelesai,
      ruang: data.ruang.present ? data.ruang.value : this.ruang,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JadwalUjianRow(')
          ..write('id: $id, ')
          ..write('kelasId: $kelasId, ')
          ..write('jenis: $jenis, ')
          ..write('tanggal: $tanggal, ')
          ..write('jamMulai: $jamMulai, ')
          ..write('jamSelesai: $jamSelesai, ')
          ..write('ruang: $ruang, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kelasId,
    jenis,
    tanggal,
    jamMulai,
    jamSelesai,
    ruang,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JadwalUjianRow &&
          other.id == this.id &&
          other.kelasId == this.kelasId &&
          other.jenis == this.jenis &&
          other.tanggal == this.tanggal &&
          other.jamMulai == this.jamMulai &&
          other.jamSelesai == this.jamSelesai &&
          other.ruang == this.ruang &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class JadwalUjianCompanion extends UpdateCompanion<JadwalUjianRow> {
  final Value<int> id;
  final Value<int> kelasId;
  final Value<String> jenis;
  final Value<DateTime> tanggal;
  final Value<String> jamMulai;
  final Value<String> jamSelesai;
  final Value<String> ruang;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const JadwalUjianCompanion({
    this.id = const Value.absent(),
    this.kelasId = const Value.absent(),
    this.jenis = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.jamMulai = const Value.absent(),
    this.jamSelesai = const Value.absent(),
    this.ruang = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  JadwalUjianCompanion.insert({
    this.id = const Value.absent(),
    required int kelasId,
    required String jenis,
    required DateTime tanggal,
    required String jamMulai,
    required String jamSelesai,
    this.ruang = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : kelasId = Value(kelasId),
       jenis = Value(jenis),
       tanggal = Value(tanggal),
       jamMulai = Value(jamMulai),
       jamSelesai = Value(jamSelesai),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<JadwalUjianRow> custom({
    Expression<int>? id,
    Expression<int>? kelasId,
    Expression<String>? jenis,
    Expression<DateTime>? tanggal,
    Expression<String>? jamMulai,
    Expression<String>? jamSelesai,
    Expression<String>? ruang,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kelasId != null) 'kelas_id': kelasId,
      if (jenis != null) 'jenis': jenis,
      if (tanggal != null) 'tanggal': tanggal,
      if (jamMulai != null) 'jam_mulai': jamMulai,
      if (jamSelesai != null) 'jam_selesai': jamSelesai,
      if (ruang != null) 'ruang': ruang,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  JadwalUjianCompanion copyWith({
    Value<int>? id,
    Value<int>? kelasId,
    Value<String>? jenis,
    Value<DateTime>? tanggal,
    Value<String>? jamMulai,
    Value<String>? jamSelesai,
    Value<String>? ruang,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return JadwalUjianCompanion(
      id: id ?? this.id,
      kelasId: kelasId ?? this.kelasId,
      jenis: jenis ?? this.jenis,
      tanggal: tanggal ?? this.tanggal,
      jamMulai: jamMulai ?? this.jamMulai,
      jamSelesai: jamSelesai ?? this.jamSelesai,
      ruang: ruang ?? this.ruang,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kelasId.present) {
      map['kelas_id'] = Variable<int>(kelasId.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (jamMulai.present) {
      map['jam_mulai'] = Variable<String>(jamMulai.value);
    }
    if (jamSelesai.present) {
      map['jam_selesai'] = Variable<String>(jamSelesai.value);
    }
    if (ruang.present) {
      map['ruang'] = Variable<String>(ruang.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JadwalUjianCompanion(')
          ..write('id: $id, ')
          ..write('kelasId: $kelasId, ')
          ..write('jenis: $jenis, ')
          ..write('tanggal: $tanggal, ')
          ..write('jamMulai: $jamMulai, ')
          ..write('jamSelesai: $jamSelesai, ')
          ..write('ruang: $ruang, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $PrestasiTable extends Prestasi
    with TableInfo<$PrestasiTable, PrestasiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrestasiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('akademik'),
  );
  static const VerificationMeta _tingkatMeta = const VerificationMeta(
    'tingkat',
  );
  @override
  late final GeneratedColumn<String> tingkat = GeneratedColumn<String>(
    'tingkat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kampus'),
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deskripsiMeta = const VerificationMeta(
    'deskripsi',
  );
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
    'deskripsi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lampiranPathMeta = const VerificationMeta(
    'lampiranPath',
  );
  @override
  late final GeneratedColumn<String> lampiranPath = GeneratedColumn<String>(
    'lampiran_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mahasiswaId,
    judul,
    kategori,
    tingkat,
    tanggal,
    deskripsi,
    lampiranPath,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prestasi';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrestasiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    }
    if (data.containsKey('tingkat')) {
      context.handle(
        _tingkatMeta,
        tingkat.isAcceptableOrUnknown(data['tingkat']!, _tingkatMeta),
      );
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    }
    if (data.containsKey('deskripsi')) {
      context.handle(
        _deskripsiMeta,
        deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta),
      );
    }
    if (data.containsKey('lampiran_path')) {
      context.handle(
        _lampiranPathMeta,
        lampiranPath.isAcceptableOrUnknown(
          data['lampiran_path']!,
          _lampiranPathMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrestasiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrestasiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      )!,
      tingkat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tingkat'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      ),
      deskripsi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deskripsi'],
      )!,
      lampiranPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lampiran_path'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $PrestasiTable createAlias(String alias) {
    return $PrestasiTable(attachedDatabase, alias);
  }
}

class PrestasiRow extends DataClass implements Insertable<PrestasiRow> {
  final int id;
  final int mahasiswaId;
  final String judul;
  final String kategori;
  final String tingkat;
  final DateTime? tanggal;
  final String deskripsi;
  final String? lampiranPath;
  final DateTime updatedAt;
  final String deviceId;
  const PrestasiRow({
    required this.id,
    required this.mahasiswaId,
    required this.judul,
    required this.kategori,
    required this.tingkat,
    this.tanggal,
    required this.deskripsi,
    this.lampiranPath,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['judul'] = Variable<String>(judul);
    map['kategori'] = Variable<String>(kategori);
    map['tingkat'] = Variable<String>(tingkat);
    if (!nullToAbsent || tanggal != null) {
      map['tanggal'] = Variable<DateTime>(tanggal);
    }
    map['deskripsi'] = Variable<String>(deskripsi);
    if (!nullToAbsent || lampiranPath != null) {
      map['lampiran_path'] = Variable<String>(lampiranPath);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  PrestasiCompanion toCompanion(bool nullToAbsent) {
    return PrestasiCompanion(
      id: Value(id),
      mahasiswaId: Value(mahasiswaId),
      judul: Value(judul),
      kategori: Value(kategori),
      tingkat: Value(tingkat),
      tanggal: tanggal == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggal),
      deskripsi: Value(deskripsi),
      lampiranPath: lampiranPath == null && nullToAbsent
          ? const Value.absent()
          : Value(lampiranPath),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory PrestasiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrestasiRow(
      id: serializer.fromJson<int>(json['id']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      judul: serializer.fromJson<String>(json['judul']),
      kategori: serializer.fromJson<String>(json['kategori']),
      tingkat: serializer.fromJson<String>(json['tingkat']),
      tanggal: serializer.fromJson<DateTime?>(json['tanggal']),
      deskripsi: serializer.fromJson<String>(json['deskripsi']),
      lampiranPath: serializer.fromJson<String?>(json['lampiranPath']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'judul': serializer.toJson<String>(judul),
      'kategori': serializer.toJson<String>(kategori),
      'tingkat': serializer.toJson<String>(tingkat),
      'tanggal': serializer.toJson<DateTime?>(tanggal),
      'deskripsi': serializer.toJson<String>(deskripsi),
      'lampiranPath': serializer.toJson<String?>(lampiranPath),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  PrestasiRow copyWith({
    int? id,
    int? mahasiswaId,
    String? judul,
    String? kategori,
    String? tingkat,
    Value<DateTime?> tanggal = const Value.absent(),
    String? deskripsi,
    Value<String?> lampiranPath = const Value.absent(),
    DateTime? updatedAt,
    String? deviceId,
  }) => PrestasiRow(
    id: id ?? this.id,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    judul: judul ?? this.judul,
    kategori: kategori ?? this.kategori,
    tingkat: tingkat ?? this.tingkat,
    tanggal: tanggal.present ? tanggal.value : this.tanggal,
    deskripsi: deskripsi ?? this.deskripsi,
    lampiranPath: lampiranPath.present ? lampiranPath.value : this.lampiranPath,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  PrestasiRow copyWithCompanion(PrestasiCompanion data) {
    return PrestasiRow(
      id: data.id.present ? data.id.value : this.id,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      judul: data.judul.present ? data.judul.value : this.judul,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      tingkat: data.tingkat.present ? data.tingkat.value : this.tingkat,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      deskripsi: data.deskripsi.present ? data.deskripsi.value : this.deskripsi,
      lampiranPath: data.lampiranPath.present
          ? data.lampiranPath.value
          : this.lampiranPath,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrestasiRow(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('judul: $judul, ')
          ..write('kategori: $kategori, ')
          ..write('tingkat: $tingkat, ')
          ..write('tanggal: $tanggal, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('lampiranPath: $lampiranPath, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mahasiswaId,
    judul,
    kategori,
    tingkat,
    tanggal,
    deskripsi,
    lampiranPath,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrestasiRow &&
          other.id == this.id &&
          other.mahasiswaId == this.mahasiswaId &&
          other.judul == this.judul &&
          other.kategori == this.kategori &&
          other.tingkat == this.tingkat &&
          other.tanggal == this.tanggal &&
          other.deskripsi == this.deskripsi &&
          other.lampiranPath == this.lampiranPath &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class PrestasiCompanion extends UpdateCompanion<PrestasiRow> {
  final Value<int> id;
  final Value<int> mahasiswaId;
  final Value<String> judul;
  final Value<String> kategori;
  final Value<String> tingkat;
  final Value<DateTime?> tanggal;
  final Value<String> deskripsi;
  final Value<String?> lampiranPath;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const PrestasiCompanion({
    this.id = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.judul = const Value.absent(),
    this.kategori = const Value.absent(),
    this.tingkat = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.lampiranPath = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  PrestasiCompanion.insert({
    this.id = const Value.absent(),
    required int mahasiswaId,
    required String judul,
    this.kategori = const Value.absent(),
    this.tingkat = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.lampiranPath = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : mahasiswaId = Value(mahasiswaId),
       judul = Value(judul),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<PrestasiRow> custom({
    Expression<int>? id,
    Expression<int>? mahasiswaId,
    Expression<String>? judul,
    Expression<String>? kategori,
    Expression<String>? tingkat,
    Expression<DateTime>? tanggal,
    Expression<String>? deskripsi,
    Expression<String>? lampiranPath,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (judul != null) 'judul': judul,
      if (kategori != null) 'kategori': kategori,
      if (tingkat != null) 'tingkat': tingkat,
      if (tanggal != null) 'tanggal': tanggal,
      if (deskripsi != null) 'deskripsi': deskripsi,
      if (lampiranPath != null) 'lampiran_path': lampiranPath,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  PrestasiCompanion copyWith({
    Value<int>? id,
    Value<int>? mahasiswaId,
    Value<String>? judul,
    Value<String>? kategori,
    Value<String>? tingkat,
    Value<DateTime?>? tanggal,
    Value<String>? deskripsi,
    Value<String?>? lampiranPath,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return PrestasiCompanion(
      id: id ?? this.id,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      judul: judul ?? this.judul,
      kategori: kategori ?? this.kategori,
      tingkat: tingkat ?? this.tingkat,
      tanggal: tanggal ?? this.tanggal,
      deskripsi: deskripsi ?? this.deskripsi,
      lampiranPath: lampiranPath ?? this.lampiranPath,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (tingkat.present) {
      map['tingkat'] = Variable<String>(tingkat.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    if (lampiranPath.present) {
      map['lampiran_path'] = Variable<String>(lampiranPath.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrestasiCompanion(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('judul: $judul, ')
          ..write('kategori: $kategori, ')
          ..write('tingkat: $tingkat, ')
          ..write('tanggal: $tanggal, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('lampiranPath: $lampiranPath, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $EdomPeriodeTable extends EdomPeriode
    with TableInfo<$EdomPeriodeTable, EdomPeriodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EdomPeriodeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taIdMeta = const VerificationMeta('taId');
  @override
  late final GeneratedColumn<int> taId = GeneratedColumn<int>(
    'ta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tahun_ajaran (id)',
    ),
  );
  static const VerificationMeta _dibukaMeta = const VerificationMeta('dibuka');
  @override
  late final GeneratedColumn<DateTime> dibuka = GeneratedColumn<DateTime>(
    'dibuka',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ditutupMeta = const VerificationMeta(
    'ditutup',
  );
  @override
  late final GeneratedColumn<DateTime> ditutup = GeneratedColumn<DateTime>(
    'ditutup',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAktifMeta = const VerificationMeta(
    'isAktif',
  );
  @override
  late final GeneratedColumn<bool> isAktif = GeneratedColumn<bool>(
    'is_aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_aktif" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taId,
    dibuka,
    ditutup,
    isAktif,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'edom_periode';
  @override
  VerificationContext validateIntegrity(
    Insertable<EdomPeriodeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ta_id')) {
      context.handle(
        _taIdMeta,
        taId.isAcceptableOrUnknown(data['ta_id']!, _taIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taIdMeta);
    }
    if (data.containsKey('dibuka')) {
      context.handle(
        _dibukaMeta,
        dibuka.isAcceptableOrUnknown(data['dibuka']!, _dibukaMeta),
      );
    }
    if (data.containsKey('ditutup')) {
      context.handle(
        _ditutupMeta,
        ditutup.isAcceptableOrUnknown(data['ditutup']!, _ditutupMeta),
      );
    }
    if (data.containsKey('is_aktif')) {
      context.handle(
        _isAktifMeta,
        isAktif.isAcceptableOrUnknown(data['is_aktif']!, _isAktifMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EdomPeriodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EdomPeriodeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ta_id'],
      )!,
      dibuka: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuka'],
      ),
      ditutup: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ditutup'],
      ),
      isAktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_aktif'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $EdomPeriodeTable createAlias(String alias) {
    return $EdomPeriodeTable(attachedDatabase, alias);
  }
}

class EdomPeriodeRow extends DataClass implements Insertable<EdomPeriodeRow> {
  final int id;
  final int taId;
  final DateTime? dibuka;
  final DateTime? ditutup;
  final bool isAktif;
  final DateTime updatedAt;
  final String deviceId;
  const EdomPeriodeRow({
    required this.id,
    required this.taId,
    this.dibuka,
    this.ditutup,
    required this.isAktif,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ta_id'] = Variable<int>(taId);
    if (!nullToAbsent || dibuka != null) {
      map['dibuka'] = Variable<DateTime>(dibuka);
    }
    if (!nullToAbsent || ditutup != null) {
      map['ditutup'] = Variable<DateTime>(ditutup);
    }
    map['is_aktif'] = Variable<bool>(isAktif);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  EdomPeriodeCompanion toCompanion(bool nullToAbsent) {
    return EdomPeriodeCompanion(
      id: Value(id),
      taId: Value(taId),
      dibuka: dibuka == null && nullToAbsent
          ? const Value.absent()
          : Value(dibuka),
      ditutup: ditutup == null && nullToAbsent
          ? const Value.absent()
          : Value(ditutup),
      isAktif: Value(isAktif),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory EdomPeriodeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EdomPeriodeRow(
      id: serializer.fromJson<int>(json['id']),
      taId: serializer.fromJson<int>(json['taId']),
      dibuka: serializer.fromJson<DateTime?>(json['dibuka']),
      ditutup: serializer.fromJson<DateTime?>(json['ditutup']),
      isAktif: serializer.fromJson<bool>(json['isAktif']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taId': serializer.toJson<int>(taId),
      'dibuka': serializer.toJson<DateTime?>(dibuka),
      'ditutup': serializer.toJson<DateTime?>(ditutup),
      'isAktif': serializer.toJson<bool>(isAktif),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  EdomPeriodeRow copyWith({
    int? id,
    int? taId,
    Value<DateTime?> dibuka = const Value.absent(),
    Value<DateTime?> ditutup = const Value.absent(),
    bool? isAktif,
    DateTime? updatedAt,
    String? deviceId,
  }) => EdomPeriodeRow(
    id: id ?? this.id,
    taId: taId ?? this.taId,
    dibuka: dibuka.present ? dibuka.value : this.dibuka,
    ditutup: ditutup.present ? ditutup.value : this.ditutup,
    isAktif: isAktif ?? this.isAktif,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  EdomPeriodeRow copyWithCompanion(EdomPeriodeCompanion data) {
    return EdomPeriodeRow(
      id: data.id.present ? data.id.value : this.id,
      taId: data.taId.present ? data.taId.value : this.taId,
      dibuka: data.dibuka.present ? data.dibuka.value : this.dibuka,
      ditutup: data.ditutup.present ? data.ditutup.value : this.ditutup,
      isAktif: data.isAktif.present ? data.isAktif.value : this.isAktif,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EdomPeriodeRow(')
          ..write('id: $id, ')
          ..write('taId: $taId, ')
          ..write('dibuka: $dibuka, ')
          ..write('ditutup: $ditutup, ')
          ..write('isAktif: $isAktif, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taId, dibuka, ditutup, isAktif, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EdomPeriodeRow &&
          other.id == this.id &&
          other.taId == this.taId &&
          other.dibuka == this.dibuka &&
          other.ditutup == this.ditutup &&
          other.isAktif == this.isAktif &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class EdomPeriodeCompanion extends UpdateCompanion<EdomPeriodeRow> {
  final Value<int> id;
  final Value<int> taId;
  final Value<DateTime?> dibuka;
  final Value<DateTime?> ditutup;
  final Value<bool> isAktif;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const EdomPeriodeCompanion({
    this.id = const Value.absent(),
    this.taId = const Value.absent(),
    this.dibuka = const Value.absent(),
    this.ditutup = const Value.absent(),
    this.isAktif = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  EdomPeriodeCompanion.insert({
    this.id = const Value.absent(),
    required int taId,
    this.dibuka = const Value.absent(),
    this.ditutup = const Value.absent(),
    this.isAktif = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : taId = Value(taId),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<EdomPeriodeRow> custom({
    Expression<int>? id,
    Expression<int>? taId,
    Expression<DateTime>? dibuka,
    Expression<DateTime>? ditutup,
    Expression<bool>? isAktif,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taId != null) 'ta_id': taId,
      if (dibuka != null) 'dibuka': dibuka,
      if (ditutup != null) 'ditutup': ditutup,
      if (isAktif != null) 'is_aktif': isAktif,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  EdomPeriodeCompanion copyWith({
    Value<int>? id,
    Value<int>? taId,
    Value<DateTime?>? dibuka,
    Value<DateTime?>? ditutup,
    Value<bool>? isAktif,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return EdomPeriodeCompanion(
      id: id ?? this.id,
      taId: taId ?? this.taId,
      dibuka: dibuka ?? this.dibuka,
      ditutup: ditutup ?? this.ditutup,
      isAktif: isAktif ?? this.isAktif,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taId.present) {
      map['ta_id'] = Variable<int>(taId.value);
    }
    if (dibuka.present) {
      map['dibuka'] = Variable<DateTime>(dibuka.value);
    }
    if (ditutup.present) {
      map['ditutup'] = Variable<DateTime>(ditutup.value);
    }
    if (isAktif.present) {
      map['is_aktif'] = Variable<bool>(isAktif.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EdomPeriodeCompanion(')
          ..write('id: $id, ')
          ..write('taId: $taId, ')
          ..write('dibuka: $dibuka, ')
          ..write('ditutup: $ditutup, ')
          ..write('isAktif: $isAktif, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $EdomPertanyaanTable extends EdomPertanyaan
    with TableInfo<$EdomPertanyaanTable, EdomPertanyaanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EdomPertanyaanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _aspekMeta = const VerificationMeta('aspek');
  @override
  late final GeneratedColumn<String> aspek = GeneratedColumn<String>(
    'aspek',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teksMeta = const VerificationMeta('teks');
  @override
  late final GeneratedColumn<String> teks = GeneratedColumn<String>(
    'teks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, aspek, teks, updatedAt, deviceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'edom_pertanyaan';
  @override
  VerificationContext validateIntegrity(
    Insertable<EdomPertanyaanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('aspek')) {
      context.handle(
        _aspekMeta,
        aspek.isAcceptableOrUnknown(data['aspek']!, _aspekMeta),
      );
    } else if (isInserting) {
      context.missing(_aspekMeta);
    }
    if (data.containsKey('teks')) {
      context.handle(
        _teksMeta,
        teks.isAcceptableOrUnknown(data['teks']!, _teksMeta),
      );
    } else if (isInserting) {
      context.missing(_teksMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EdomPertanyaanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EdomPertanyaanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      aspek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aspek'],
      )!,
      teks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teks'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $EdomPertanyaanTable createAlias(String alias) {
    return $EdomPertanyaanTable(attachedDatabase, alias);
  }
}

class EdomPertanyaanRow extends DataClass
    implements Insertable<EdomPertanyaanRow> {
  final int id;
  final String aspek;
  final String teks;
  final DateTime updatedAt;
  final String deviceId;
  const EdomPertanyaanRow({
    required this.id,
    required this.aspek,
    required this.teks,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['aspek'] = Variable<String>(aspek);
    map['teks'] = Variable<String>(teks);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  EdomPertanyaanCompanion toCompanion(bool nullToAbsent) {
    return EdomPertanyaanCompanion(
      id: Value(id),
      aspek: Value(aspek),
      teks: Value(teks),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory EdomPertanyaanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EdomPertanyaanRow(
      id: serializer.fromJson<int>(json['id']),
      aspek: serializer.fromJson<String>(json['aspek']),
      teks: serializer.fromJson<String>(json['teks']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'aspek': serializer.toJson<String>(aspek),
      'teks': serializer.toJson<String>(teks),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  EdomPertanyaanRow copyWith({
    int? id,
    String? aspek,
    String? teks,
    DateTime? updatedAt,
    String? deviceId,
  }) => EdomPertanyaanRow(
    id: id ?? this.id,
    aspek: aspek ?? this.aspek,
    teks: teks ?? this.teks,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  EdomPertanyaanRow copyWithCompanion(EdomPertanyaanCompanion data) {
    return EdomPertanyaanRow(
      id: data.id.present ? data.id.value : this.id,
      aspek: data.aspek.present ? data.aspek.value : this.aspek,
      teks: data.teks.present ? data.teks.value : this.teks,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EdomPertanyaanRow(')
          ..write('id: $id, ')
          ..write('aspek: $aspek, ')
          ..write('teks: $teks, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, aspek, teks, updatedAt, deviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EdomPertanyaanRow &&
          other.id == this.id &&
          other.aspek == this.aspek &&
          other.teks == this.teks &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class EdomPertanyaanCompanion extends UpdateCompanion<EdomPertanyaanRow> {
  final Value<int> id;
  final Value<String> aspek;
  final Value<String> teks;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const EdomPertanyaanCompanion({
    this.id = const Value.absent(),
    this.aspek = const Value.absent(),
    this.teks = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  EdomPertanyaanCompanion.insert({
    this.id = const Value.absent(),
    required String aspek,
    required String teks,
    required DateTime updatedAt,
    required String deviceId,
  }) : aspek = Value(aspek),
       teks = Value(teks),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<EdomPertanyaanRow> custom({
    Expression<int>? id,
    Expression<String>? aspek,
    Expression<String>? teks,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (aspek != null) 'aspek': aspek,
      if (teks != null) 'teks': teks,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  EdomPertanyaanCompanion copyWith({
    Value<int>? id,
    Value<String>? aspek,
    Value<String>? teks,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return EdomPertanyaanCompanion(
      id: id ?? this.id,
      aspek: aspek ?? this.aspek,
      teks: teks ?? this.teks,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (aspek.present) {
      map['aspek'] = Variable<String>(aspek.value);
    }
    if (teks.present) {
      map['teks'] = Variable<String>(teks.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EdomPertanyaanCompanion(')
          ..write('id: $id, ')
          ..write('aspek: $aspek, ')
          ..write('teks: $teks, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $EdomPartisipasiTable extends EdomPartisipasi
    with TableInfo<$EdomPartisipasiTable, EdomPartisipasiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EdomPartisipasiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _periodeIdMeta = const VerificationMeta(
    'periodeId',
  );
  @override
  late final GeneratedColumn<int> periodeId = GeneratedColumn<int>(
    'periode_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES edom_periode (id)',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _kelasIdMeta = const VerificationMeta(
    'kelasId',
  );
  @override
  late final GeneratedColumn<int> kelasId = GeneratedColumn<int>(
    'kelas_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kelas (id)',
    ),
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    periodeId,
    mahasiswaId,
    kelasId,
    waktu,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'edom_partisipasi';
  @override
  VerificationContext validateIntegrity(
    Insertable<EdomPartisipasiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('periode_id')) {
      context.handle(
        _periodeIdMeta,
        periodeId.isAcceptableOrUnknown(data['periode_id']!, _periodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_periodeIdMeta);
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('kelas_id')) {
      context.handle(
        _kelasIdMeta,
        kelasId.isAcceptableOrUnknown(data['kelas_id']!, _kelasIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kelasIdMeta);
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {periodeId, mahasiswaId, kelasId},
  ];
  @override
  EdomPartisipasiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EdomPartisipasiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      periodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}periode_id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      kelasId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kelas_id'],
      )!,
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $EdomPartisipasiTable createAlias(String alias) {
    return $EdomPartisipasiTable(attachedDatabase, alias);
  }
}

class EdomPartisipasiRow extends DataClass
    implements Insertable<EdomPartisipasiRow> {
  final int id;
  final int periodeId;
  final int mahasiswaId;
  final int kelasId;
  final DateTime waktu;
  final DateTime updatedAt;
  final String deviceId;
  const EdomPartisipasiRow({
    required this.id,
    required this.periodeId,
    required this.mahasiswaId,
    required this.kelasId,
    required this.waktu,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['periode_id'] = Variable<int>(periodeId);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['kelas_id'] = Variable<int>(kelasId);
    map['waktu'] = Variable<DateTime>(waktu);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  EdomPartisipasiCompanion toCompanion(bool nullToAbsent) {
    return EdomPartisipasiCompanion(
      id: Value(id),
      periodeId: Value(periodeId),
      mahasiswaId: Value(mahasiswaId),
      kelasId: Value(kelasId),
      waktu: Value(waktu),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory EdomPartisipasiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EdomPartisipasiRow(
      id: serializer.fromJson<int>(json['id']),
      periodeId: serializer.fromJson<int>(json['periodeId']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      kelasId: serializer.fromJson<int>(json['kelasId']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'periodeId': serializer.toJson<int>(periodeId),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'kelasId': serializer.toJson<int>(kelasId),
      'waktu': serializer.toJson<DateTime>(waktu),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  EdomPartisipasiRow copyWith({
    int? id,
    int? periodeId,
    int? mahasiswaId,
    int? kelasId,
    DateTime? waktu,
    DateTime? updatedAt,
    String? deviceId,
  }) => EdomPartisipasiRow(
    id: id ?? this.id,
    periodeId: periodeId ?? this.periodeId,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    kelasId: kelasId ?? this.kelasId,
    waktu: waktu ?? this.waktu,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  EdomPartisipasiRow copyWithCompanion(EdomPartisipasiCompanion data) {
    return EdomPartisipasiRow(
      id: data.id.present ? data.id.value : this.id,
      periodeId: data.periodeId.present ? data.periodeId.value : this.periodeId,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      kelasId: data.kelasId.present ? data.kelasId.value : this.kelasId,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EdomPartisipasiRow(')
          ..write('id: $id, ')
          ..write('periodeId: $periodeId, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('kelasId: $kelasId, ')
          ..write('waktu: $waktu, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    periodeId,
    mahasiswaId,
    kelasId,
    waktu,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EdomPartisipasiRow &&
          other.id == this.id &&
          other.periodeId == this.periodeId &&
          other.mahasiswaId == this.mahasiswaId &&
          other.kelasId == this.kelasId &&
          other.waktu == this.waktu &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class EdomPartisipasiCompanion extends UpdateCompanion<EdomPartisipasiRow> {
  final Value<int> id;
  final Value<int> periodeId;
  final Value<int> mahasiswaId;
  final Value<int> kelasId;
  final Value<DateTime> waktu;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const EdomPartisipasiCompanion({
    this.id = const Value.absent(),
    this.periodeId = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.kelasId = const Value.absent(),
    this.waktu = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  EdomPartisipasiCompanion.insert({
    this.id = const Value.absent(),
    required int periodeId,
    required int mahasiswaId,
    required int kelasId,
    required DateTime waktu,
    required DateTime updatedAt,
    required String deviceId,
  }) : periodeId = Value(periodeId),
       mahasiswaId = Value(mahasiswaId),
       kelasId = Value(kelasId),
       waktu = Value(waktu),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<EdomPartisipasiRow> custom({
    Expression<int>? id,
    Expression<int>? periodeId,
    Expression<int>? mahasiswaId,
    Expression<int>? kelasId,
    Expression<DateTime>? waktu,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (periodeId != null) 'periode_id': periodeId,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (kelasId != null) 'kelas_id': kelasId,
      if (waktu != null) 'waktu': waktu,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  EdomPartisipasiCompanion copyWith({
    Value<int>? id,
    Value<int>? periodeId,
    Value<int>? mahasiswaId,
    Value<int>? kelasId,
    Value<DateTime>? waktu,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return EdomPartisipasiCompanion(
      id: id ?? this.id,
      periodeId: periodeId ?? this.periodeId,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      kelasId: kelasId ?? this.kelasId,
      waktu: waktu ?? this.waktu,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (periodeId.present) {
      map['periode_id'] = Variable<int>(periodeId.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (kelasId.present) {
      map['kelas_id'] = Variable<int>(kelasId.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EdomPartisipasiCompanion(')
          ..write('id: $id, ')
          ..write('periodeId: $periodeId, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('kelasId: $kelasId, ')
          ..write('waktu: $waktu, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $EdomJawabanTable extends EdomJawaban
    with TableInfo<$EdomJawabanTable, EdomJawabanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EdomJawabanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _periodeIdMeta = const VerificationMeta(
    'periodeId',
  );
  @override
  late final GeneratedColumn<int> periodeId = GeneratedColumn<int>(
    'periode_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES edom_periode (id)',
    ),
  );
  static const VerificationMeta _dosenIdMeta = const VerificationMeta(
    'dosenId',
  );
  @override
  late final GeneratedColumn<int> dosenId = GeneratedColumn<int>(
    'dosen_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dosens (id)',
    ),
  );
  static const VerificationMeta _kelasIdMeta = const VerificationMeta(
    'kelasId',
  );
  @override
  late final GeneratedColumn<int> kelasId = GeneratedColumn<int>(
    'kelas_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES kelas (id)',
    ),
  );
  static const VerificationMeta _pertanyaanIdMeta = const VerificationMeta(
    'pertanyaanId',
  );
  @override
  late final GeneratedColumn<int> pertanyaanId = GeneratedColumn<int>(
    'pertanyaan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES edom_pertanyaan (id)',
    ),
  );
  static const VerificationMeta _skorMeta = const VerificationMeta('skor');
  @override
  late final GeneratedColumn<int> skor = GeneratedColumn<int>(
    'skor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _komentarMeta = const VerificationMeta(
    'komentar',
  );
  @override
  late final GeneratedColumn<String> komentar = GeneratedColumn<String>(
    'komentar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    periodeId,
    dosenId,
    kelasId,
    pertanyaanId,
    skor,
    komentar,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'edom_jawaban';
  @override
  VerificationContext validateIntegrity(
    Insertable<EdomJawabanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('periode_id')) {
      context.handle(
        _periodeIdMeta,
        periodeId.isAcceptableOrUnknown(data['periode_id']!, _periodeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_periodeIdMeta);
    }
    if (data.containsKey('dosen_id')) {
      context.handle(
        _dosenIdMeta,
        dosenId.isAcceptableOrUnknown(data['dosen_id']!, _dosenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dosenIdMeta);
    }
    if (data.containsKey('kelas_id')) {
      context.handle(
        _kelasIdMeta,
        kelasId.isAcceptableOrUnknown(data['kelas_id']!, _kelasIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kelasIdMeta);
    }
    if (data.containsKey('pertanyaan_id')) {
      context.handle(
        _pertanyaanIdMeta,
        pertanyaanId.isAcceptableOrUnknown(
          data['pertanyaan_id']!,
          _pertanyaanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pertanyaanIdMeta);
    }
    if (data.containsKey('skor')) {
      context.handle(
        _skorMeta,
        skor.isAcceptableOrUnknown(data['skor']!, _skorMeta),
      );
    } else if (isInserting) {
      context.missing(_skorMeta);
    }
    if (data.containsKey('komentar')) {
      context.handle(
        _komentarMeta,
        komentar.isAcceptableOrUnknown(data['komentar']!, _komentarMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EdomJawabanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EdomJawabanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      periodeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}periode_id'],
      )!,
      dosenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dosen_id'],
      )!,
      kelasId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kelas_id'],
      )!,
      pertanyaanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pertanyaan_id'],
      )!,
      skor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skor'],
      )!,
      komentar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}komentar'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $EdomJawabanTable createAlias(String alias) {
    return $EdomJawabanTable(attachedDatabase, alias);
  }
}

class EdomJawabanRow extends DataClass implements Insertable<EdomJawabanRow> {
  final int id;
  final int periodeId;
  final int dosenId;
  final int kelasId;
  final int pertanyaanId;
  final int skor;
  final String komentar;
  final DateTime updatedAt;
  final String deviceId;
  const EdomJawabanRow({
    required this.id,
    required this.periodeId,
    required this.dosenId,
    required this.kelasId,
    required this.pertanyaanId,
    required this.skor,
    required this.komentar,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['periode_id'] = Variable<int>(periodeId);
    map['dosen_id'] = Variable<int>(dosenId);
    map['kelas_id'] = Variable<int>(kelasId);
    map['pertanyaan_id'] = Variable<int>(pertanyaanId);
    map['skor'] = Variable<int>(skor);
    map['komentar'] = Variable<String>(komentar);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  EdomJawabanCompanion toCompanion(bool nullToAbsent) {
    return EdomJawabanCompanion(
      id: Value(id),
      periodeId: Value(periodeId),
      dosenId: Value(dosenId),
      kelasId: Value(kelasId),
      pertanyaanId: Value(pertanyaanId),
      skor: Value(skor),
      komentar: Value(komentar),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory EdomJawabanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EdomJawabanRow(
      id: serializer.fromJson<int>(json['id']),
      periodeId: serializer.fromJson<int>(json['periodeId']),
      dosenId: serializer.fromJson<int>(json['dosenId']),
      kelasId: serializer.fromJson<int>(json['kelasId']),
      pertanyaanId: serializer.fromJson<int>(json['pertanyaanId']),
      skor: serializer.fromJson<int>(json['skor']),
      komentar: serializer.fromJson<String>(json['komentar']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'periodeId': serializer.toJson<int>(periodeId),
      'dosenId': serializer.toJson<int>(dosenId),
      'kelasId': serializer.toJson<int>(kelasId),
      'pertanyaanId': serializer.toJson<int>(pertanyaanId),
      'skor': serializer.toJson<int>(skor),
      'komentar': serializer.toJson<String>(komentar),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  EdomJawabanRow copyWith({
    int? id,
    int? periodeId,
    int? dosenId,
    int? kelasId,
    int? pertanyaanId,
    int? skor,
    String? komentar,
    DateTime? updatedAt,
    String? deviceId,
  }) => EdomJawabanRow(
    id: id ?? this.id,
    periodeId: periodeId ?? this.periodeId,
    dosenId: dosenId ?? this.dosenId,
    kelasId: kelasId ?? this.kelasId,
    pertanyaanId: pertanyaanId ?? this.pertanyaanId,
    skor: skor ?? this.skor,
    komentar: komentar ?? this.komentar,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  EdomJawabanRow copyWithCompanion(EdomJawabanCompanion data) {
    return EdomJawabanRow(
      id: data.id.present ? data.id.value : this.id,
      periodeId: data.periodeId.present ? data.periodeId.value : this.periodeId,
      dosenId: data.dosenId.present ? data.dosenId.value : this.dosenId,
      kelasId: data.kelasId.present ? data.kelasId.value : this.kelasId,
      pertanyaanId: data.pertanyaanId.present
          ? data.pertanyaanId.value
          : this.pertanyaanId,
      skor: data.skor.present ? data.skor.value : this.skor,
      komentar: data.komentar.present ? data.komentar.value : this.komentar,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EdomJawabanRow(')
          ..write('id: $id, ')
          ..write('periodeId: $periodeId, ')
          ..write('dosenId: $dosenId, ')
          ..write('kelasId: $kelasId, ')
          ..write('pertanyaanId: $pertanyaanId, ')
          ..write('skor: $skor, ')
          ..write('komentar: $komentar, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    periodeId,
    dosenId,
    kelasId,
    pertanyaanId,
    skor,
    komentar,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EdomJawabanRow &&
          other.id == this.id &&
          other.periodeId == this.periodeId &&
          other.dosenId == this.dosenId &&
          other.kelasId == this.kelasId &&
          other.pertanyaanId == this.pertanyaanId &&
          other.skor == this.skor &&
          other.komentar == this.komentar &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class EdomJawabanCompanion extends UpdateCompanion<EdomJawabanRow> {
  final Value<int> id;
  final Value<int> periodeId;
  final Value<int> dosenId;
  final Value<int> kelasId;
  final Value<int> pertanyaanId;
  final Value<int> skor;
  final Value<String> komentar;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const EdomJawabanCompanion({
    this.id = const Value.absent(),
    this.periodeId = const Value.absent(),
    this.dosenId = const Value.absent(),
    this.kelasId = const Value.absent(),
    this.pertanyaanId = const Value.absent(),
    this.skor = const Value.absent(),
    this.komentar = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  EdomJawabanCompanion.insert({
    this.id = const Value.absent(),
    required int periodeId,
    required int dosenId,
    required int kelasId,
    required int pertanyaanId,
    required int skor,
    this.komentar = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
  }) : periodeId = Value(periodeId),
       dosenId = Value(dosenId),
       kelasId = Value(kelasId),
       pertanyaanId = Value(pertanyaanId),
       skor = Value(skor),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<EdomJawabanRow> custom({
    Expression<int>? id,
    Expression<int>? periodeId,
    Expression<int>? dosenId,
    Expression<int>? kelasId,
    Expression<int>? pertanyaanId,
    Expression<int>? skor,
    Expression<String>? komentar,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (periodeId != null) 'periode_id': periodeId,
      if (dosenId != null) 'dosen_id': dosenId,
      if (kelasId != null) 'kelas_id': kelasId,
      if (pertanyaanId != null) 'pertanyaan_id': pertanyaanId,
      if (skor != null) 'skor': skor,
      if (komentar != null) 'komentar': komentar,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  EdomJawabanCompanion copyWith({
    Value<int>? id,
    Value<int>? periodeId,
    Value<int>? dosenId,
    Value<int>? kelasId,
    Value<int>? pertanyaanId,
    Value<int>? skor,
    Value<String>? komentar,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return EdomJawabanCompanion(
      id: id ?? this.id,
      periodeId: periodeId ?? this.periodeId,
      dosenId: dosenId ?? this.dosenId,
      kelasId: kelasId ?? this.kelasId,
      pertanyaanId: pertanyaanId ?? this.pertanyaanId,
      skor: skor ?? this.skor,
      komentar: komentar ?? this.komentar,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (periodeId.present) {
      map['periode_id'] = Variable<int>(periodeId.value);
    }
    if (dosenId.present) {
      map['dosen_id'] = Variable<int>(dosenId.value);
    }
    if (kelasId.present) {
      map['kelas_id'] = Variable<int>(kelasId.value);
    }
    if (pertanyaanId.present) {
      map['pertanyaan_id'] = Variable<int>(pertanyaanId.value);
    }
    if (skor.present) {
      map['skor'] = Variable<int>(skor.value);
    }
    if (komentar.present) {
      map['komentar'] = Variable<String>(komentar.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EdomJawabanCompanion(')
          ..write('id: $id, ')
          ..write('periodeId: $periodeId, ')
          ..write('dosenId: $dosenId, ')
          ..write('kelasId: $kelasId, ')
          ..write('pertanyaanId: $pertanyaanId, ')
          ..write('skor: $skor, ')
          ..write('komentar: $komentar, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $DokumenArsipTable extends DokumenArsip
    with TableInfo<$DokumenArsipTable, DokumenArsipRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DokumenArsipTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mahasiswaIdMeta = const VerificationMeta(
    'mahasiswaId',
  );
  @override
  late final GeneratedColumn<int> mahasiswaId = GeneratedColumn<int>(
    'mahasiswa_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES mahasiswa (id)',
    ),
  );
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
    'jenis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaBerkasMeta = const VerificationMeta(
    'namaBerkas',
  );
  @override
  late final GeneratedColumn<String> namaBerkas = GeneratedColumn<String>(
    'nama_berkas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathTerenkripsiMeta = const VerificationMeta(
    'pathTerenkripsi',
  );
  @override
  late final GeneratedColumn<String> pathTerenkripsi = GeneratedColumn<String>(
    'path_terenkripsi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ukuranMeta = const VerificationMeta('ukuran');
  @override
  late final GeneratedColumn<int> ukuran = GeneratedColumn<int>(
    'ukuran',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _diunggahOlehMeta = const VerificationMeta(
    'diunggahOleh',
  );
  @override
  late final GeneratedColumn<int> diunggahOleh = GeneratedColumn<int>(
    'diunggah_oleh',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mahasiswaId,
    jenis,
    namaBerkas,
    pathTerenkripsi,
    ukuran,
    diunggahOleh,
    waktu,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dokumen_arsip';
  @override
  VerificationContext validateIntegrity(
    Insertable<DokumenArsipRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mahasiswa_id')) {
      context.handle(
        _mahasiswaIdMeta,
        mahasiswaId.isAcceptableOrUnknown(
          data['mahasiswa_id']!,
          _mahasiswaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mahasiswaIdMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
        _jenisMeta,
        jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta),
      );
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('nama_berkas')) {
      context.handle(
        _namaBerkasMeta,
        namaBerkas.isAcceptableOrUnknown(data['nama_berkas']!, _namaBerkasMeta),
      );
    } else if (isInserting) {
      context.missing(_namaBerkasMeta);
    }
    if (data.containsKey('path_terenkripsi')) {
      context.handle(
        _pathTerenkripsiMeta,
        pathTerenkripsi.isAcceptableOrUnknown(
          data['path_terenkripsi']!,
          _pathTerenkripsiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pathTerenkripsiMeta);
    }
    if (data.containsKey('ukuran')) {
      context.handle(
        _ukuranMeta,
        ukuran.isAcceptableOrUnknown(data['ukuran']!, _ukuranMeta),
      );
    }
    if (data.containsKey('diunggah_oleh')) {
      context.handle(
        _diunggahOlehMeta,
        diunggahOleh.isAcceptableOrUnknown(
          data['diunggah_oleh']!,
          _diunggahOlehMeta,
        ),
      );
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DokumenArsipRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DokumenArsipRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mahasiswaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mahasiswa_id'],
      )!,
      jenis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jenis'],
      )!,
      namaBerkas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_berkas'],
      )!,
      pathTerenkripsi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path_terenkripsi'],
      )!,
      ukuran: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ukuran'],
      )!,
      diunggahOleh: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}diunggah_oleh'],
      ),
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $DokumenArsipTable createAlias(String alias) {
    return $DokumenArsipTable(attachedDatabase, alias);
  }
}

class DokumenArsipRow extends DataClass implements Insertable<DokumenArsipRow> {
  final int id;
  final int mahasiswaId;
  final String jenis;
  final String namaBerkas;
  final String pathTerenkripsi;
  final int ukuran;
  final int? diunggahOleh;
  final DateTime waktu;
  final DateTime updatedAt;
  final String deviceId;
  const DokumenArsipRow({
    required this.id,
    required this.mahasiswaId,
    required this.jenis,
    required this.namaBerkas,
    required this.pathTerenkripsi,
    required this.ukuran,
    this.diunggahOleh,
    required this.waktu,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mahasiswa_id'] = Variable<int>(mahasiswaId);
    map['jenis'] = Variable<String>(jenis);
    map['nama_berkas'] = Variable<String>(namaBerkas);
    map['path_terenkripsi'] = Variable<String>(pathTerenkripsi);
    map['ukuran'] = Variable<int>(ukuran);
    if (!nullToAbsent || diunggahOleh != null) {
      map['diunggah_oleh'] = Variable<int>(diunggahOleh);
    }
    map['waktu'] = Variable<DateTime>(waktu);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  DokumenArsipCompanion toCompanion(bool nullToAbsent) {
    return DokumenArsipCompanion(
      id: Value(id),
      mahasiswaId: Value(mahasiswaId),
      jenis: Value(jenis),
      namaBerkas: Value(namaBerkas),
      pathTerenkripsi: Value(pathTerenkripsi),
      ukuran: Value(ukuran),
      diunggahOleh: diunggahOleh == null && nullToAbsent
          ? const Value.absent()
          : Value(diunggahOleh),
      waktu: Value(waktu),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory DokumenArsipRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DokumenArsipRow(
      id: serializer.fromJson<int>(json['id']),
      mahasiswaId: serializer.fromJson<int>(json['mahasiswaId']),
      jenis: serializer.fromJson<String>(json['jenis']),
      namaBerkas: serializer.fromJson<String>(json['namaBerkas']),
      pathTerenkripsi: serializer.fromJson<String>(json['pathTerenkripsi']),
      ukuran: serializer.fromJson<int>(json['ukuran']),
      diunggahOleh: serializer.fromJson<int?>(json['diunggahOleh']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mahasiswaId': serializer.toJson<int>(mahasiswaId),
      'jenis': serializer.toJson<String>(jenis),
      'namaBerkas': serializer.toJson<String>(namaBerkas),
      'pathTerenkripsi': serializer.toJson<String>(pathTerenkripsi),
      'ukuran': serializer.toJson<int>(ukuran),
      'diunggahOleh': serializer.toJson<int?>(diunggahOleh),
      'waktu': serializer.toJson<DateTime>(waktu),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  DokumenArsipRow copyWith({
    int? id,
    int? mahasiswaId,
    String? jenis,
    String? namaBerkas,
    String? pathTerenkripsi,
    int? ukuran,
    Value<int?> diunggahOleh = const Value.absent(),
    DateTime? waktu,
    DateTime? updatedAt,
    String? deviceId,
  }) => DokumenArsipRow(
    id: id ?? this.id,
    mahasiswaId: mahasiswaId ?? this.mahasiswaId,
    jenis: jenis ?? this.jenis,
    namaBerkas: namaBerkas ?? this.namaBerkas,
    pathTerenkripsi: pathTerenkripsi ?? this.pathTerenkripsi,
    ukuran: ukuran ?? this.ukuran,
    diunggahOleh: diunggahOleh.present ? diunggahOleh.value : this.diunggahOleh,
    waktu: waktu ?? this.waktu,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  DokumenArsipRow copyWithCompanion(DokumenArsipCompanion data) {
    return DokumenArsipRow(
      id: data.id.present ? data.id.value : this.id,
      mahasiswaId: data.mahasiswaId.present
          ? data.mahasiswaId.value
          : this.mahasiswaId,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      namaBerkas: data.namaBerkas.present
          ? data.namaBerkas.value
          : this.namaBerkas,
      pathTerenkripsi: data.pathTerenkripsi.present
          ? data.pathTerenkripsi.value
          : this.pathTerenkripsi,
      ukuran: data.ukuran.present ? data.ukuran.value : this.ukuran,
      diunggahOleh: data.diunggahOleh.present
          ? data.diunggahOleh.value
          : this.diunggahOleh,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DokumenArsipRow(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('jenis: $jenis, ')
          ..write('namaBerkas: $namaBerkas, ')
          ..write('pathTerenkripsi: $pathTerenkripsi, ')
          ..write('ukuran: $ukuran, ')
          ..write('diunggahOleh: $diunggahOleh, ')
          ..write('waktu: $waktu, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mahasiswaId,
    jenis,
    namaBerkas,
    pathTerenkripsi,
    ukuran,
    diunggahOleh,
    waktu,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DokumenArsipRow &&
          other.id == this.id &&
          other.mahasiswaId == this.mahasiswaId &&
          other.jenis == this.jenis &&
          other.namaBerkas == this.namaBerkas &&
          other.pathTerenkripsi == this.pathTerenkripsi &&
          other.ukuran == this.ukuran &&
          other.diunggahOleh == this.diunggahOleh &&
          other.waktu == this.waktu &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class DokumenArsipCompanion extends UpdateCompanion<DokumenArsipRow> {
  final Value<int> id;
  final Value<int> mahasiswaId;
  final Value<String> jenis;
  final Value<String> namaBerkas;
  final Value<String> pathTerenkripsi;
  final Value<int> ukuran;
  final Value<int?> diunggahOleh;
  final Value<DateTime> waktu;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const DokumenArsipCompanion({
    this.id = const Value.absent(),
    this.mahasiswaId = const Value.absent(),
    this.jenis = const Value.absent(),
    this.namaBerkas = const Value.absent(),
    this.pathTerenkripsi = const Value.absent(),
    this.ukuran = const Value.absent(),
    this.diunggahOleh = const Value.absent(),
    this.waktu = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  DokumenArsipCompanion.insert({
    this.id = const Value.absent(),
    required int mahasiswaId,
    required String jenis,
    required String namaBerkas,
    required String pathTerenkripsi,
    this.ukuran = const Value.absent(),
    this.diunggahOleh = const Value.absent(),
    required DateTime waktu,
    required DateTime updatedAt,
    required String deviceId,
  }) : mahasiswaId = Value(mahasiswaId),
       jenis = Value(jenis),
       namaBerkas = Value(namaBerkas),
       pathTerenkripsi = Value(pathTerenkripsi),
       waktu = Value(waktu),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<DokumenArsipRow> custom({
    Expression<int>? id,
    Expression<int>? mahasiswaId,
    Expression<String>? jenis,
    Expression<String>? namaBerkas,
    Expression<String>? pathTerenkripsi,
    Expression<int>? ukuran,
    Expression<int>? diunggahOleh,
    Expression<DateTime>? waktu,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mahasiswaId != null) 'mahasiswa_id': mahasiswaId,
      if (jenis != null) 'jenis': jenis,
      if (namaBerkas != null) 'nama_berkas': namaBerkas,
      if (pathTerenkripsi != null) 'path_terenkripsi': pathTerenkripsi,
      if (ukuran != null) 'ukuran': ukuran,
      if (diunggahOleh != null) 'diunggah_oleh': diunggahOleh,
      if (waktu != null) 'waktu': waktu,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  DokumenArsipCompanion copyWith({
    Value<int>? id,
    Value<int>? mahasiswaId,
    Value<String>? jenis,
    Value<String>? namaBerkas,
    Value<String>? pathTerenkripsi,
    Value<int>? ukuran,
    Value<int?>? diunggahOleh,
    Value<DateTime>? waktu,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return DokumenArsipCompanion(
      id: id ?? this.id,
      mahasiswaId: mahasiswaId ?? this.mahasiswaId,
      jenis: jenis ?? this.jenis,
      namaBerkas: namaBerkas ?? this.namaBerkas,
      pathTerenkripsi: pathTerenkripsi ?? this.pathTerenkripsi,
      ukuran: ukuran ?? this.ukuran,
      diunggahOleh: diunggahOleh ?? this.diunggahOleh,
      waktu: waktu ?? this.waktu,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mahasiswaId.present) {
      map['mahasiswa_id'] = Variable<int>(mahasiswaId.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (namaBerkas.present) {
      map['nama_berkas'] = Variable<String>(namaBerkas.value);
    }
    if (pathTerenkripsi.present) {
      map['path_terenkripsi'] = Variable<String>(pathTerenkripsi.value);
    }
    if (ukuran.present) {
      map['ukuran'] = Variable<int>(ukuran.value);
    }
    if (diunggahOleh.present) {
      map['diunggah_oleh'] = Variable<int>(diunggahOleh.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DokumenArsipCompanion(')
          ..write('id: $id, ')
          ..write('mahasiswaId: $mahasiswaId, ')
          ..write('jenis: $jenis, ')
          ..write('namaBerkas: $namaBerkas, ')
          ..write('pathTerenkripsi: $pathTerenkripsi, ')
          ..write('ukuran: $ukuran, ')
          ..write('diunggahOleh: $diunggahOleh, ')
          ..write('waktu: $waktu, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

class $SavedFiltersTable extends SavedFilters
    with TableInfo<$SavedFiltersTable, SavedFilterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedFiltersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kriteriaJsonMeta = const VerificationMeta(
    'kriteriaJson',
  );
  @override
  late final GeneratedColumn<String> kriteriaJson = GeneratedColumn<String>(
    'kriteria_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    kriteriaJson,
    userId,
    createdAt,
    updatedAt,
    deviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_filters';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedFilterRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('kriteria_json')) {
      context.handle(
        _kriteriaJsonMeta,
        kriteriaJson.isAcceptableOrUnknown(
          data['kriteria_json']!,
          _kriteriaJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kriteriaJsonMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedFilterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedFilterRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      kriteriaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kriteria_json'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
    );
  }

  @override
  $SavedFiltersTable createAlias(String alias) {
    return $SavedFiltersTable(attachedDatabase, alias);
  }
}

class SavedFilterRow extends DataClass implements Insertable<SavedFilterRow> {
  final int id;
  final String nama;
  final String kriteriaJson;
  final int? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deviceId;
  const SavedFilterRow({
    required this.id,
    required this.nama,
    required this.kriteriaJson,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['kriteria_json'] = Variable<String>(kriteriaJson);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    return map;
  }

  SavedFiltersCompanion toCompanion(bool nullToAbsent) {
    return SavedFiltersCompanion(
      id: Value(id),
      nama: Value(nama),
      kriteriaJson: Value(kriteriaJson),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
    );
  }

  factory SavedFilterRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedFilterRow(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      kriteriaJson: serializer.fromJson<String>(json['kriteriaJson']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'kriteriaJson': serializer.toJson<String>(kriteriaJson),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
    };
  }

  SavedFilterRow copyWith({
    int? id,
    String? nama,
    String? kriteriaJson,
    Value<int?> userId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deviceId,
  }) => SavedFilterRow(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    kriteriaJson: kriteriaJson ?? this.kriteriaJson,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
  );
  SavedFilterRow copyWithCompanion(SavedFiltersCompanion data) {
    return SavedFilterRow(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      kriteriaJson: data.kriteriaJson.present
          ? data.kriteriaJson.value
          : this.kriteriaJson,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedFilterRow(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kriteriaJson: $kriteriaJson, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nama,
    kriteriaJson,
    userId,
    createdAt,
    updatedAt,
    deviceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedFilterRow &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.kriteriaJson == this.kriteriaJson &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId);
}

class SavedFiltersCompanion extends UpdateCompanion<SavedFilterRow> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String> kriteriaJson;
  final Value<int?> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  const SavedFiltersCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.kriteriaJson = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
  });
  SavedFiltersCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    required String kriteriaJson,
    this.userId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    required String deviceId,
  }) : nama = Value(nama),
       kriteriaJson = Value(kriteriaJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<SavedFilterRow> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? kriteriaJson,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (kriteriaJson != null) 'kriteria_json': kriteriaJson,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
    });
  }

  SavedFiltersCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String>? kriteriaJson,
    Value<int?>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
  }) {
    return SavedFiltersCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kriteriaJson: kriteriaJson ?? this.kriteriaJson,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (kriteriaJson.present) {
      map['kriteria_json'] = Variable<String>(kriteriaJson.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedFiltersCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kriteriaJson: $kriteriaJson, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ProdiTable prodi = $ProdiTable(this);
  late final $DosensTable dosens = $DosensTable(this);
  late final $MahasiswaTable mahasiswa = $MahasiswaTable(this);
  late final $TahunAjaranTable tahunAjaran = $TahunAjaranTable(this);
  late final $MataKuliahTable mataKuliah = $MataKuliahTable(this);
  late final $PrasyaratMkTable prasyaratMk = $PrasyaratMkTable(this);
  late final $KelasTable kelas = $KelasTable(this);
  late final $KrsTable krs = $KrsTable(this);
  late final $NilaiTable nilai = $NilaiTable(this);
  late final $SesiPresensiTable sesiPresensi = $SesiPresensiTable(this);
  late final $PresensiTable presensi = $PresensiTable(this);
  late final $CatatanBimbinganTable catatanBimbingan = $CatatanBimbinganTable(
    this,
  );
  late final $PeringatanTable peringatan = $PeringatanTable(this);
  late final $AuditLogTable auditLog = $AuditLogTable(this);
  late final $SyncLogTable syncLog = $SyncLogTable(this);
  late final $PengaturanTable pengaturan = $PengaturanTable(this);
  late final $PengumumanTable pengumuman = $PengumumanTable(this);
  late final $AgendaAkademikTable agendaAkademik = $AgendaAkademikTable(this);
  late final $JadwalUjianTable jadwalUjian = $JadwalUjianTable(this);
  late final $PrestasiTable prestasi = $PrestasiTable(this);
  late final $EdomPeriodeTable edomPeriode = $EdomPeriodeTable(this);
  late final $EdomPertanyaanTable edomPertanyaan = $EdomPertanyaanTable(this);
  late final $EdomPartisipasiTable edomPartisipasi = $EdomPartisipasiTable(
    this,
  );
  late final $EdomJawabanTable edomJawaban = $EdomJawabanTable(this);
  late final $DokumenArsipTable dokumenArsip = $DokumenArsipTable(this);
  late final $SavedFiltersTable savedFilters = $SavedFiltersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    prodi,
    dosens,
    mahasiswa,
    tahunAjaran,
    mataKuliah,
    prasyaratMk,
    kelas,
    krs,
    nilai,
    sesiPresensi,
    presensi,
    catatanBimbingan,
    peringatan,
    auditLog,
    syncLog,
    pengaturan,
    pengumuman,
    agendaAkademik,
    jadwalUjian,
    prestasi,
    edomPeriode,
    edomPertanyaan,
    edomPartisipasi,
    edomJawaban,
    dokumenArsip,
    savedFilters,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String role,
  required String pinHash,
  required String salt,
  Value<bool> biometricEnabled,
  Value<bool> isActive,
  Value<int> failedAttempts,
  Value<DateTime?> lockedUntil,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> role,
  Value<String> pinHash,
  Value<String> salt,
  Value<bool> biometricEnabled,
  Value<bool> isActive,
  Value<int> failedAttempts,
  Value<DateTime?> lockedUntil,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, UserRow> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DosensTable, List<DosenRow>> _dosensRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.dosens,
    aliasName: 'users__id__dosens__user_id',
  );

  $$DosensTableProcessedTableManager get dosensRefs {
    final manager = $$DosensTableTableManager(
      $_db,
      $_db.dosens,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dosensRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MahasiswaTable, List<MahasiswaRow>>
  _mahasiswaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mahasiswa,
    aliasName: 'users__id__mahasiswa__user_id',
  );

  $$MahasiswaTableProcessedTableManager get mahasiswaRefs {
    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mahasiswaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AuditLogTable, List<AuditLogRow>>
  _auditLogRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.auditLog,
    aliasName: 'users__id__audit_log__user_id',
  );

  $$AuditLogTableProcessedTableManager get auditLogRefs {
    final manager = $$AuditLogTableTableManager(
      $_db,
      $_db.auditLog,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_auditLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PengumumanTable, List<PengumumanRow>>
  _pengumumanRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pengumuman,
    aliasName: 'users__id__pengumuman__dibuat_oleh',
  );

  $$PengumumanTableProcessedTableManager get pengumumanRefs {
    final manager = $$PengumumanTableTableManager(
      $_db,
      $_db.pengumuman,
    ).filter((f) => f.dibuatOleh.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pengumumanRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DokumenArsipTable, List<DokumenArsipRow>>
  _dokumenArsipRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dokumenArsip,
    aliasName: 'users__id__dokumen_arsip__diunggah_oleh',
  );

  $$DokumenArsipTableProcessedTableManager get dokumenArsipRefs {
    final manager = $$DokumenArsipTableTableManager(
      $_db,
      $_db.dokumenArsip,
    ).filter((f) => f.diunggahOleh.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dokumenArsipRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SavedFiltersTable, List<SavedFilterRow>>
  _savedFiltersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.savedFilters,
    aliasName: 'users__id__saved_filters__user_id',
  );

  $$SavedFiltersTableProcessedTableManager get savedFiltersRefs {
    final manager = $$SavedFiltersTableTableManager(
      $_db,
      $_db.savedFilters,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_savedFiltersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedAttempts => $composableBuilder(
    column: $table.failedAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lockedUntil => $composableBuilder(
    column: $table.lockedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dosensRefs(
    Expression<bool> Function($$DosensTableFilterComposer f) f,
  ) {
    final $$DosensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableFilterComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mahasiswaRefs(
    Expression<bool> Function($$MahasiswaTableFilterComposer f) f,
  ) {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> auditLogRefs(
    Expression<bool> Function($$AuditLogTableFilterComposer f) f,
  ) {
    final $$AuditLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLog,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogTableFilterComposer(
            $db: $db,
            $table: $db.auditLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pengumumanRefs(
    Expression<bool> Function($$PengumumanTableFilterComposer f) f,
  ) {
    final $$PengumumanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pengumuman,
      getReferencedColumn: (t) => t.dibuatOleh,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PengumumanTableFilterComposer(
            $db: $db,
            $table: $db.pengumuman,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dokumenArsipRefs(
    Expression<bool> Function($$DokumenArsipTableFilterComposer f) f,
  ) {
    final $$DokumenArsipTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dokumenArsip,
      getReferencedColumn: (t) => t.diunggahOleh,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DokumenArsipTableFilterComposer(
            $db: $db,
            $table: $db.dokumenArsip,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> savedFiltersRefs(
    Expression<bool> Function($$SavedFiltersTableFilterComposer f) f,
  ) {
    final $$SavedFiltersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.savedFilters,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedFiltersTableFilterComposer(
            $db: $db,
            $table: $db.savedFilters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
    column: $table.failedAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lockedUntil => $composableBuilder(
    column: $table.lockedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
    column: $table.failedAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lockedUntil => $composableBuilder(
    column: $table.lockedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  Expression<T> dosensRefs<T extends Object>(
    Expression<T> Function($$DosensTableAnnotationComposer a) f,
  ) {
    final $$DosensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableAnnotationComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mahasiswaRefs<T extends Object>(
    Expression<T> Function($$MahasiswaTableAnnotationComposer a) f,
  ) {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> auditLogRefs<T extends Object>(
    Expression<T> Function($$AuditLogTableAnnotationComposer a) f,
  ) {
    final $$AuditLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLog,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogTableAnnotationComposer(
            $db: $db,
            $table: $db.auditLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pengumumanRefs<T extends Object>(
    Expression<T> Function($$PengumumanTableAnnotationComposer a) f,
  ) {
    final $$PengumumanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pengumuman,
      getReferencedColumn: (t) => t.dibuatOleh,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PengumumanTableAnnotationComposer(
            $db: $db,
            $table: $db.pengumuman,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dokumenArsipRefs<T extends Object>(
    Expression<T> Function($$DokumenArsipTableAnnotationComposer a) f,
  ) {
    final $$DokumenArsipTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dokumenArsip,
      getReferencedColumn: (t) => t.diunggahOleh,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DokumenArsipTableAnnotationComposer(
            $db: $db,
            $table: $db.dokumenArsip,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> savedFiltersRefs<T extends Object>(
    Expression<T> Function($$SavedFiltersTableAnnotationComposer a) f,
  ) {
    final $$SavedFiltersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.savedFilters,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedFiltersTableAnnotationComposer(
            $db: $db,
            $table: $db.savedFilters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, $$UsersTableReferences),
          UserRow,
          PrefetchHooks Function({
            bool dosensRefs,
            bool mahasiswaRefs,
            bool auditLogRefs,
            bool pengumumanRefs,
            bool dokumenArsipRefs,
            bool savedFiltersRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> pinHash = const Value.absent(),
                Value<String> salt = const Value.absent(),
                Value<bool> biometricEnabled = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> failedAttempts = const Value.absent(),
                Value<DateTime?> lockedUntil = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                role: role,
                pinHash: pinHash,
                salt: salt,
                biometricEnabled: biometricEnabled,
                isActive: isActive,
                failedAttempts: failedAttempts,
                lockedUntil: lockedUntil,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String role,
                required String pinHash,
                required String salt,
                Value<bool> biometricEnabled = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> failedAttempts = const Value.absent(),
                Value<DateTime?> lockedUntil = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                role: role,
                pinHash: pinHash,
                salt: salt,
                biometricEnabled: biometricEnabled,
                isActive: isActive,
                failedAttempts: failedAttempts,
                lockedUntil: lockedUntil,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, UserRow>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                dosensRefs = false,
                mahasiswaRefs = false,
                auditLogRefs = false,
                pengumumanRefs = false,
                dokumenArsipRefs = false,
                savedFiltersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dosensRefs) db.dosens,
                    if (mahasiswaRefs) db.mahasiswa,
                    if (auditLogRefs) db.auditLog,
                    if (pengumumanRefs) db.pengumuman,
                    if (dokumenArsipRefs) db.dokumenArsip,
                    if (savedFiltersRefs) db.savedFilters,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dosensRefs)
                        await $_getPrefetchedData<
                          UserRow,
                          $UsersTable,
                          DosenRow
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._dosensRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).dosensRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mahasiswaRefs)
                        await $_getPrefetchedData<
                          UserRow,
                          $UsersTable,
                          MahasiswaRow
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._mahasiswaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).mahasiswaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (auditLogRefs)
                        await $_getPrefetchedData<
                          UserRow,
                          $UsersTable,
                          AuditLogRow
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._auditLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).auditLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pengumumanRefs)
                        await $_getPrefetchedData<
                          UserRow,
                          $UsersTable,
                          PengumumanRow
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._pengumumanRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).pengumumanRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dibuatOleh == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dokumenArsipRefs)
                        await $_getPrefetchedData<
                          UserRow,
                          $UsersTable,
                          DokumenArsipRow
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._dokumenArsipRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).dokumenArsipRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.diunggahOleh == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (savedFiltersRefs)
                        await $_getPrefetchedData<
                          UserRow,
                          $UsersTable,
                          SavedFilterRow
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._savedFiltersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).savedFiltersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, $$UsersTableReferences),
      UserRow,
      PrefetchHooks Function({
        bool dosensRefs,
        bool mahasiswaRefs,
        bool auditLogRefs,
        bool pengumumanRefs,
        bool dokumenArsipRefs,
        bool savedFiltersRefs,
      })
    >;
typedef $$ProdiTableCreateCompanionBuilder = ProdiCompanion Function({
  Value<int> id,
  required String kode,
  required String nama,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$ProdiTableUpdateCompanionBuilder = ProdiCompanion Function({
  Value<int> id,
  Value<String> kode,
  Value<String> nama,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$ProdiTableReferences
    extends BaseReferences<_$AppDatabase, $ProdiTable, ProdiRow> {
  $$ProdiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DosensTable, List<DosenRow>> _dosensRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.dosens,
    aliasName: 'prodi__id__dosens__prodi_id',
  );

  $$DosensTableProcessedTableManager get dosensRefs {
    final manager = $$DosensTableTableManager(
      $_db,
      $_db.dosens,
    ).filter((f) => f.prodiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dosensRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MahasiswaTable, List<MahasiswaRow>>
  _mahasiswaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mahasiswa,
    aliasName: 'prodi__id__mahasiswa__prodi_id',
  );

  $$MahasiswaTableProcessedTableManager get mahasiswaRefs {
    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.prodiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mahasiswaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MataKuliahTable, List<MataKuliahRow>>
  _mataKuliahRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mataKuliah,
    aliasName: 'prodi__id__mata_kuliah__prodi_id',
  );

  $$MataKuliahTableProcessedTableManager get mataKuliahRefs {
    final manager = $$MataKuliahTableTableManager(
      $_db,
      $_db.mataKuliah,
    ).filter((f) => f.prodiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mataKuliahRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProdiTableFilterComposer extends Composer<_$AppDatabase, $ProdiTable> {
  $$ProdiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kode => $composableBuilder(
    column: $table.kode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dosensRefs(
    Expression<bool> Function($$DosensTableFilterComposer f) f,
  ) {
    final $$DosensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.prodiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableFilterComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mahasiswaRefs(
    Expression<bool> Function($$MahasiswaTableFilterComposer f) f,
  ) {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.prodiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mataKuliahRefs(
    Expression<bool> Function($$MataKuliahTableFilterComposer f) f,
  ) {
    final $$MataKuliahTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.prodiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableFilterComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProdiTableOrderingComposer
    extends Composer<_$AppDatabase, $ProdiTable> {
  $$ProdiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kode => $composableBuilder(
    column: $table.kode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProdiTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProdiTable> {
  $$ProdiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kode =>
      $composableBuilder(column: $table.kode, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  Expression<T> dosensRefs<T extends Object>(
    Expression<T> Function($$DosensTableAnnotationComposer a) f,
  ) {
    final $$DosensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.prodiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableAnnotationComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mahasiswaRefs<T extends Object>(
    Expression<T> Function($$MahasiswaTableAnnotationComposer a) f,
  ) {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.prodiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mataKuliahRefs<T extends Object>(
    Expression<T> Function($$MataKuliahTableAnnotationComposer a) f,
  ) {
    final $$MataKuliahTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.prodiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableAnnotationComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProdiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProdiTable,
          ProdiRow,
          $$ProdiTableFilterComposer,
          $$ProdiTableOrderingComposer,
          $$ProdiTableAnnotationComposer,
          $$ProdiTableCreateCompanionBuilder,
          $$ProdiTableUpdateCompanionBuilder,
          (ProdiRow, $$ProdiTableReferences),
          ProdiRow,
          PrefetchHooks Function({
            bool dosensRefs,
            bool mahasiswaRefs,
            bool mataKuliahRefs,
          })
        > {
  $$ProdiTableTableManager(_$AppDatabase db, $ProdiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProdiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProdiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProdiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kode = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => ProdiCompanion(
                id: id,
                kode: kode,
                nama: nama,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String kode,
                required String nama,
                required DateTime updatedAt,
                required String deviceId,
              }) => ProdiCompanion.insert(
                id: id,
                kode: kode,
                nama: nama,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProdiTable, ProdiRow>(table),
                  $$ProdiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                dosensRefs = false,
                mahasiswaRefs = false,
                mataKuliahRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dosensRefs) db.dosens,
                    if (mahasiswaRefs) db.mahasiswa,
                    if (mataKuliahRefs) db.mataKuliah,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dosensRefs)
                        await $_getPrefetchedData<
                          ProdiRow,
                          $ProdiTable,
                          DosenRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProdiTableReferences
                              ._dosensRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProdiTableReferences(db, table, p0).dosensRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.prodiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mahasiswaRefs)
                        await $_getPrefetchedData<
                          ProdiRow,
                          $ProdiTable,
                          MahasiswaRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProdiTableReferences
                              ._mahasiswaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProdiTableReferences(
                                db,
                                table,
                                p0,
                              ).mahasiswaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.prodiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mataKuliahRefs)
                        await $_getPrefetchedData<
                          ProdiRow,
                          $ProdiTable,
                          MataKuliahRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProdiTableReferences
                              ._mataKuliahRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProdiTableReferences(
                                db,
                                table,
                                p0,
                              ).mataKuliahRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.prodiId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProdiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProdiTable,
      ProdiRow,
      $$ProdiTableFilterComposer,
      $$ProdiTableOrderingComposer,
      $$ProdiTableAnnotationComposer,
      $$ProdiTableCreateCompanionBuilder,
      $$ProdiTableUpdateCompanionBuilder,
      (ProdiRow, $$ProdiTableReferences),
      ProdiRow,
      PrefetchHooks Function({
        bool dosensRefs,
        bool mahasiswaRefs,
        bool mataKuliahRefs,
      })
    >;
typedef $$DosensTableCreateCompanionBuilder = DosensCompanion Function({
  Value<int> id,
  required String nidn,
  required String nama,
  Value<int?> userId,
  required int prodiId,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$DosensTableUpdateCompanionBuilder = DosensCompanion Function({
  Value<int> id,
  Value<String> nidn,
  Value<String> nama,
  Value<int?> userId,
  Value<int> prodiId,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$DosensTableReferences
    extends BaseReferences<_$AppDatabase, $DosensTable, DosenRow> {
  $$DosensTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('dosens__user_id__users__id');

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProdiTable _prodiIdTable(_$AppDatabase db) =>
      db.prodi.createAlias('dosens__prodi_id__prodi__id');

  $$ProdiTableProcessedTableManager get prodiId {
    final $_column = $_itemColumn<int>('prodi_id')!;

    final manager = $$ProdiTableTableManager(
      $_db,
      $_db.prodi,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_prodiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MahasiswaTable, List<MahasiswaRow>>
  _mahasiswaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mahasiswa,
    aliasName: 'dosens__id__mahasiswa__dosen_wali_id',
  );

  $$MahasiswaTableProcessedTableManager get mahasiswaRefs {
    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.dosenWaliId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mahasiswaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KelasTable, List<KelasRow>> _kelasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.kelas,
    aliasName: 'dosens__id__kelas__dosen_id',
  );

  $$KelasTableProcessedTableManager get kelasRefs {
    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.dosenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kelasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CatatanBimbinganTable, List<CatatanBimbinganRow>>
  _catatanBimbinganRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.catatanBimbingan,
    aliasName: 'dosens__id__catatan_bimbingan__dosen_id',
  );

  $$CatatanBimbinganTableProcessedTableManager get catatanBimbinganRefs {
    final manager = $$CatatanBimbinganTableTableManager(
      $_db,
      $_db.catatanBimbingan,
    ).filter((f) => f.dosenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _catatanBimbinganRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EdomJawabanTable, List<EdomJawabanRow>>
  _edomJawabanRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomJawaban,
    aliasName: 'dosens__id__edom_jawaban__dosen_id',
  );

  $$EdomJawabanTableProcessedTableManager get edomJawabanRefs {
    final manager = $$EdomJawabanTableTableManager(
      $_db,
      $_db.edomJawaban,
    ).filter((f) => f.dosenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_edomJawabanRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DosensTableFilterComposer
    extends Composer<_$AppDatabase, $DosensTable> {
  $$DosensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nidn => $composableBuilder(
    column: $table.nidn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProdiTableFilterComposer get prodiId {
    final $$ProdiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableFilterComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mahasiswaRefs(
    Expression<bool> Function($$MahasiswaTableFilterComposer f) f,
  ) {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.dosenWaliId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kelasRefs(
    Expression<bool> Function($$KelasTableFilterComposer f) f,
  ) {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.dosenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> catatanBimbinganRefs(
    Expression<bool> Function($$CatatanBimbinganTableFilterComposer f) f,
  ) {
    final $$CatatanBimbinganTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.catatanBimbingan,
      getReferencedColumn: (t) => t.dosenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatatanBimbinganTableFilterComposer(
            $db: $db,
            $table: $db.catatanBimbingan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> edomJawabanRefs(
    Expression<bool> Function($$EdomJawabanTableFilterComposer f) f,
  ) {
    final $$EdomJawabanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.dosenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableFilterComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DosensTableOrderingComposer
    extends Composer<_$AppDatabase, $DosensTable> {
  $$DosensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nidn => $composableBuilder(
    column: $table.nidn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProdiTableOrderingComposer get prodiId {
    final $$ProdiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableOrderingComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DosensTableAnnotationComposer
    extends Composer<_$AppDatabase, $DosensTable> {
  $$DosensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nidn =>
      $composableBuilder(column: $table.nidn, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProdiTableAnnotationComposer get prodiId {
    final $$ProdiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableAnnotationComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> mahasiswaRefs<T extends Object>(
    Expression<T> Function($$MahasiswaTableAnnotationComposer a) f,
  ) {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.dosenWaliId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kelasRefs<T extends Object>(
    Expression<T> Function($$KelasTableAnnotationComposer a) f,
  ) {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.dosenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> catatanBimbinganRefs<T extends Object>(
    Expression<T> Function($$CatatanBimbinganTableAnnotationComposer a) f,
  ) {
    final $$CatatanBimbinganTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.catatanBimbingan,
      getReferencedColumn: (t) => t.dosenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatatanBimbinganTableAnnotationComposer(
            $db: $db,
            $table: $db.catatanBimbingan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> edomJawabanRefs<T extends Object>(
    Expression<T> Function($$EdomJawabanTableAnnotationComposer a) f,
  ) {
    final $$EdomJawabanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.dosenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableAnnotationComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DosensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DosensTable,
          DosenRow,
          $$DosensTableFilterComposer,
          $$DosensTableOrderingComposer,
          $$DosensTableAnnotationComposer,
          $$DosensTableCreateCompanionBuilder,
          $$DosensTableUpdateCompanionBuilder,
          (DosenRow, $$DosensTableReferences),
          DosenRow,
          PrefetchHooks Function({
            bool userId,
            bool prodiId,
            bool mahasiswaRefs,
            bool kelasRefs,
            bool catatanBimbinganRefs,
            bool edomJawabanRefs,
          })
        > {
  $$DosensTableTableManager(_$AppDatabase db, $DosensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DosensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DosensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DosensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nidn = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<int> prodiId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => DosensCompanion(
                id: id,
                nidn: nidn,
                nama: nama,
                userId: userId,
                prodiId: prodiId,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nidn,
                required String nama,
                Value<int?> userId = const Value.absent(),
                required int prodiId,
                required DateTime updatedAt,
                required String deviceId,
              }) => DosensCompanion.insert(
                id: id,
                nidn: nidn,
                nama: nama,
                userId: userId,
                prodiId: prodiId,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DosensTable, DosenRow>(table),
                  $$DosensTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                prodiId = false,
                mahasiswaRefs = false,
                kelasRefs = false,
                catatanBimbinganRefs = false,
                edomJawabanRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mahasiswaRefs) db.mahasiswa,
                    if (kelasRefs) db.kelas,
                    if (catatanBimbinganRefs) db.catatanBimbingan,
                    if (edomJawabanRefs) db.edomJawaban,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$DosensTableReferences
                                ._userIdTable(db),
                            referencedColumn: $$DosensTableReferences
                                ._userIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (prodiId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.prodiId,
                            referencedTable: $$DosensTableReferences
                                ._prodiIdTable(db),
                            referencedColumn: $$DosensTableReferences
                                ._prodiIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mahasiswaRefs)
                        await $_getPrefetchedData<
                          DosenRow,
                          $DosensTable,
                          MahasiswaRow
                        >(
                          currentTable: table,
                          referencedTable: $$DosensTableReferences
                              ._mahasiswaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DosensTableReferences(
                                db,
                                table,
                                p0,
                              ).mahasiswaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dosenWaliId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kelasRefs)
                        await $_getPrefetchedData<
                          DosenRow,
                          $DosensTable,
                          KelasRow
                        >(
                          currentTable: table,
                          referencedTable: $$DosensTableReferences
                              ._kelasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DosensTableReferences(db, table, p0).kelasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dosenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (catatanBimbinganRefs)
                        await $_getPrefetchedData<
                          DosenRow,
                          $DosensTable,
                          CatatanBimbinganRow
                        >(
                          currentTable: table,
                          referencedTable: $$DosensTableReferences
                              ._catatanBimbinganRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DosensTableReferences(
                                db,
                                table,
                                p0,
                              ).catatanBimbinganRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dosenId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (edomJawabanRefs)
                        await $_getPrefetchedData<
                          DosenRow,
                          $DosensTable,
                          EdomJawabanRow
                        >(
                          currentTable: table,
                          referencedTable: $$DosensTableReferences
                              ._edomJawabanRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DosensTableReferences(
                                db,
                                table,
                                p0,
                              ).edomJawabanRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dosenId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DosensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DosensTable,
      DosenRow,
      $$DosensTableFilterComposer,
      $$DosensTableOrderingComposer,
      $$DosensTableAnnotationComposer,
      $$DosensTableCreateCompanionBuilder,
      $$DosensTableUpdateCompanionBuilder,
      (DosenRow, $$DosensTableReferences),
      DosenRow,
      PrefetchHooks Function({
        bool userId,
        bool prodiId,
        bool mahasiswaRefs,
        bool kelasRefs,
        bool catatanBimbinganRefs,
        bool edomJawabanRefs,
      })
    >;
typedef $$MahasiswaTableCreateCompanionBuilder = MahasiswaCompanion Function({
  Value<int> id,
  required String nim,
  required String nama,
  required int prodiId,
  required int angkatan,
  Value<String> status,
  Value<String> email,
  Value<String> noHp,
  Value<String?> fotoPath,
  Value<int?> dosenWaliId,
  Value<int?> userId,
  Value<bool> isDeleted,
  required DateTime updatedAt,
  Value<String> deviceId,
});
typedef $$MahasiswaTableUpdateCompanionBuilder = MahasiswaCompanion Function({
  Value<int> id,
  Value<String> nim,
  Value<String> nama,
  Value<int> prodiId,
  Value<int> angkatan,
  Value<String> status,
  Value<String> email,
  Value<String> noHp,
  Value<String?> fotoPath,
  Value<int?> dosenWaliId,
  Value<int?> userId,
  Value<bool> isDeleted,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$MahasiswaTableReferences
    extends BaseReferences<_$AppDatabase, $MahasiswaTable, MahasiswaRow> {
  $$MahasiswaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProdiTable _prodiIdTable(_$AppDatabase db) =>
      db.prodi.createAlias('mahasiswa__prodi_id__prodi__id');

  $$ProdiTableProcessedTableManager get prodiId {
    final $_column = $_itemColumn<int>('prodi_id')!;

    final manager = $$ProdiTableTableManager(
      $_db,
      $_db.prodi,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_prodiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DosensTable _dosenWaliIdTable(_$AppDatabase db) =>
      db.dosens.createAlias('mahasiswa__dosen_wali_id__dosens__id');

  $$DosensTableProcessedTableManager? get dosenWaliId {
    final $_column = $_itemColumn<int>('dosen_wali_id');
    if ($_column == null) return null;
    final manager = $$DosensTableTableManager(
      $_db,
      $_db.dosens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dosenWaliIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('mahasiswa__user_id__users__id');

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$KrsTable, List<KrsRow>> _krsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.krs,
    aliasName: 'mahasiswa__id__krs__mahasiswa_id',
  );

  $$KrsTableProcessedTableManager get krsRefs {
    final manager = $$KrsTableTableManager(
      $_db,
      $_db.krs,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_krsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PresensiTable, List<PresensiRow>>
  _presensiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.presensi,
    aliasName: 'mahasiswa__id__presensi__mahasiswa_id',
  );

  $$PresensiTableProcessedTableManager get presensiRefs {
    final manager = $$PresensiTableTableManager(
      $_db,
      $_db.presensi,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_presensiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CatatanBimbinganTable, List<CatatanBimbinganRow>>
  _catatanBimbinganRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.catatanBimbingan,
    aliasName: 'mahasiswa__id__catatan_bimbingan__mahasiswa_id',
  );

  $$CatatanBimbinganTableProcessedTableManager get catatanBimbinganRefs {
    final manager = $$CatatanBimbinganTableTableManager(
      $_db,
      $_db.catatanBimbingan,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _catatanBimbinganRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PeringatanTable, List<PeringatanRow>>
  _peringatanRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.peringatan,
    aliasName: 'mahasiswa__id__peringatan__mahasiswa_id',
  );

  $$PeringatanTableProcessedTableManager get peringatanRefs {
    final manager = $$PeringatanTableTableManager(
      $_db,
      $_db.peringatan,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_peringatanRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PrestasiTable, List<PrestasiRow>>
  _prestasiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.prestasi,
    aliasName: 'mahasiswa__id__prestasi__mahasiswa_id',
  );

  $$PrestasiTableProcessedTableManager get prestasiRefs {
    final manager = $$PrestasiTableTableManager(
      $_db,
      $_db.prestasi,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_prestasiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EdomPartisipasiTable, List<EdomPartisipasiRow>>
  _edomPartisipasiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomPartisipasi,
    aliasName: 'mahasiswa__id__edom_partisipasi__mahasiswa_id',
  );

  $$EdomPartisipasiTableProcessedTableManager get edomPartisipasiRefs {
    final manager = $$EdomPartisipasiTableTableManager(
      $_db,
      $_db.edomPartisipasi,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _edomPartisipasiRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DokumenArsipTable, List<DokumenArsipRow>>
  _dokumenArsipRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dokumenArsip,
    aliasName: 'mahasiswa__id__dokumen_arsip__mahasiswa_id',
  );

  $$DokumenArsipTableProcessedTableManager get dokumenArsipRefs {
    final manager = $$DokumenArsipTableTableManager(
      $_db,
      $_db.dokumenArsip,
    ).filter((f) => f.mahasiswaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dokumenArsipRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MahasiswaTableFilterComposer
    extends Composer<_$AppDatabase, $MahasiswaTable> {
  $$MahasiswaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nim => $composableBuilder(
    column: $table.nim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get angkatan => $composableBuilder(
    column: $table.angkatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotoPath => $composableBuilder(
    column: $table.fotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$ProdiTableFilterComposer get prodiId {
    final $$ProdiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableFilterComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableFilterComposer get dosenWaliId {
    final $$DosensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenWaliId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableFilterComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> krsRefs(
    Expression<bool> Function($$KrsTableFilterComposer f) f,
  ) {
    final $$KrsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableFilterComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> presensiRefs(
    Expression<bool> Function($$PresensiTableFilterComposer f) f,
  ) {
    final $$PresensiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presensi,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresensiTableFilterComposer(
            $db: $db,
            $table: $db.presensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> catatanBimbinganRefs(
    Expression<bool> Function($$CatatanBimbinganTableFilterComposer f) f,
  ) {
    final $$CatatanBimbinganTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.catatanBimbingan,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatatanBimbinganTableFilterComposer(
            $db: $db,
            $table: $db.catatanBimbingan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> peringatanRefs(
    Expression<bool> Function($$PeringatanTableFilterComposer f) f,
  ) {
    final $$PeringatanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.peringatan,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeringatanTableFilterComposer(
            $db: $db,
            $table: $db.peringatan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> prestasiRefs(
    Expression<bool> Function($$PrestasiTableFilterComposer f) f,
  ) {
    final $$PrestasiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prestasi,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrestasiTableFilterComposer(
            $db: $db,
            $table: $db.prestasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> edomPartisipasiRefs(
    Expression<bool> Function($$EdomPartisipasiTableFilterComposer f) f,
  ) {
    final $$EdomPartisipasiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPartisipasi,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPartisipasiTableFilterComposer(
            $db: $db,
            $table: $db.edomPartisipasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dokumenArsipRefs(
    Expression<bool> Function($$DokumenArsipTableFilterComposer f) f,
  ) {
    final $$DokumenArsipTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dokumenArsip,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DokumenArsipTableFilterComposer(
            $db: $db,
            $table: $db.dokumenArsip,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MahasiswaTableOrderingComposer
    extends Composer<_$AppDatabase, $MahasiswaTable> {
  $$MahasiswaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nim => $composableBuilder(
    column: $table.nim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get angkatan => $composableBuilder(
    column: $table.angkatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotoPath => $composableBuilder(
    column: $table.fotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProdiTableOrderingComposer get prodiId {
    final $$ProdiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableOrderingComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableOrderingComposer get dosenWaliId {
    final $$DosensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenWaliId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableOrderingComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MahasiswaTableAnnotationComposer
    extends Composer<_$AppDatabase, $MahasiswaTable> {
  $$MahasiswaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nim =>
      $composableBuilder(column: $table.nim, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get angkatan =>
      $composableBuilder(column: $table.angkatan, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get noHp =>
      $composableBuilder(column: $table.noHp, builder: (column) => column);

  GeneratedColumn<String> get fotoPath =>
      $composableBuilder(column: $table.fotoPath, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$ProdiTableAnnotationComposer get prodiId {
    final $$ProdiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableAnnotationComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableAnnotationComposer get dosenWaliId {
    final $$DosensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenWaliId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableAnnotationComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> krsRefs<T extends Object>(
    Expression<T> Function($$KrsTableAnnotationComposer a) f,
  ) {
    final $$KrsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableAnnotationComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> presensiRefs<T extends Object>(
    Expression<T> Function($$PresensiTableAnnotationComposer a) f,
  ) {
    final $$PresensiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presensi,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresensiTableAnnotationComposer(
            $db: $db,
            $table: $db.presensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> catatanBimbinganRefs<T extends Object>(
    Expression<T> Function($$CatatanBimbinganTableAnnotationComposer a) f,
  ) {
    final $$CatatanBimbinganTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.catatanBimbingan,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatatanBimbinganTableAnnotationComposer(
            $db: $db,
            $table: $db.catatanBimbingan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> peringatanRefs<T extends Object>(
    Expression<T> Function($$PeringatanTableAnnotationComposer a) f,
  ) {
    final $$PeringatanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.peringatan,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeringatanTableAnnotationComposer(
            $db: $db,
            $table: $db.peringatan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> prestasiRefs<T extends Object>(
    Expression<T> Function($$PrestasiTableAnnotationComposer a) f,
  ) {
    final $$PrestasiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prestasi,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrestasiTableAnnotationComposer(
            $db: $db,
            $table: $db.prestasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> edomPartisipasiRefs<T extends Object>(
    Expression<T> Function($$EdomPartisipasiTableAnnotationComposer a) f,
  ) {
    final $$EdomPartisipasiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPartisipasi,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPartisipasiTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPartisipasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dokumenArsipRefs<T extends Object>(
    Expression<T> Function($$DokumenArsipTableAnnotationComposer a) f,
  ) {
    final $$DokumenArsipTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dokumenArsip,
      getReferencedColumn: (t) => t.mahasiswaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DokumenArsipTableAnnotationComposer(
            $db: $db,
            $table: $db.dokumenArsip,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MahasiswaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MahasiswaTable,
          MahasiswaRow,
          $$MahasiswaTableFilterComposer,
          $$MahasiswaTableOrderingComposer,
          $$MahasiswaTableAnnotationComposer,
          $$MahasiswaTableCreateCompanionBuilder,
          $$MahasiswaTableUpdateCompanionBuilder,
          (MahasiswaRow, $$MahasiswaTableReferences),
          MahasiswaRow,
          PrefetchHooks Function({
            bool prodiId,
            bool dosenWaliId,
            bool userId,
            bool krsRefs,
            bool presensiRefs,
            bool catatanBimbinganRefs,
            bool peringatanRefs,
            bool prestasiRefs,
            bool edomPartisipasiRefs,
            bool dokumenArsipRefs,
          })
        > {
  $$MahasiswaTableTableManager(_$AppDatabase db, $MahasiswaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MahasiswaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MahasiswaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MahasiswaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nim = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> prodiId = const Value.absent(),
                Value<int> angkatan = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> noHp = const Value.absent(),
                Value<String?> fotoPath = const Value.absent(),
                Value<int?> dosenWaliId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => MahasiswaCompanion(
                id: id,
                nim: nim,
                nama: nama,
                prodiId: prodiId,
                angkatan: angkatan,
                status: status,
                email: email,
                noHp: noHp,
                fotoPath: fotoPath,
                dosenWaliId: dosenWaliId,
                userId: userId,
                isDeleted: isDeleted,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nim,
                required String nama,
                required int prodiId,
                required int angkatan,
                Value<String> status = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> noHp = const Value.absent(),
                Value<String?> fotoPath = const Value.absent(),
                Value<int?> dosenWaliId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                required DateTime updatedAt,
                Value<String> deviceId = const Value.absent(),
              }) => MahasiswaCompanion.insert(
                id: id,
                nim: nim,
                nama: nama,
                prodiId: prodiId,
                angkatan: angkatan,
                status: status,
                email: email,
                noHp: noHp,
                fotoPath: fotoPath,
                dosenWaliId: dosenWaliId,
                userId: userId,
                isDeleted: isDeleted,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MahasiswaTable, MahasiswaRow>(table),
                  $$MahasiswaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                prodiId = false,
                dosenWaliId = false,
                userId = false,
                krsRefs = false,
                presensiRefs = false,
                catatanBimbinganRefs = false,
                peringatanRefs = false,
                prestasiRefs = false,
                edomPartisipasiRefs = false,
                dokumenArsipRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (krsRefs) db.krs,
                    if (presensiRefs) db.presensi,
                    if (catatanBimbinganRefs) db.catatanBimbingan,
                    if (peringatanRefs) db.peringatan,
                    if (prestasiRefs) db.prestasi,
                    if (edomPartisipasiRefs) db.edomPartisipasi,
                    if (dokumenArsipRefs) db.dokumenArsip,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (prodiId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.prodiId,
                            referencedTable: $$MahasiswaTableReferences
                                ._prodiIdTable(db),
                            referencedColumn: $$MahasiswaTableReferences
                                ._prodiIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (dosenWaliId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.dosenWaliId,
                            referencedTable: $$MahasiswaTableReferences
                                ._dosenWaliIdTable(db),
                            referencedColumn: $$MahasiswaTableReferences
                                ._dosenWaliIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (userId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$MahasiswaTableReferences
                                ._userIdTable(db),
                            referencedColumn: $$MahasiswaTableReferences
                                ._userIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (krsRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          KrsRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._krsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(db, table, p0).krsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (presensiRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          PresensiRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._presensiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(
                                db,
                                table,
                                p0,
                              ).presensiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (catatanBimbinganRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          CatatanBimbinganRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._catatanBimbinganRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(
                                db,
                                table,
                                p0,
                              ).catatanBimbinganRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (peringatanRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          PeringatanRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._peringatanRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(
                                db,
                                table,
                                p0,
                              ).peringatanRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (prestasiRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          PrestasiRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._prestasiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(
                                db,
                                table,
                                p0,
                              ).prestasiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (edomPartisipasiRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          EdomPartisipasiRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._edomPartisipasiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(
                                db,
                                table,
                                p0,
                              ).edomPartisipasiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dokumenArsipRefs)
                        await $_getPrefetchedData<
                          MahasiswaRow,
                          $MahasiswaTable,
                          DokumenArsipRow
                        >(
                          currentTable: table,
                          referencedTable: $$MahasiswaTableReferences
                              ._dokumenArsipRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MahasiswaTableReferences(
                                db,
                                table,
                                p0,
                              ).dokumenArsipRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mahasiswaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MahasiswaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MahasiswaTable,
      MahasiswaRow,
      $$MahasiswaTableFilterComposer,
      $$MahasiswaTableOrderingComposer,
      $$MahasiswaTableAnnotationComposer,
      $$MahasiswaTableCreateCompanionBuilder,
      $$MahasiswaTableUpdateCompanionBuilder,
      (MahasiswaRow, $$MahasiswaTableReferences),
      MahasiswaRow,
      PrefetchHooks Function({
        bool prodiId,
        bool dosenWaliId,
        bool userId,
        bool krsRefs,
        bool presensiRefs,
        bool catatanBimbinganRefs,
        bool peringatanRefs,
        bool prestasiRefs,
        bool edomPartisipasiRefs,
        bool dokumenArsipRefs,
      })
    >;
typedef $$TahunAjaranTableCreateCompanionBuilder =
    TahunAjaranCompanion Function({
      Value<int> id,
      required String tahun,
      required int semester,
      Value<bool> isActive,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$TahunAjaranTableUpdateCompanionBuilder =
    TahunAjaranCompanion Function({
      Value<int> id,
      Value<String> tahun,
      Value<int> semester,
      Value<bool> isActive,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$TahunAjaranTableReferences
    extends BaseReferences<_$AppDatabase, $TahunAjaranTable, TahunAjaranRow> {
  $$TahunAjaranTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KelasTable, List<KelasRow>> _kelasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.kelas,
    aliasName: 'tahun_ajaran__id__kelas__ta_id',
  );

  $$KelasTableProcessedTableManager get kelasRefs {
    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.taId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kelasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KrsTable, List<KrsRow>> _krsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.krs,
    aliasName: 'tahun_ajaran__id__krs__ta_id',
  );

  $$KrsTableProcessedTableManager get krsRefs {
    final manager = $$KrsTableTableManager(
      $_db,
      $_db.krs,
    ).filter((f) => f.taId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_krsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EdomPeriodeTable, List<EdomPeriodeRow>>
  _edomPeriodeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomPeriode,
    aliasName: 'tahun_ajaran__id__edom_periode__ta_id',
  );

  $$EdomPeriodeTableProcessedTableManager get edomPeriodeRefs {
    final manager = $$EdomPeriodeTableTableManager(
      $_db,
      $_db.edomPeriode,
    ).filter((f) => f.taId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_edomPeriodeRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TahunAjaranTableFilterComposer
    extends Composer<_$AppDatabase, $TahunAjaranTable> {
  $$TahunAjaranTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semester => $composableBuilder(
    column: $table.semester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> kelasRefs(
    Expression<bool> Function($$KelasTableFilterComposer f) f,
  ) {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.taId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> krsRefs(
    Expression<bool> Function($$KrsTableFilterComposer f) f,
  ) {
    final $$KrsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.taId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableFilterComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> edomPeriodeRefs(
    Expression<bool> Function($$EdomPeriodeTableFilterComposer f) f,
  ) {
    final $$EdomPeriodeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.taId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableFilterComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TahunAjaranTableOrderingComposer
    extends Composer<_$AppDatabase, $TahunAjaranTable> {
  $$TahunAjaranTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semester => $composableBuilder(
    column: $table.semester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TahunAjaranTableAnnotationComposer
    extends Composer<_$AppDatabase, $TahunAjaranTable> {
  $$TahunAjaranTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get semester =>
      $composableBuilder(column: $table.semester, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  Expression<T> kelasRefs<T extends Object>(
    Expression<T> Function($$KelasTableAnnotationComposer a) f,
  ) {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.taId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> krsRefs<T extends Object>(
    Expression<T> Function($$KrsTableAnnotationComposer a) f,
  ) {
    final $$KrsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.taId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableAnnotationComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> edomPeriodeRefs<T extends Object>(
    Expression<T> Function($$EdomPeriodeTableAnnotationComposer a) f,
  ) {
    final $$EdomPeriodeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.taId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TahunAjaranTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TahunAjaranTable,
          TahunAjaranRow,
          $$TahunAjaranTableFilterComposer,
          $$TahunAjaranTableOrderingComposer,
          $$TahunAjaranTableAnnotationComposer,
          $$TahunAjaranTableCreateCompanionBuilder,
          $$TahunAjaranTableUpdateCompanionBuilder,
          (TahunAjaranRow, $$TahunAjaranTableReferences),
          TahunAjaranRow,
          PrefetchHooks Function({
            bool kelasRefs,
            bool krsRefs,
            bool edomPeriodeRefs,
          })
        > {
  $$TahunAjaranTableTableManager(_$AppDatabase db, $TahunAjaranTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TahunAjaranTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TahunAjaranTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TahunAjaranTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tahun = const Value.absent(),
                Value<int> semester = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => TahunAjaranCompanion(
                id: id,
                tahun: tahun,
                semester: semester,
                isActive: isActive,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tahun,
                required int semester,
                Value<bool> isActive = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => TahunAjaranCompanion.insert(
                id: id,
                tahun: tahun,
                semester: semester,
                isActive: isActive,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TahunAjaranTable, TahunAjaranRow>(table),
                  $$TahunAjaranTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({kelasRefs = false, krsRefs = false, edomPeriodeRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (kelasRefs) db.kelas,
                    if (krsRefs) db.krs,
                    if (edomPeriodeRefs) db.edomPeriode,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (kelasRefs)
                        await $_getPrefetchedData<
                          TahunAjaranRow,
                          $TahunAjaranTable,
                          KelasRow
                        >(
                          currentTable: table,
                          referencedTable: $$TahunAjaranTableReferences
                              ._kelasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TahunAjaranTableReferences(
                                db,
                                table,
                                p0,
                              ).kelasRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.taId == item.id),
                          typedResults: items,
                        ),
                      if (krsRefs)
                        await $_getPrefetchedData<
                          TahunAjaranRow,
                          $TahunAjaranTable,
                          KrsRow
                        >(
                          currentTable: table,
                          referencedTable: $$TahunAjaranTableReferences
                              ._krsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TahunAjaranTableReferences(
                                db,
                                table,
                                p0,
                              ).krsRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.taId == item.id),
                          typedResults: items,
                        ),
                      if (edomPeriodeRefs)
                        await $_getPrefetchedData<
                          TahunAjaranRow,
                          $TahunAjaranTable,
                          EdomPeriodeRow
                        >(
                          currentTable: table,
                          referencedTable: $$TahunAjaranTableReferences
                              ._edomPeriodeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TahunAjaranTableReferences(
                                db,
                                table,
                                p0,
                              ).edomPeriodeRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.taId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TahunAjaranTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TahunAjaranTable,
      TahunAjaranRow,
      $$TahunAjaranTableFilterComposer,
      $$TahunAjaranTableOrderingComposer,
      $$TahunAjaranTableAnnotationComposer,
      $$TahunAjaranTableCreateCompanionBuilder,
      $$TahunAjaranTableUpdateCompanionBuilder,
      (TahunAjaranRow, $$TahunAjaranTableReferences),
      TahunAjaranRow,
      PrefetchHooks Function({
        bool kelasRefs,
        bool krsRefs,
        bool edomPeriodeRefs,
      })
    >;
typedef $$MataKuliahTableCreateCompanionBuilder = MataKuliahCompanion Function({
  Value<int> id,
  required String kode,
  required String nama,
  required int sks,
  required int semester,
  required int prodiId,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$MataKuliahTableUpdateCompanionBuilder = MataKuliahCompanion Function({
  Value<int> id,
  Value<String> kode,
  Value<String> nama,
  Value<int> sks,
  Value<int> semester,
  Value<int> prodiId,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$MataKuliahTableReferences
    extends BaseReferences<_$AppDatabase, $MataKuliahTable, MataKuliahRow> {
  $$MataKuliahTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProdiTable _prodiIdTable(_$AppDatabase db) =>
      db.prodi.createAlias('mata_kuliah__prodi_id__prodi__id');

  $$ProdiTableProcessedTableManager get prodiId {
    final $_column = $_itemColumn<int>('prodi_id')!;

    final manager = $$ProdiTableTableManager(
      $_db,
      $_db.prodi,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_prodiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PrasyaratMkTable, List<PrasyaratMkRow>>
  _mk_prasyaratTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.prasyaratMk,
    aliasName: 'mata_kuliah__id__prasyarat_mk__mk_id',
  );

  $$PrasyaratMkTableProcessedTableManager get mk_prasyarat {
    final manager = $$PrasyaratMkTableTableManager(
      $_db,
      $_db.prasyaratMk,
    ).filter((f) => f.mkId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mk_prasyaratTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PrasyaratMkTable, List<PrasyaratMkRow>>
  _prasyarat_for_mkTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.prasyaratMk,
    aliasName: 'mata_kuliah__id__prasyarat_mk__prasyarat_mk_id',
  );

  $$PrasyaratMkTableProcessedTableManager get prasyarat_for_mk {
    final manager = $$PrasyaratMkTableTableManager(
      $_db,
      $_db.prasyaratMk,
    ).filter((f) => f.prasyaratMkId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_prasyarat_for_mkTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KelasTable, List<KelasRow>> _kelasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.kelas,
    aliasName: 'mata_kuliah__id__kelas__mk_id',
  );

  $$KelasTableProcessedTableManager get kelasRefs {
    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.mkId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kelasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MataKuliahTableFilterComposer
    extends Composer<_$AppDatabase, $MataKuliahTable> {
  $$MataKuliahTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kode => $composableBuilder(
    column: $table.kode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sks => $composableBuilder(
    column: $table.sks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semester => $composableBuilder(
    column: $table.semester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$ProdiTableFilterComposer get prodiId {
    final $$ProdiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableFilterComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mk_prasyarat(
    Expression<bool> Function($$PrasyaratMkTableFilterComposer f) f,
  ) {
    final $$PrasyaratMkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prasyaratMk,
      getReferencedColumn: (t) => t.mkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrasyaratMkTableFilterComposer(
            $db: $db,
            $table: $db.prasyaratMk,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> prasyarat_for_mk(
    Expression<bool> Function($$PrasyaratMkTableFilterComposer f) f,
  ) {
    final $$PrasyaratMkTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prasyaratMk,
      getReferencedColumn: (t) => t.prasyaratMkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrasyaratMkTableFilterComposer(
            $db: $db,
            $table: $db.prasyaratMk,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kelasRefs(
    Expression<bool> Function($$KelasTableFilterComposer f) f,
  ) {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.mkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MataKuliahTableOrderingComposer
    extends Composer<_$AppDatabase, $MataKuliahTable> {
  $$MataKuliahTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kode => $composableBuilder(
    column: $table.kode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sks => $composableBuilder(
    column: $table.sks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semester => $composableBuilder(
    column: $table.semester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProdiTableOrderingComposer get prodiId {
    final $$ProdiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableOrderingComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MataKuliahTableAnnotationComposer
    extends Composer<_$AppDatabase, $MataKuliahTable> {
  $$MataKuliahTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kode =>
      $composableBuilder(column: $table.kode, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get sks =>
      $composableBuilder(column: $table.sks, builder: (column) => column);

  GeneratedColumn<int> get semester =>
      $composableBuilder(column: $table.semester, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$ProdiTableAnnotationComposer get prodiId {
    final $$ProdiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prodiId,
      referencedTable: $db.prodi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProdiTableAnnotationComposer(
            $db: $db,
            $table: $db.prodi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> mk_prasyarat<T extends Object>(
    Expression<T> Function($$PrasyaratMkTableAnnotationComposer a) f,
  ) {
    final $$PrasyaratMkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prasyaratMk,
      getReferencedColumn: (t) => t.mkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrasyaratMkTableAnnotationComposer(
            $db: $db,
            $table: $db.prasyaratMk,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> prasyarat_for_mk<T extends Object>(
    Expression<T> Function($$PrasyaratMkTableAnnotationComposer a) f,
  ) {
    final $$PrasyaratMkTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.prasyaratMk,
      getReferencedColumn: (t) => t.prasyaratMkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrasyaratMkTableAnnotationComposer(
            $db: $db,
            $table: $db.prasyaratMk,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kelasRefs<T extends Object>(
    Expression<T> Function($$KelasTableAnnotationComposer a) f,
  ) {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.mkId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MataKuliahTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MataKuliahTable,
          MataKuliahRow,
          $$MataKuliahTableFilterComposer,
          $$MataKuliahTableOrderingComposer,
          $$MataKuliahTableAnnotationComposer,
          $$MataKuliahTableCreateCompanionBuilder,
          $$MataKuliahTableUpdateCompanionBuilder,
          (MataKuliahRow, $$MataKuliahTableReferences),
          MataKuliahRow,
          PrefetchHooks Function({
            bool prodiId,
            bool mk_prasyarat,
            bool prasyarat_for_mk,
            bool kelasRefs,
          })
        > {
  $$MataKuliahTableTableManager(_$AppDatabase db, $MataKuliahTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MataKuliahTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MataKuliahTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MataKuliahTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kode = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> sks = const Value.absent(),
                Value<int> semester = const Value.absent(),
                Value<int> prodiId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => MataKuliahCompanion(
                id: id,
                kode: kode,
                nama: nama,
                sks: sks,
                semester: semester,
                prodiId: prodiId,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String kode,
                required String nama,
                required int sks,
                required int semester,
                required int prodiId,
                required DateTime updatedAt,
                required String deviceId,
              }) => MataKuliahCompanion.insert(
                id: id,
                kode: kode,
                nama: nama,
                sks: sks,
                semester: semester,
                prodiId: prodiId,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MataKuliahTable, MataKuliahRow>(table),
                  $$MataKuliahTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                prodiId = false,
                mk_prasyarat = false,
                prasyarat_for_mk = false,
                kelasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mk_prasyarat) db.prasyaratMk,
                    if (prasyarat_for_mk) db.prasyaratMk,
                    if (kelasRefs) db.kelas,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (prodiId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.prodiId,
                            referencedTable: $$MataKuliahTableReferences
                                ._prodiIdTable(db),
                            referencedColumn: $$MataKuliahTableReferences
                                ._prodiIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mk_prasyarat)
                        await $_getPrefetchedData<
                          MataKuliahRow,
                          $MataKuliahTable,
                          PrasyaratMkRow
                        >(
                          currentTable: table,
                          referencedTable: $$MataKuliahTableReferences
                              ._mk_prasyaratTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MataKuliahTableReferences(
                                db,
                                table,
                                p0,
                              ).mk_prasyarat,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.mkId == item.id),
                          typedResults: items,
                        ),
                      if (prasyarat_for_mk)
                        await $_getPrefetchedData<
                          MataKuliahRow,
                          $MataKuliahTable,
                          PrasyaratMkRow
                        >(
                          currentTable: table,
                          referencedTable: $$MataKuliahTableReferences
                              ._prasyarat_for_mkTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MataKuliahTableReferences(
                                db,
                                table,
                                p0,
                              ).prasyarat_for_mk,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.prasyaratMkId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kelasRefs)
                        await $_getPrefetchedData<
                          MataKuliahRow,
                          $MataKuliahTable,
                          KelasRow
                        >(
                          currentTable: table,
                          referencedTable: $$MataKuliahTableReferences
                              ._kelasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MataKuliahTableReferences(
                                db,
                                table,
                                p0,
                              ).kelasRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.mkId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MataKuliahTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MataKuliahTable,
      MataKuliahRow,
      $$MataKuliahTableFilterComposer,
      $$MataKuliahTableOrderingComposer,
      $$MataKuliahTableAnnotationComposer,
      $$MataKuliahTableCreateCompanionBuilder,
      $$MataKuliahTableUpdateCompanionBuilder,
      (MataKuliahRow, $$MataKuliahTableReferences),
      MataKuliahRow,
      PrefetchHooks Function({
        bool prodiId,
        bool mk_prasyarat,
        bool prasyarat_for_mk,
        bool kelasRefs,
      })
    >;
typedef $$PrasyaratMkTableCreateCompanionBuilder =
    PrasyaratMkCompanion Function({
      required int mkId,
      required int prasyaratMkId,
      required DateTime updatedAt,
      required String deviceId,
      Value<int> rowid,
    });
typedef $$PrasyaratMkTableUpdateCompanionBuilder =
    PrasyaratMkCompanion Function({
      Value<int> mkId,
      Value<int> prasyaratMkId,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
      Value<int> rowid,
    });

final class $$PrasyaratMkTableReferences
    extends BaseReferences<_$AppDatabase, $PrasyaratMkTable, PrasyaratMkRow> {
  $$PrasyaratMkTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MataKuliahTable _mkIdTable(_$AppDatabase db) =>
      db.mataKuliah.createAlias('prasyarat_mk__mk_id__mata_kuliah__id');

  $$MataKuliahTableProcessedTableManager get mkId {
    final $_column = $_itemColumn<int>('mk_id')!;

    final manager = $$MataKuliahTableTableManager(
      $_db,
      $_db.mataKuliah,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MataKuliahTable _prasyaratMkIdTable(_$AppDatabase db) => db.mataKuliah
      .createAlias('prasyarat_mk__prasyarat_mk_id__mata_kuliah__id');

  $$MataKuliahTableProcessedTableManager get prasyaratMkId {
    final $_column = $_itemColumn<int>('prasyarat_mk_id')!;

    final manager = $$MataKuliahTableTableManager(
      $_db,
      $_db.mataKuliah,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_prasyaratMkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrasyaratMkTableFilterComposer
    extends Composer<_$AppDatabase, $PrasyaratMkTable> {
  $$PrasyaratMkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MataKuliahTableFilterComposer get mkId {
    final $$MataKuliahTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableFilterComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MataKuliahTableFilterComposer get prasyaratMkId {
    final $$MataKuliahTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prasyaratMkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableFilterComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrasyaratMkTableOrderingComposer
    extends Composer<_$AppDatabase, $PrasyaratMkTable> {
  $$PrasyaratMkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MataKuliahTableOrderingComposer get mkId {
    final $$MataKuliahTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableOrderingComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MataKuliahTableOrderingComposer get prasyaratMkId {
    final $$MataKuliahTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prasyaratMkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableOrderingComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrasyaratMkTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrasyaratMkTable> {
  $$PrasyaratMkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MataKuliahTableAnnotationComposer get mkId {
    final $$MataKuliahTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableAnnotationComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MataKuliahTableAnnotationComposer get prasyaratMkId {
    final $$MataKuliahTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.prasyaratMkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableAnnotationComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrasyaratMkTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrasyaratMkTable,
          PrasyaratMkRow,
          $$PrasyaratMkTableFilterComposer,
          $$PrasyaratMkTableOrderingComposer,
          $$PrasyaratMkTableAnnotationComposer,
          $$PrasyaratMkTableCreateCompanionBuilder,
          $$PrasyaratMkTableUpdateCompanionBuilder,
          (PrasyaratMkRow, $$PrasyaratMkTableReferences),
          PrasyaratMkRow,
          PrefetchHooks Function({bool mkId, bool prasyaratMkId})
        > {
  $$PrasyaratMkTableTableManager(_$AppDatabase db, $PrasyaratMkTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrasyaratMkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrasyaratMkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrasyaratMkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> mkId = const Value.absent(),
                Value<int> prasyaratMkId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrasyaratMkCompanion(
                mkId: mkId,
                prasyaratMkId: prasyaratMkId,
                updatedAt: updatedAt,
                deviceId: deviceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int mkId,
                required int prasyaratMkId,
                required DateTime updatedAt,
                required String deviceId,
                Value<int> rowid = const Value.absent(),
              }) => PrasyaratMkCompanion.insert(
                mkId: mkId,
                prasyaratMkId: prasyaratMkId,
                updatedAt: updatedAt,
                deviceId: deviceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrasyaratMkTable, PrasyaratMkRow>(table),
                  $$PrasyaratMkTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mkId = false, prasyaratMkId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mkId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mkId,
                        referencedTable: $$PrasyaratMkTableReferences
                            ._mkIdTable(db),
                        referencedColumn: $$PrasyaratMkTableReferences
                            ._mkIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (prasyaratMkId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.prasyaratMkId,
                        referencedTable: $$PrasyaratMkTableReferences
                            ._prasyaratMkIdTable(db),
                        referencedColumn: $$PrasyaratMkTableReferences
                            ._prasyaratMkIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrasyaratMkTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrasyaratMkTable,
      PrasyaratMkRow,
      $$PrasyaratMkTableFilterComposer,
      $$PrasyaratMkTableOrderingComposer,
      $$PrasyaratMkTableAnnotationComposer,
      $$PrasyaratMkTableCreateCompanionBuilder,
      $$PrasyaratMkTableUpdateCompanionBuilder,
      (PrasyaratMkRow, $$PrasyaratMkTableReferences),
      PrasyaratMkRow,
      PrefetchHooks Function({bool mkId, bool prasyaratMkId})
    >;
typedef $$KelasTableCreateCompanionBuilder = KelasCompanion Function({
  Value<int> id,
  required int mkId,
  required int dosenId,
  required int taId,
  required String hari,
  required String jamMulai,
  required String jamSelesai,
  Value<String> ruang,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$KelasTableUpdateCompanionBuilder = KelasCompanion Function({
  Value<int> id,
  Value<int> mkId,
  Value<int> dosenId,
  Value<int> taId,
  Value<String> hari,
  Value<String> jamMulai,
  Value<String> jamSelesai,
  Value<String> ruang,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$KelasTableReferences
    extends BaseReferences<_$AppDatabase, $KelasTable, KelasRow> {
  $$KelasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MataKuliahTable _mkIdTable(_$AppDatabase db) =>
      db.mataKuliah.createAlias('kelas__mk_id__mata_kuliah__id');

  $$MataKuliahTableProcessedTableManager get mkId {
    final $_column = $_itemColumn<int>('mk_id')!;

    final manager = $$MataKuliahTableTableManager(
      $_db,
      $_db.mataKuliah,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mkIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DosensTable _dosenIdTable(_$AppDatabase db) =>
      db.dosens.createAlias('kelas__dosen_id__dosens__id');

  $$DosensTableProcessedTableManager get dosenId {
    final $_column = $_itemColumn<int>('dosen_id')!;

    final manager = $$DosensTableTableManager(
      $_db,
      $_db.dosens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dosenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TahunAjaranTable _taIdTable(_$AppDatabase db) =>
      db.tahunAjaran.createAlias('kelas__ta_id__tahun_ajaran__id');

  $$TahunAjaranTableProcessedTableManager get taId {
    final $_column = $_itemColumn<int>('ta_id')!;

    final manager = $$TahunAjaranTableTableManager(
      $_db,
      $_db.tahunAjaran,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$KrsTable, List<KrsRow>> _krsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.krs,
    aliasName: 'kelas__id__krs__kelas_id',
  );

  $$KrsTableProcessedTableManager get krsRefs {
    final manager = $$KrsTableTableManager(
      $_db,
      $_db.krs,
    ).filter((f) => f.kelasId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_krsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SesiPresensiTable, List<SesiPresensiRow>>
  _sesiPresensiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sesiPresensi,
    aliasName: 'kelas__id__sesi_presensi__kelas_id',
  );

  $$SesiPresensiTableProcessedTableManager get sesiPresensiRefs {
    final manager = $$SesiPresensiTableTableManager(
      $_db,
      $_db.sesiPresensi,
    ).filter((f) => f.kelasId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sesiPresensiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JadwalUjianTable, List<JadwalUjianRow>>
  _jadwalUjianRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jadwalUjian,
    aliasName: 'kelas__id__jadwal_ujian__kelas_id',
  );

  $$JadwalUjianTableProcessedTableManager get jadwalUjianRefs {
    final manager = $$JadwalUjianTableTableManager(
      $_db,
      $_db.jadwalUjian,
    ).filter((f) => f.kelasId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_jadwalUjianRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EdomPartisipasiTable, List<EdomPartisipasiRow>>
  _edomPartisipasiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomPartisipasi,
    aliasName: 'kelas__id__edom_partisipasi__kelas_id',
  );

  $$EdomPartisipasiTableProcessedTableManager get edomPartisipasiRefs {
    final manager = $$EdomPartisipasiTableTableManager(
      $_db,
      $_db.edomPartisipasi,
    ).filter((f) => f.kelasId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _edomPartisipasiRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EdomJawabanTable, List<EdomJawabanRow>>
  _edomJawabanRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomJawaban,
    aliasName: 'kelas__id__edom_jawaban__kelas_id',
  );

  $$EdomJawabanTableProcessedTableManager get edomJawabanRefs {
    final manager = $$EdomJawabanTableTableManager(
      $_db,
      $_db.edomJawaban,
    ).filter((f) => f.kelasId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_edomJawabanRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KelasTableFilterComposer extends Composer<_$AppDatabase, $KelasTable> {
  $$KelasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hari => $composableBuilder(
    column: $table.hari,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jamMulai => $composableBuilder(
    column: $table.jamMulai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jamSelesai => $composableBuilder(
    column: $table.jamSelesai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruang => $composableBuilder(
    column: $table.ruang,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MataKuliahTableFilterComposer get mkId {
    final $$MataKuliahTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableFilterComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableFilterComposer get dosenId {
    final $$DosensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableFilterComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TahunAjaranTableFilterComposer get taId {
    final $$TahunAjaranTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableFilterComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> krsRefs(
    Expression<bool> Function($$KrsTableFilterComposer f) f,
  ) {
    final $$KrsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableFilterComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sesiPresensiRefs(
    Expression<bool> Function($$SesiPresensiTableFilterComposer f) f,
  ) {
    final $$SesiPresensiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sesiPresensi,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesiPresensiTableFilterComposer(
            $db: $db,
            $table: $db.sesiPresensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jadwalUjianRefs(
    Expression<bool> Function($$JadwalUjianTableFilterComposer f) f,
  ) {
    final $$JadwalUjianTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jadwalUjian,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JadwalUjianTableFilterComposer(
            $db: $db,
            $table: $db.jadwalUjian,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> edomPartisipasiRefs(
    Expression<bool> Function($$EdomPartisipasiTableFilterComposer f) f,
  ) {
    final $$EdomPartisipasiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPartisipasi,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPartisipasiTableFilterComposer(
            $db: $db,
            $table: $db.edomPartisipasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> edomJawabanRefs(
    Expression<bool> Function($$EdomJawabanTableFilterComposer f) f,
  ) {
    final $$EdomJawabanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableFilterComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KelasTableOrderingComposer
    extends Composer<_$AppDatabase, $KelasTable> {
  $$KelasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hari => $composableBuilder(
    column: $table.hari,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jamMulai => $composableBuilder(
    column: $table.jamMulai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jamSelesai => $composableBuilder(
    column: $table.jamSelesai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruang => $composableBuilder(
    column: $table.ruang,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MataKuliahTableOrderingComposer get mkId {
    final $$MataKuliahTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableOrderingComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableOrderingComposer get dosenId {
    final $$DosensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableOrderingComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TahunAjaranTableOrderingComposer get taId {
    final $$TahunAjaranTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableOrderingComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KelasTableAnnotationComposer
    extends Composer<_$AppDatabase, $KelasTable> {
  $$KelasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hari =>
      $composableBuilder(column: $table.hari, builder: (column) => column);

  GeneratedColumn<String> get jamMulai =>
      $composableBuilder(column: $table.jamMulai, builder: (column) => column);

  GeneratedColumn<String> get jamSelesai => $composableBuilder(
    column: $table.jamSelesai,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruang =>
      $composableBuilder(column: $table.ruang, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MataKuliahTableAnnotationComposer get mkId {
    final $$MataKuliahTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mkId,
      referencedTable: $db.mataKuliah,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MataKuliahTableAnnotationComposer(
            $db: $db,
            $table: $db.mataKuliah,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableAnnotationComposer get dosenId {
    final $$DosensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableAnnotationComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TahunAjaranTableAnnotationComposer get taId {
    final $$TahunAjaranTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableAnnotationComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> krsRefs<T extends Object>(
    Expression<T> Function($$KrsTableAnnotationComposer a) f,
  ) {
    final $$KrsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableAnnotationComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sesiPresensiRefs<T extends Object>(
    Expression<T> Function($$SesiPresensiTableAnnotationComposer a) f,
  ) {
    final $$SesiPresensiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sesiPresensi,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesiPresensiTableAnnotationComposer(
            $db: $db,
            $table: $db.sesiPresensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jadwalUjianRefs<T extends Object>(
    Expression<T> Function($$JadwalUjianTableAnnotationComposer a) f,
  ) {
    final $$JadwalUjianTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jadwalUjian,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JadwalUjianTableAnnotationComposer(
            $db: $db,
            $table: $db.jadwalUjian,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> edomPartisipasiRefs<T extends Object>(
    Expression<T> Function($$EdomPartisipasiTableAnnotationComposer a) f,
  ) {
    final $$EdomPartisipasiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPartisipasi,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPartisipasiTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPartisipasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> edomJawabanRefs<T extends Object>(
    Expression<T> Function($$EdomJawabanTableAnnotationComposer a) f,
  ) {
    final $$EdomJawabanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.kelasId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableAnnotationComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KelasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KelasTable,
          KelasRow,
          $$KelasTableFilterComposer,
          $$KelasTableOrderingComposer,
          $$KelasTableAnnotationComposer,
          $$KelasTableCreateCompanionBuilder,
          $$KelasTableUpdateCompanionBuilder,
          (KelasRow, $$KelasTableReferences),
          KelasRow,
          PrefetchHooks Function({
            bool mkId,
            bool dosenId,
            bool taId,
            bool krsRefs,
            bool sesiPresensiRefs,
            bool jadwalUjianRefs,
            bool edomPartisipasiRefs,
            bool edomJawabanRefs,
          })
        > {
  $$KelasTableTableManager(_$AppDatabase db, $KelasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KelasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KelasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KelasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mkId = const Value.absent(),
                Value<int> dosenId = const Value.absent(),
                Value<int> taId = const Value.absent(),
                Value<String> hari = const Value.absent(),
                Value<String> jamMulai = const Value.absent(),
                Value<String> jamSelesai = const Value.absent(),
                Value<String> ruang = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => KelasCompanion(
                id: id,
                mkId: mkId,
                dosenId: dosenId,
                taId: taId,
                hari: hari,
                jamMulai: jamMulai,
                jamSelesai: jamSelesai,
                ruang: ruang,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mkId,
                required int dosenId,
                required int taId,
                required String hari,
                required String jamMulai,
                required String jamSelesai,
                Value<String> ruang = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => KelasCompanion.insert(
                id: id,
                mkId: mkId,
                dosenId: dosenId,
                taId: taId,
                hari: hari,
                jamMulai: jamMulai,
                jamSelesai: jamSelesai,
                ruang: ruang,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KelasTable, KelasRow>(table),
                  $$KelasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mkId = false,
                dosenId = false,
                taId = false,
                krsRefs = false,
                sesiPresensiRefs = false,
                jadwalUjianRefs = false,
                edomPartisipasiRefs = false,
                edomJawabanRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (krsRefs) db.krs,
                    if (sesiPresensiRefs) db.sesiPresensi,
                    if (jadwalUjianRefs) db.jadwalUjian,
                    if (edomPartisipasiRefs) db.edomPartisipasi,
                    if (edomJawabanRefs) db.edomJawaban,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mkId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mkId,
                            referencedTable: $$KelasTableReferences._mkIdTable(
                              db,
                            ),
                            referencedColumn: $$KelasTableReferences
                                ._mkIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (dosenId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.dosenId,
                            referencedTable: $$KelasTableReferences
                                ._dosenIdTable(db),
                            referencedColumn: $$KelasTableReferences
                                ._dosenIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (taId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.taId,
                            referencedTable: $$KelasTableReferences._taIdTable(
                              db,
                            ),
                            referencedColumn: $$KelasTableReferences
                                ._taIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (krsRefs)
                        await $_getPrefetchedData<
                          KelasRow,
                          $KelasTable,
                          KrsRow
                        >(
                          currentTable: table,
                          referencedTable: $$KelasTableReferences._krsRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $$KelasTableReferences(db, table, p0).krsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kelasId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sesiPresensiRefs)
                        await $_getPrefetchedData<
                          KelasRow,
                          $KelasTable,
                          SesiPresensiRow
                        >(
                          currentTable: table,
                          referencedTable: $$KelasTableReferences
                              ._sesiPresensiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KelasTableReferences(
                                db,
                                table,
                                p0,
                              ).sesiPresensiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kelasId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jadwalUjianRefs)
                        await $_getPrefetchedData<
                          KelasRow,
                          $KelasTable,
                          JadwalUjianRow
                        >(
                          currentTable: table,
                          referencedTable: $$KelasTableReferences
                              ._jadwalUjianRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KelasTableReferences(
                                db,
                                table,
                                p0,
                              ).jadwalUjianRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kelasId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (edomPartisipasiRefs)
                        await $_getPrefetchedData<
                          KelasRow,
                          $KelasTable,
                          EdomPartisipasiRow
                        >(
                          currentTable: table,
                          referencedTable: $$KelasTableReferences
                              ._edomPartisipasiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KelasTableReferences(
                                db,
                                table,
                                p0,
                              ).edomPartisipasiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kelasId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (edomJawabanRefs)
                        await $_getPrefetchedData<
                          KelasRow,
                          $KelasTable,
                          EdomJawabanRow
                        >(
                          currentTable: table,
                          referencedTable: $$KelasTableReferences
                              ._edomJawabanRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$KelasTableReferences(
                                db,
                                table,
                                p0,
                              ).edomJawabanRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.kelasId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$KelasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KelasTable,
      KelasRow,
      $$KelasTableFilterComposer,
      $$KelasTableOrderingComposer,
      $$KelasTableAnnotationComposer,
      $$KelasTableCreateCompanionBuilder,
      $$KelasTableUpdateCompanionBuilder,
      (KelasRow, $$KelasTableReferences),
      KelasRow,
      PrefetchHooks Function({
        bool mkId,
        bool dosenId,
        bool taId,
        bool krsRefs,
        bool sesiPresensiRefs,
        bool jadwalUjianRefs,
        bool edomPartisipasiRefs,
        bool edomJawabanRefs,
      })
    >;
typedef $$KrsTableCreateCompanionBuilder = KrsCompanion Function({
  Value<int> id,
  required int mahasiswaId,
  required int kelasId,
  required int taId,
  Value<String> status,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$KrsTableUpdateCompanionBuilder = KrsCompanion Function({
  Value<int> id,
  Value<int> mahasiswaId,
  Value<int> kelasId,
  Value<int> taId,
  Value<String> status,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$KrsTableReferences
    extends BaseReferences<_$AppDatabase, $KrsTable, KrsRow> {
  $$KrsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) =>
      db.mahasiswa.createAlias('krs__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KelasTable _kelasIdTable(_$AppDatabase db) =>
      db.kelas.createAlias('krs__kelas_id__kelas__id');

  $$KelasTableProcessedTableManager get kelasId {
    final $_column = $_itemColumn<int>('kelas_id')!;

    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kelasIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TahunAjaranTable _taIdTable(_$AppDatabase db) =>
      db.tahunAjaran.createAlias('krs__ta_id__tahun_ajaran__id');

  $$TahunAjaranTableProcessedTableManager get taId {
    final $_column = $_itemColumn<int>('ta_id')!;

    final manager = $$TahunAjaranTableTableManager(
      $_db,
      $_db.tahunAjaran,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$NilaiTable, List<NilaiRow>> _nilaiRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.nilai,
    aliasName: 'krs__id__nilai__krs_id',
  );

  $$NilaiTableProcessedTableManager get nilaiRefs {
    final manager = $$NilaiTableTableManager(
      $_db,
      $_db.nilai,
    ).filter((f) => f.krsId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_nilaiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KrsTableFilterComposer extends Composer<_$AppDatabase, $KrsTable> {
  $$KrsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableFilterComposer get kelasId {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TahunAjaranTableFilterComposer get taId {
    final $$TahunAjaranTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableFilterComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> nilaiRefs(
    Expression<bool> Function($$NilaiTableFilterComposer f) f,
  ) {
    final $$NilaiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nilai,
      getReferencedColumn: (t) => t.krsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NilaiTableFilterComposer(
            $db: $db,
            $table: $db.nilai,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KrsTableOrderingComposer extends Composer<_$AppDatabase, $KrsTable> {
  $$KrsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableOrderingComposer get kelasId {
    final $$KelasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableOrderingComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TahunAjaranTableOrderingComposer get taId {
    final $$TahunAjaranTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableOrderingComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KrsTableAnnotationComposer extends Composer<_$AppDatabase, $KrsTable> {
  $$KrsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableAnnotationComposer get kelasId {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TahunAjaranTableAnnotationComposer get taId {
    final $$TahunAjaranTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableAnnotationComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> nilaiRefs<T extends Object>(
    Expression<T> Function($$NilaiTableAnnotationComposer a) f,
  ) {
    final $$NilaiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nilai,
      getReferencedColumn: (t) => t.krsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NilaiTableAnnotationComposer(
            $db: $db,
            $table: $db.nilai,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KrsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KrsTable,
          KrsRow,
          $$KrsTableFilterComposer,
          $$KrsTableOrderingComposer,
          $$KrsTableAnnotationComposer,
          $$KrsTableCreateCompanionBuilder,
          $$KrsTableUpdateCompanionBuilder,
          (KrsRow, $$KrsTableReferences),
          KrsRow,
          PrefetchHooks Function({
            bool mahasiswaId,
            bool kelasId,
            bool taId,
            bool nilaiRefs,
          })
        > {
  $$KrsTableTableManager(_$AppDatabase db, $KrsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KrsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KrsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KrsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<int> kelasId = const Value.absent(),
                Value<int> taId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => KrsCompanion(
                id: id,
                mahasiswaId: mahasiswaId,
                kelasId: kelasId,
                taId: taId,
                status: status,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mahasiswaId,
                required int kelasId,
                required int taId,
                Value<String> status = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => KrsCompanion.insert(
                id: id,
                mahasiswaId: mahasiswaId,
                kelasId: kelasId,
                taId: taId,
                status: status,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KrsTable, KrsRow>(table),
                  $$KrsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mahasiswaId = false,
                kelasId = false,
                taId = false,
                nilaiRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (nilaiRefs) db.nilai],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mahasiswaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mahasiswaId,
                            referencedTable: $$KrsTableReferences
                                ._mahasiswaIdTable(db),
                            referencedColumn: $$KrsTableReferences
                                ._mahasiswaIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (kelasId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.kelasId,
                            referencedTable: $$KrsTableReferences._kelasIdTable(
                              db,
                            ),
                            referencedColumn: $$KrsTableReferences
                                ._kelasIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (taId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.taId,
                            referencedTable: $$KrsTableReferences._taIdTable(
                              db,
                            ),
                            referencedColumn: $$KrsTableReferences
                                ._taIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (nilaiRefs)
                        await $_getPrefetchedData<KrsRow, $KrsTable, NilaiRow>(
                          currentTable: table,
                          referencedTable: $$KrsTableReferences._nilaiRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $$KrsTableReferences(db, table, p0).nilaiRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.krsId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$KrsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KrsTable,
      KrsRow,
      $$KrsTableFilterComposer,
      $$KrsTableOrderingComposer,
      $$KrsTableAnnotationComposer,
      $$KrsTableCreateCompanionBuilder,
      $$KrsTableUpdateCompanionBuilder,
      (KrsRow, $$KrsTableReferences),
      KrsRow,
      PrefetchHooks Function({
        bool mahasiswaId,
        bool kelasId,
        bool taId,
        bool nilaiRefs,
      })
    >;
typedef $$NilaiTableCreateCompanionBuilder = NilaiCompanion Function({
  Value<int> id,
  required int krsId,
  Value<double> tugas,
  Value<double> uts,
  Value<double> uas,
  Value<double> nilaiAkhir,
  Value<String> huruf,
  Value<double> bobot,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$NilaiTableUpdateCompanionBuilder = NilaiCompanion Function({
  Value<int> id,
  Value<int> krsId,
  Value<double> tugas,
  Value<double> uts,
  Value<double> uas,
  Value<double> nilaiAkhir,
  Value<String> huruf,
  Value<double> bobot,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$NilaiTableReferences
    extends BaseReferences<_$AppDatabase, $NilaiTable, NilaiRow> {
  $$NilaiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KrsTable _krsIdTable(_$AppDatabase db) =>
      db.krs.createAlias('nilai__krs_id__krs__id');

  $$KrsTableProcessedTableManager get krsId {
    final $_column = $_itemColumn<int>('krs_id')!;

    final manager = $$KrsTableTableManager(
      $_db,
      $_db.krs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_krsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NilaiTableFilterComposer extends Composer<_$AppDatabase, $NilaiTable> {
  $$NilaiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tugas => $composableBuilder(
    column: $table.tugas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uts => $composableBuilder(
    column: $table.uts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uas => $composableBuilder(
    column: $table.uas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get nilaiAkhir => $composableBuilder(
    column: $table.nilaiAkhir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get huruf => $composableBuilder(
    column: $table.huruf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bobot => $composableBuilder(
    column: $table.bobot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$KrsTableFilterComposer get krsId {
    final $$KrsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.krsId,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableFilterComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NilaiTableOrderingComposer
    extends Composer<_$AppDatabase, $NilaiTable> {
  $$NilaiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tugas => $composableBuilder(
    column: $table.tugas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uts => $composableBuilder(
    column: $table.uts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uas => $composableBuilder(
    column: $table.uas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get nilaiAkhir => $composableBuilder(
    column: $table.nilaiAkhir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get huruf => $composableBuilder(
    column: $table.huruf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bobot => $composableBuilder(
    column: $table.bobot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$KrsTableOrderingComposer get krsId {
    final $$KrsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.krsId,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableOrderingComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NilaiTableAnnotationComposer
    extends Composer<_$AppDatabase, $NilaiTable> {
  $$NilaiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get tugas =>
      $composableBuilder(column: $table.tugas, builder: (column) => column);

  GeneratedColumn<double> get uts =>
      $composableBuilder(column: $table.uts, builder: (column) => column);

  GeneratedColumn<double> get uas =>
      $composableBuilder(column: $table.uas, builder: (column) => column);

  GeneratedColumn<double> get nilaiAkhir => $composableBuilder(
    column: $table.nilaiAkhir,
    builder: (column) => column,
  );

  GeneratedColumn<String> get huruf =>
      $composableBuilder(column: $table.huruf, builder: (column) => column);

  GeneratedColumn<double> get bobot =>
      $composableBuilder(column: $table.bobot, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$KrsTableAnnotationComposer get krsId {
    final $$KrsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.krsId,
      referencedTable: $db.krs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KrsTableAnnotationComposer(
            $db: $db,
            $table: $db.krs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NilaiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NilaiTable,
          NilaiRow,
          $$NilaiTableFilterComposer,
          $$NilaiTableOrderingComposer,
          $$NilaiTableAnnotationComposer,
          $$NilaiTableCreateCompanionBuilder,
          $$NilaiTableUpdateCompanionBuilder,
          (NilaiRow, $$NilaiTableReferences),
          NilaiRow,
          PrefetchHooks Function({bool krsId})
        > {
  $$NilaiTableTableManager(_$AppDatabase db, $NilaiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NilaiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NilaiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NilaiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> krsId = const Value.absent(),
                Value<double> tugas = const Value.absent(),
                Value<double> uts = const Value.absent(),
                Value<double> uas = const Value.absent(),
                Value<double> nilaiAkhir = const Value.absent(),
                Value<String> huruf = const Value.absent(),
                Value<double> bobot = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => NilaiCompanion(
                id: id,
                krsId: krsId,
                tugas: tugas,
                uts: uts,
                uas: uas,
                nilaiAkhir: nilaiAkhir,
                huruf: huruf,
                bobot: bobot,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int krsId,
                Value<double> tugas = const Value.absent(),
                Value<double> uts = const Value.absent(),
                Value<double> uas = const Value.absent(),
                Value<double> nilaiAkhir = const Value.absent(),
                Value<String> huruf = const Value.absent(),
                Value<double> bobot = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => NilaiCompanion.insert(
                id: id,
                krsId: krsId,
                tugas: tugas,
                uts: uts,
                uas: uas,
                nilaiAkhir: nilaiAkhir,
                huruf: huruf,
                bobot: bobot,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NilaiTable, NilaiRow>(table),
                  $$NilaiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({krsId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (krsId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.krsId,
                        referencedTable: $$NilaiTableReferences._krsIdTable(db),
                        referencedColumn: $$NilaiTableReferences
                            ._krsIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NilaiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NilaiTable,
      NilaiRow,
      $$NilaiTableFilterComposer,
      $$NilaiTableOrderingComposer,
      $$NilaiTableAnnotationComposer,
      $$NilaiTableCreateCompanionBuilder,
      $$NilaiTableUpdateCompanionBuilder,
      (NilaiRow, $$NilaiTableReferences),
      NilaiRow,
      PrefetchHooks Function({bool krsId})
    >;
typedef $$SesiPresensiTableCreateCompanionBuilder =
    SesiPresensiCompanion Function({
      Value<int> id,
      required int kelasId,
      required int pertemuanKe,
      required DateTime tanggal,
      required String qrSecret,
      Value<DateTime?> dibukaSampai,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$SesiPresensiTableUpdateCompanionBuilder =
    SesiPresensiCompanion Function({
      Value<int> id,
      Value<int> kelasId,
      Value<int> pertemuanKe,
      Value<DateTime> tanggal,
      Value<String> qrSecret,
      Value<DateTime?> dibukaSampai,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$SesiPresensiTableReferences
    extends BaseReferences<_$AppDatabase, $SesiPresensiTable, SesiPresensiRow> {
  $$SesiPresensiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KelasTable _kelasIdTable(_$AppDatabase db) =>
      db.kelas.createAlias('sesi_presensi__kelas_id__kelas__id');

  $$KelasTableProcessedTableManager get kelasId {
    final $_column = $_itemColumn<int>('kelas_id')!;

    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kelasIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PresensiTable, List<PresensiRow>>
  _presensiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.presensi,
    aliasName: 'sesi_presensi__id__presensi__sesi_id',
  );

  $$PresensiTableProcessedTableManager get presensiRefs {
    final manager = $$PresensiTableTableManager(
      $_db,
      $_db.presensi,
    ).filter((f) => f.sesiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_presensiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SesiPresensiTableFilterComposer
    extends Composer<_$AppDatabase, $SesiPresensiTable> {
  $$SesiPresensiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pertemuanKe => $composableBuilder(
    column: $table.pertemuanKe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrSecret => $composableBuilder(
    column: $table.qrSecret,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibukaSampai => $composableBuilder(
    column: $table.dibukaSampai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$KelasTableFilterComposer get kelasId {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> presensiRefs(
    Expression<bool> Function($$PresensiTableFilterComposer f) f,
  ) {
    final $$PresensiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presensi,
      getReferencedColumn: (t) => t.sesiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresensiTableFilterComposer(
            $db: $db,
            $table: $db.presensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SesiPresensiTableOrderingComposer
    extends Composer<_$AppDatabase, $SesiPresensiTable> {
  $$SesiPresensiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pertemuanKe => $composableBuilder(
    column: $table.pertemuanKe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrSecret => $composableBuilder(
    column: $table.qrSecret,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibukaSampai => $composableBuilder(
    column: $table.dibukaSampai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$KelasTableOrderingComposer get kelasId {
    final $$KelasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableOrderingComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SesiPresensiTableAnnotationComposer
    extends Composer<_$AppDatabase, $SesiPresensiTable> {
  $$SesiPresensiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pertemuanKe => $composableBuilder(
    column: $table.pertemuanKe,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<String> get qrSecret =>
      $composableBuilder(column: $table.qrSecret, builder: (column) => column);

  GeneratedColumn<DateTime> get dibukaSampai => $composableBuilder(
    column: $table.dibukaSampai,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$KelasTableAnnotationComposer get kelasId {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> presensiRefs<T extends Object>(
    Expression<T> Function($$PresensiTableAnnotationComposer a) f,
  ) {
    final $$PresensiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presensi,
      getReferencedColumn: (t) => t.sesiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresensiTableAnnotationComposer(
            $db: $db,
            $table: $db.presensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SesiPresensiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SesiPresensiTable,
          SesiPresensiRow,
          $$SesiPresensiTableFilterComposer,
          $$SesiPresensiTableOrderingComposer,
          $$SesiPresensiTableAnnotationComposer,
          $$SesiPresensiTableCreateCompanionBuilder,
          $$SesiPresensiTableUpdateCompanionBuilder,
          (SesiPresensiRow, $$SesiPresensiTableReferences),
          SesiPresensiRow,
          PrefetchHooks Function({bool kelasId, bool presensiRefs})
        > {
  $$SesiPresensiTableTableManager(_$AppDatabase db, $SesiPresensiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SesiPresensiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SesiPresensiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SesiPresensiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> kelasId = const Value.absent(),
                Value<int> pertemuanKe = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<String> qrSecret = const Value.absent(),
                Value<DateTime?> dibukaSampai = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => SesiPresensiCompanion(
                id: id,
                kelasId: kelasId,
                pertemuanKe: pertemuanKe,
                tanggal: tanggal,
                qrSecret: qrSecret,
                dibukaSampai: dibukaSampai,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int kelasId,
                required int pertemuanKe,
                required DateTime tanggal,
                required String qrSecret,
                Value<DateTime?> dibukaSampai = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => SesiPresensiCompanion.insert(
                id: id,
                kelasId: kelasId,
                pertemuanKe: pertemuanKe,
                tanggal: tanggal,
                qrSecret: qrSecret,
                dibukaSampai: dibukaSampai,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SesiPresensiTable, SesiPresensiRow>(table),
                  $$SesiPresensiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kelasId = false, presensiRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (presensiRefs) db.presensi],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kelasId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.kelasId,
                        referencedTable: $$SesiPresensiTableReferences
                            ._kelasIdTable(db),
                        referencedColumn: $$SesiPresensiTableReferences
                            ._kelasIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (presensiRefs)
                    await $_getPrefetchedData<
                      SesiPresensiRow,
                      $SesiPresensiTable,
                      PresensiRow
                    >(
                      currentTable: table,
                      referencedTable: $$SesiPresensiTableReferences
                          ._presensiRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SesiPresensiTableReferences(
                            db,
                            table,
                            p0,
                          ).presensiRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sesiId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SesiPresensiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SesiPresensiTable,
      SesiPresensiRow,
      $$SesiPresensiTableFilterComposer,
      $$SesiPresensiTableOrderingComposer,
      $$SesiPresensiTableAnnotationComposer,
      $$SesiPresensiTableCreateCompanionBuilder,
      $$SesiPresensiTableUpdateCompanionBuilder,
      (SesiPresensiRow, $$SesiPresensiTableReferences),
      SesiPresensiRow,
      PrefetchHooks Function({bool kelasId, bool presensiRefs})
    >;
typedef $$PresensiTableCreateCompanionBuilder = PresensiCompanion Function({
  Value<int> id,
  required int sesiId,
  required int mahasiswaId,
  required String status,
  Value<String> metode,
  required DateTime waktu,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$PresensiTableUpdateCompanionBuilder = PresensiCompanion Function({
  Value<int> id,
  Value<int> sesiId,
  Value<int> mahasiswaId,
  Value<String> status,
  Value<String> metode,
  Value<DateTime> waktu,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$PresensiTableReferences
    extends BaseReferences<_$AppDatabase, $PresensiTable, PresensiRow> {
  $$PresensiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SesiPresensiTable _sesiIdTable(_$AppDatabase db) =>
      db.sesiPresensi.createAlias('presensi__sesi_id__sesi_presensi__id');

  $$SesiPresensiTableProcessedTableManager get sesiId {
    final $_column = $_itemColumn<int>('sesi_id')!;

    final manager = $$SesiPresensiTableTableManager(
      $_db,
      $_db.sesiPresensi,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sesiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) =>
      db.mahasiswa.createAlias('presensi__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PresensiTableFilterComposer
    extends Composer<_$AppDatabase, $PresensiTable> {
  $$PresensiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metode => $composableBuilder(
    column: $table.metode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$SesiPresensiTableFilterComposer get sesiId {
    final $$SesiPresensiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sesiId,
      referencedTable: $db.sesiPresensi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesiPresensiTableFilterComposer(
            $db: $db,
            $table: $db.sesiPresensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PresensiTableOrderingComposer
    extends Composer<_$AppDatabase, $PresensiTable> {
  $$PresensiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metode => $composableBuilder(
    column: $table.metode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$SesiPresensiTableOrderingComposer get sesiId {
    final $$SesiPresensiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sesiId,
      referencedTable: $db.sesiPresensi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesiPresensiTableOrderingComposer(
            $db: $db,
            $table: $db.sesiPresensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PresensiTableAnnotationComposer
    extends Composer<_$AppDatabase, $PresensiTable> {
  $$PresensiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get metode =>
      $composableBuilder(column: $table.metode, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$SesiPresensiTableAnnotationComposer get sesiId {
    final $$SesiPresensiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sesiId,
      referencedTable: $db.sesiPresensi,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SesiPresensiTableAnnotationComposer(
            $db: $db,
            $table: $db.sesiPresensi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PresensiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PresensiTable,
          PresensiRow,
          $$PresensiTableFilterComposer,
          $$PresensiTableOrderingComposer,
          $$PresensiTableAnnotationComposer,
          $$PresensiTableCreateCompanionBuilder,
          $$PresensiTableUpdateCompanionBuilder,
          (PresensiRow, $$PresensiTableReferences),
          PresensiRow,
          PrefetchHooks Function({bool sesiId, bool mahasiswaId})
        > {
  $$PresensiTableTableManager(_$AppDatabase db, $PresensiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PresensiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PresensiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PresensiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sesiId = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> metode = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => PresensiCompanion(
                id: id,
                sesiId: sesiId,
                mahasiswaId: mahasiswaId,
                status: status,
                metode: metode,
                waktu: waktu,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sesiId,
                required int mahasiswaId,
                required String status,
                Value<String> metode = const Value.absent(),
                required DateTime waktu,
                required DateTime updatedAt,
                required String deviceId,
              }) => PresensiCompanion.insert(
                id: id,
                sesiId: sesiId,
                mahasiswaId: mahasiswaId,
                status: status,
                metode: metode,
                waktu: waktu,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PresensiTable, PresensiRow>(table),
                  $$PresensiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sesiId = false, mahasiswaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sesiId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sesiId,
                        referencedTable: $$PresensiTableReferences._sesiIdTable(
                          db,
                        ),
                        referencedColumn: $$PresensiTableReferences
                            ._sesiIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (mahasiswaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mahasiswaId,
                        referencedTable: $$PresensiTableReferences
                            ._mahasiswaIdTable(db),
                        referencedColumn: $$PresensiTableReferences
                            ._mahasiswaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PresensiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PresensiTable,
      PresensiRow,
      $$PresensiTableFilterComposer,
      $$PresensiTableOrderingComposer,
      $$PresensiTableAnnotationComposer,
      $$PresensiTableCreateCompanionBuilder,
      $$PresensiTableUpdateCompanionBuilder,
      (PresensiRow, $$PresensiTableReferences),
      PresensiRow,
      PrefetchHooks Function({bool sesiId, bool mahasiswaId})
    >;
typedef $$CatatanBimbinganTableCreateCompanionBuilder =
    CatatanBimbinganCompanion Function({
      Value<int> id,
      required int mahasiswaId,
      required int dosenId,
      required String isi,
      Value<String?> tindakLanjut,
      required DateTime tanggal,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$CatatanBimbinganTableUpdateCompanionBuilder =
    CatatanBimbinganCompanion Function({
      Value<int> id,
      Value<int> mahasiswaId,
      Value<int> dosenId,
      Value<String> isi,
      Value<String?> tindakLanjut,
      Value<DateTime> tanggal,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$CatatanBimbinganTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CatatanBimbinganTable,
          CatatanBimbinganRow
        > {
  $$CatatanBimbinganTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) => db.mahasiswa
      .createAlias('catatan_bimbingan__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DosensTable _dosenIdTable(_$AppDatabase db) =>
      db.dosens.createAlias('catatan_bimbingan__dosen_id__dosens__id');

  $$DosensTableProcessedTableManager get dosenId {
    final $_column = $_itemColumn<int>('dosen_id')!;

    final manager = $$DosensTableTableManager(
      $_db,
      $_db.dosens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dosenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CatatanBimbinganTableFilterComposer
    extends Composer<_$AppDatabase, $CatatanBimbinganTable> {
  $$CatatanBimbinganTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isi => $composableBuilder(
    column: $table.isi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tindakLanjut => $composableBuilder(
    column: $table.tindakLanjut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableFilterComposer get dosenId {
    final $$DosensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableFilterComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatatanBimbinganTableOrderingComposer
    extends Composer<_$AppDatabase, $CatatanBimbinganTable> {
  $$CatatanBimbinganTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isi => $composableBuilder(
    column: $table.isi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tindakLanjut => $composableBuilder(
    column: $table.tindakLanjut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableOrderingComposer get dosenId {
    final $$DosensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableOrderingComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatatanBimbinganTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatatanBimbinganTable> {
  $$CatatanBimbinganTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get isi =>
      $composableBuilder(column: $table.isi, builder: (column) => column);

  GeneratedColumn<String> get tindakLanjut => $composableBuilder(
    column: $table.tindakLanjut,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableAnnotationComposer get dosenId {
    final $$DosensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableAnnotationComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatatanBimbinganTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CatatanBimbinganTable,
          CatatanBimbinganRow,
          $$CatatanBimbinganTableFilterComposer,
          $$CatatanBimbinganTableOrderingComposer,
          $$CatatanBimbinganTableAnnotationComposer,
          $$CatatanBimbinganTableCreateCompanionBuilder,
          $$CatatanBimbinganTableUpdateCompanionBuilder,
          (CatatanBimbinganRow, $$CatatanBimbinganTableReferences),
          CatatanBimbinganRow,
          PrefetchHooks Function({bool mahasiswaId, bool dosenId})
        > {
  $$CatatanBimbinganTableTableManager(
    _$AppDatabase db,
    $CatatanBimbinganTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatatanBimbinganTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatatanBimbinganTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatatanBimbinganTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<int> dosenId = const Value.absent(),
                Value<String> isi = const Value.absent(),
                Value<String?> tindakLanjut = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => CatatanBimbinganCompanion(
                id: id,
                mahasiswaId: mahasiswaId,
                dosenId: dosenId,
                isi: isi,
                tindakLanjut: tindakLanjut,
                tanggal: tanggal,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mahasiswaId,
                required int dosenId,
                required String isi,
                Value<String?> tindakLanjut = const Value.absent(),
                required DateTime tanggal,
                required DateTime updatedAt,
                required String deviceId,
              }) => CatatanBimbinganCompanion.insert(
                id: id,
                mahasiswaId: mahasiswaId,
                dosenId: dosenId,
                isi: isi,
                tindakLanjut: tindakLanjut,
                tanggal: tanggal,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CatatanBimbinganTable, CatatanBimbinganRow>(
                    table,
                  ),
                  $$CatatanBimbinganTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mahasiswaId = false, dosenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mahasiswaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mahasiswaId,
                        referencedTable: $$CatatanBimbinganTableReferences
                            ._mahasiswaIdTable(db),
                        referencedColumn: $$CatatanBimbinganTableReferences
                            ._mahasiswaIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (dosenId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.dosenId,
                        referencedTable: $$CatatanBimbinganTableReferences
                            ._dosenIdTable(db),
                        referencedColumn: $$CatatanBimbinganTableReferences
                            ._dosenIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CatatanBimbinganTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CatatanBimbinganTable,
      CatatanBimbinganRow,
      $$CatatanBimbinganTableFilterComposer,
      $$CatatanBimbinganTableOrderingComposer,
      $$CatatanBimbinganTableAnnotationComposer,
      $$CatatanBimbinganTableCreateCompanionBuilder,
      $$CatatanBimbinganTableUpdateCompanionBuilder,
      (CatatanBimbinganRow, $$CatatanBimbinganTableReferences),
      CatatanBimbinganRow,
      PrefetchHooks Function({bool mahasiswaId, bool dosenId})
    >;
typedef $$PeringatanTableCreateCompanionBuilder = PeringatanCompanion Function({
  Value<int> id,
  required int mahasiswaId,
  required String jenis,
  required double skor,
  Value<String> detail,
  required DateTime dibuatPada,
  Value<bool> ditangani,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$PeringatanTableUpdateCompanionBuilder = PeringatanCompanion Function({
  Value<int> id,
  Value<int> mahasiswaId,
  Value<String> jenis,
  Value<double> skor,
  Value<String> detail,
  Value<DateTime> dibuatPada,
  Value<bool> ditangani,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$PeringatanTableReferences
    extends BaseReferences<_$AppDatabase, $PeringatanTable, PeringatanRow> {
  $$PeringatanTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) =>
      db.mahasiswa.createAlias('peringatan__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PeringatanTableFilterComposer
    extends Composer<_$AppDatabase, $PeringatanTable> {
  $$PeringatanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get skor => $composableBuilder(
    column: $table.skor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ditangani => $composableBuilder(
    column: $table.ditangani,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeringatanTableOrderingComposer
    extends Composer<_$AppDatabase, $PeringatanTable> {
  $$PeringatanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get skor => $composableBuilder(
    column: $table.skor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ditangani => $composableBuilder(
    column: $table.ditangani,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeringatanTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeringatanTable> {
  $$PeringatanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<double> get skor =>
      $composableBuilder(column: $table.skor, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get ditangani =>
      $composableBuilder(column: $table.ditangani, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeringatanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PeringatanTable,
          PeringatanRow,
          $$PeringatanTableFilterComposer,
          $$PeringatanTableOrderingComposer,
          $$PeringatanTableAnnotationComposer,
          $$PeringatanTableCreateCompanionBuilder,
          $$PeringatanTableUpdateCompanionBuilder,
          (PeringatanRow, $$PeringatanTableReferences),
          PeringatanRow,
          PrefetchHooks Function({bool mahasiswaId})
        > {
  $$PeringatanTableTableManager(_$AppDatabase db, $PeringatanTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeringatanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeringatanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeringatanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<String> jenis = const Value.absent(),
                Value<double> skor = const Value.absent(),
                Value<String> detail = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
                Value<bool> ditangani = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => PeringatanCompanion(
                id: id,
                mahasiswaId: mahasiswaId,
                jenis: jenis,
                skor: skor,
                detail: detail,
                dibuatPada: dibuatPada,
                ditangani: ditangani,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mahasiswaId,
                required String jenis,
                required double skor,
                Value<String> detail = const Value.absent(),
                required DateTime dibuatPada,
                Value<bool> ditangani = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => PeringatanCompanion.insert(
                id: id,
                mahasiswaId: mahasiswaId,
                jenis: jenis,
                skor: skor,
                detail: detail,
                dibuatPada: dibuatPada,
                ditangani: ditangani,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PeringatanTable, PeringatanRow>(table),
                  $$PeringatanTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mahasiswaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mahasiswaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mahasiswaId,
                        referencedTable: $$PeringatanTableReferences
                            ._mahasiswaIdTable(db),
                        referencedColumn: $$PeringatanTableReferences
                            ._mahasiswaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PeringatanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PeringatanTable,
      PeringatanRow,
      $$PeringatanTableFilterComposer,
      $$PeringatanTableOrderingComposer,
      $$PeringatanTableAnnotationComposer,
      $$PeringatanTableCreateCompanionBuilder,
      $$PeringatanTableUpdateCompanionBuilder,
      (PeringatanRow, $$PeringatanTableReferences),
      PeringatanRow,
      PrefetchHooks Function({bool mahasiswaId})
    >;
typedef $$AuditLogTableCreateCompanionBuilder = AuditLogCompanion Function({
  Value<int> id,
  Value<int?> userId,
  required String aksi,
  required String entitas,
  Value<String?> entitasId,
  Value<String?> sebelum,
  Value<String?> sesudah,
  required DateTime waktu,
});
typedef $$AuditLogTableUpdateCompanionBuilder = AuditLogCompanion Function({
  Value<int> id,
  Value<int?> userId,
  Value<String> aksi,
  Value<String> entitas,
  Value<String?> entitasId,
  Value<String?> sebelum,
  Value<String?> sesudah,
  Value<DateTime> waktu,
});

final class $$AuditLogTableReferences
    extends BaseReferences<_$AppDatabase, $AuditLogTable, AuditLogRow> {
  $$AuditLogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('audit_log__user_id__users__id');

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AuditLogTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entitas => $composableBuilder(
    column: $table.entitas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entitasId => $composableBuilder(
    column: $table.entitasId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sebelum => $composableBuilder(
    column: $table.sebelum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sesudah => $composableBuilder(
    column: $table.sesudah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entitas => $composableBuilder(
    column: $table.entitas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entitasId => $composableBuilder(
    column: $table.entitasId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sebelum => $composableBuilder(
    column: $table.sebelum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sesudah => $composableBuilder(
    column: $table.sesudah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogTable> {
  $$AuditLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get aksi =>
      $composableBuilder(column: $table.aksi, builder: (column) => column);

  GeneratedColumn<String> get entitas =>
      $composableBuilder(column: $table.entitas, builder: (column) => column);

  GeneratedColumn<String> get entitasId =>
      $composableBuilder(column: $table.entitasId, builder: (column) => column);

  GeneratedColumn<String> get sebelum =>
      $composableBuilder(column: $table.sebelum, builder: (column) => column);

  GeneratedColumn<String> get sesudah =>
      $composableBuilder(column: $table.sesudah, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogTable,
          AuditLogRow,
          $$AuditLogTableFilterComposer,
          $$AuditLogTableOrderingComposer,
          $$AuditLogTableAnnotationComposer,
          $$AuditLogTableCreateCompanionBuilder,
          $$AuditLogTableUpdateCompanionBuilder,
          (AuditLogRow, $$AuditLogTableReferences),
          AuditLogRow,
          PrefetchHooks Function({bool userId})
        > {
  $$AuditLogTableTableManager(_$AppDatabase db, $AuditLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String> aksi = const Value.absent(),
                Value<String> entitas = const Value.absent(),
                Value<String?> entitasId = const Value.absent(),
                Value<String?> sebelum = const Value.absent(),
                Value<String?> sesudah = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
              }) => AuditLogCompanion(
                id: id,
                userId: userId,
                aksi: aksi,
                entitas: entitas,
                entitasId: entitasId,
                sebelum: sebelum,
                sesudah: sesudah,
                waktu: waktu,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                required String aksi,
                required String entitas,
                Value<String?> entitasId = const Value.absent(),
                Value<String?> sebelum = const Value.absent(),
                Value<String?> sesudah = const Value.absent(),
                required DateTime waktu,
              }) => AuditLogCompanion.insert(
                id: id,
                userId: userId,
                aksi: aksi,
                entitas: entitas,
                entitasId: entitasId,
                sebelum: sebelum,
                sesudah: sesudah,
                waktu: waktu,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogTable, AuditLogRow>(table),
                  $$AuditLogTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$AuditLogTableReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $$AuditLogTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AuditLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogTable,
      AuditLogRow,
      $$AuditLogTableFilterComposer,
      $$AuditLogTableOrderingComposer,
      $$AuditLogTableAnnotationComposer,
      $$AuditLogTableCreateCompanionBuilder,
      $$AuditLogTableUpdateCompanionBuilder,
      (AuditLogRow, $$AuditLogTableReferences),
      AuditLogRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$SyncLogTableCreateCompanionBuilder = SyncLogCompanion Function({
  Value<int> id,
  required String deviceId,
  required String arah,
  Value<int> jumlahRecord,
  Value<int> konflik,
  required DateTime waktu,
});
typedef $$SyncLogTableUpdateCompanionBuilder = SyncLogCompanion Function({
  Value<int> id,
  Value<String> deviceId,
  Value<String> arah,
  Value<int> jumlahRecord,
  Value<int> konflik,
  Value<DateTime> waktu,
});

class $$SyncLogTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arah => $composableBuilder(
    column: $table.arah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jumlahRecord => $composableBuilder(
    column: $table.jumlahRecord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get konflik => $composableBuilder(
    column: $table.konflik,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncLogTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arah => $composableBuilder(
    column: $table.arah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jumlahRecord => $composableBuilder(
    column: $table.jumlahRecord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get konflik => $composableBuilder(
    column: $table.konflik,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get arah =>
      $composableBuilder(column: $table.arah, builder: (column) => column);

  GeneratedColumn<int> get jumlahRecord => $composableBuilder(
    column: $table.jumlahRecord,
    builder: (column) => column,
  );

  GeneratedColumn<int> get konflik =>
      $composableBuilder(column: $table.konflik, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);
}

class $$SyncLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncLogTable,
          SyncLogRow,
          $$SyncLogTableFilterComposer,
          $$SyncLogTableOrderingComposer,
          $$SyncLogTableAnnotationComposer,
          $$SyncLogTableCreateCompanionBuilder,
          $$SyncLogTableUpdateCompanionBuilder,
          (
            SyncLogRow,
            BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogRow>,
          ),
          SyncLogRow,
          PrefetchHooks Function()
        > {
  $$SyncLogTableTableManager(_$AppDatabase db, $SyncLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> arah = const Value.absent(),
                Value<int> jumlahRecord = const Value.absent(),
                Value<int> konflik = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
              }) => SyncLogCompanion(
                id: id,
                deviceId: deviceId,
                arah: arah,
                jumlahRecord: jumlahRecord,
                konflik: konflik,
                waktu: waktu,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String deviceId,
                required String arah,
                Value<int> jumlahRecord = const Value.absent(),
                Value<int> konflik = const Value.absent(),
                required DateTime waktu,
              }) => SyncLogCompanion.insert(
                id: id,
                deviceId: deviceId,
                arah: arah,
                jumlahRecord: jumlahRecord,
                konflik: konflik,
                waktu: waktu,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncLogTable, SyncLogRow>(table),
                  BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncLogTable,
      SyncLogRow,
      $$SyncLogTableFilterComposer,
      $$SyncLogTableOrderingComposer,
      $$SyncLogTableAnnotationComposer,
      $$SyncLogTableCreateCompanionBuilder,
      $$SyncLogTableUpdateCompanionBuilder,
      (SyncLogRow, BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogRow>),
      SyncLogRow,
      PrefetchHooks Function()
    >;
typedef $$PengaturanTableCreateCompanionBuilder = PengaturanCompanion Function({
  required String kunci,
  required String nilai,
  required DateTime updatedAt,
  required String deviceId,
  Value<int> rowid,
});
typedef $$PengaturanTableUpdateCompanionBuilder = PengaturanCompanion Function({
  Value<String> kunci,
  Value<String> nilai,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
  Value<int> rowid,
});

class $$PengaturanTableFilterComposer
    extends Composer<_$AppDatabase, $PengaturanTable> {
  $$PengaturanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get kunci => $composableBuilder(
    column: $table.kunci,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nilai => $composableBuilder(
    column: $table.nilai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PengaturanTableOrderingComposer
    extends Composer<_$AppDatabase, $PengaturanTable> {
  $$PengaturanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get kunci => $composableBuilder(
    column: $table.kunci,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nilai => $composableBuilder(
    column: $table.nilai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PengaturanTableAnnotationComposer
    extends Composer<_$AppDatabase, $PengaturanTable> {
  $$PengaturanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get kunci =>
      $composableBuilder(column: $table.kunci, builder: (column) => column);

  GeneratedColumn<String> get nilai =>
      $composableBuilder(column: $table.nilai, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);
}

class $$PengaturanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PengaturanTable,
          PengaturanRow,
          $$PengaturanTableFilterComposer,
          $$PengaturanTableOrderingComposer,
          $$PengaturanTableAnnotationComposer,
          $$PengaturanTableCreateCompanionBuilder,
          $$PengaturanTableUpdateCompanionBuilder,
          (
            PengaturanRow,
            BaseReferences<_$AppDatabase, $PengaturanTable, PengaturanRow>,
          ),
          PengaturanRow,
          PrefetchHooks Function()
        > {
  $$PengaturanTableTableManager(_$AppDatabase db, $PengaturanTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PengaturanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PengaturanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PengaturanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> kunci = const Value.absent(),
                Value<String> nilai = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PengaturanCompanion(
                kunci: kunci,
                nilai: nilai,
                updatedAt: updatedAt,
                deviceId: deviceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String kunci,
                required String nilai,
                required DateTime updatedAt,
                required String deviceId,
                Value<int> rowid = const Value.absent(),
              }) => PengaturanCompanion.insert(
                kunci: kunci,
                nilai: nilai,
                updatedAt: updatedAt,
                deviceId: deviceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PengaturanTable, PengaturanRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PengaturanTable,
                    PengaturanRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PengaturanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PengaturanTable,
      PengaturanRow,
      $$PengaturanTableFilterComposer,
      $$PengaturanTableOrderingComposer,
      $$PengaturanTableAnnotationComposer,
      $$PengaturanTableCreateCompanionBuilder,
      $$PengaturanTableUpdateCompanionBuilder,
      (
        PengaturanRow,
        BaseReferences<_$AppDatabase, $PengaturanTable, PengaturanRow>,
      ),
      PengaturanRow,
      PrefetchHooks Function()
    >;
typedef $$PengumumanTableCreateCompanionBuilder = PengumumanCompanion Function({
  Value<int> id,
  required String judul,
  required String isi,
  Value<String> kategori,
  Value<DateTime?> tanggalMulai,
  Value<DateTime?> tanggalSelesai,
  Value<int?> dibuatOleh,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$PengumumanTableUpdateCompanionBuilder = PengumumanCompanion Function({
  Value<int> id,
  Value<String> judul,
  Value<String> isi,
  Value<String> kategori,
  Value<DateTime?> tanggalMulai,
  Value<DateTime?> tanggalSelesai,
  Value<int?> dibuatOleh,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$PengumumanTableReferences
    extends BaseReferences<_$AppDatabase, $PengumumanTable, PengumumanRow> {
  $$PengumumanTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _dibuatOlehTable(_$AppDatabase db) =>
      db.users.createAlias('pengumuman__dibuat_oleh__users__id');

  $$UsersTableProcessedTableManager? get dibuatOleh {
    final $_column = $_itemColumn<int>('dibuat_oleh');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dibuatOlehTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PengumumanTableFilterComposer
    extends Composer<_$AppDatabase, $PengumumanTable> {
  $$PengumumanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isi => $composableBuilder(
    column: $table.isi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalMulai => $composableBuilder(
    column: $table.tanggalMulai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalSelesai => $composableBuilder(
    column: $table.tanggalSelesai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get dibuatOleh {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dibuatOleh,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PengumumanTableOrderingComposer
    extends Composer<_$AppDatabase, $PengumumanTable> {
  $$PengumumanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isi => $composableBuilder(
    column: $table.isi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalMulai => $composableBuilder(
    column: $table.tanggalMulai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalSelesai => $composableBuilder(
    column: $table.tanggalSelesai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get dibuatOleh {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dibuatOleh,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PengumumanTableAnnotationComposer
    extends Composer<_$AppDatabase, $PengumumanTable> {
  $$PengumumanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<String> get isi =>
      $composableBuilder(column: $table.isi, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggalMulai => $composableBuilder(
    column: $table.tanggalMulai,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggalSelesai => $composableBuilder(
    column: $table.tanggalSelesai,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$UsersTableAnnotationComposer get dibuatOleh {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dibuatOleh,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PengumumanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PengumumanTable,
          PengumumanRow,
          $$PengumumanTableFilterComposer,
          $$PengumumanTableOrderingComposer,
          $$PengumumanTableAnnotationComposer,
          $$PengumumanTableCreateCompanionBuilder,
          $$PengumumanTableUpdateCompanionBuilder,
          (PengumumanRow, $$PengumumanTableReferences),
          PengumumanRow,
          PrefetchHooks Function({bool dibuatOleh})
        > {
  $$PengumumanTableTableManager(_$AppDatabase db, $PengumumanTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PengumumanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PengumumanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PengumumanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<String> isi = const Value.absent(),
                Value<String> kategori = const Value.absent(),
                Value<DateTime?> tanggalMulai = const Value.absent(),
                Value<DateTime?> tanggalSelesai = const Value.absent(),
                Value<int?> dibuatOleh = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => PengumumanCompanion(
                id: id,
                judul: judul,
                isi: isi,
                kategori: kategori,
                tanggalMulai: tanggalMulai,
                tanggalSelesai: tanggalSelesai,
                dibuatOleh: dibuatOleh,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String judul,
                required String isi,
                Value<String> kategori = const Value.absent(),
                Value<DateTime?> tanggalMulai = const Value.absent(),
                Value<DateTime?> tanggalSelesai = const Value.absent(),
                Value<int?> dibuatOleh = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => PengumumanCompanion.insert(
                id: id,
                judul: judul,
                isi: isi,
                kategori: kategori,
                tanggalMulai: tanggalMulai,
                tanggalSelesai: tanggalSelesai,
                dibuatOleh: dibuatOleh,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PengumumanTable, PengumumanRow>(table),
                  $$PengumumanTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dibuatOleh = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dibuatOleh) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.dibuatOleh,
                        referencedTable: $$PengumumanTableReferences
                            ._dibuatOlehTable(db),
                        referencedColumn: $$PengumumanTableReferences
                            ._dibuatOlehTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PengumumanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PengumumanTable,
      PengumumanRow,
      $$PengumumanTableFilterComposer,
      $$PengumumanTableOrderingComposer,
      $$PengumumanTableAnnotationComposer,
      $$PengumumanTableCreateCompanionBuilder,
      $$PengumumanTableUpdateCompanionBuilder,
      (PengumumanRow, $$PengumumanTableReferences),
      PengumumanRow,
      PrefetchHooks Function({bool dibuatOleh})
    >;
typedef $$AgendaAkademikTableCreateCompanionBuilder =
    AgendaAkademikCompanion Function({
      Value<int> id,
      required String judul,
      Value<String> jenis,
      required DateTime tanggalMulai,
      Value<DateTime?> tanggalSelesai,
      Value<int> pengingatMenit,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$AgendaAkademikTableUpdateCompanionBuilder =
    AgendaAkademikCompanion Function({
      Value<int> id,
      Value<String> judul,
      Value<String> jenis,
      Value<DateTime> tanggalMulai,
      Value<DateTime?> tanggalSelesai,
      Value<int> pengingatMenit,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

class $$AgendaAkademikTableFilterComposer
    extends Composer<_$AppDatabase, $AgendaAkademikTable> {
  $$AgendaAkademikTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalMulai => $composableBuilder(
    column: $table.tanggalMulai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalSelesai => $composableBuilder(
    column: $table.tanggalSelesai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pengingatMenit => $composableBuilder(
    column: $table.pengingatMenit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AgendaAkademikTableOrderingComposer
    extends Composer<_$AppDatabase, $AgendaAkademikTable> {
  $$AgendaAkademikTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalMulai => $composableBuilder(
    column: $table.tanggalMulai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalSelesai => $composableBuilder(
    column: $table.tanggalSelesai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pengingatMenit => $composableBuilder(
    column: $table.pengingatMenit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AgendaAkademikTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgendaAkademikTable> {
  $$AgendaAkademikTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggalMulai => $composableBuilder(
    column: $table.tanggalMulai,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggalSelesai => $composableBuilder(
    column: $table.tanggalSelesai,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pengingatMenit => $composableBuilder(
    column: $table.pengingatMenit,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);
}

class $$AgendaAkademikTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AgendaAkademikTable,
          AgendaAkademikRow,
          $$AgendaAkademikTableFilterComposer,
          $$AgendaAkademikTableOrderingComposer,
          $$AgendaAkademikTableAnnotationComposer,
          $$AgendaAkademikTableCreateCompanionBuilder,
          $$AgendaAkademikTableUpdateCompanionBuilder,
          (
            AgendaAkademikRow,
            BaseReferences<
              _$AppDatabase,
              $AgendaAkademikTable,
              AgendaAkademikRow
            >,
          ),
          AgendaAkademikRow,
          PrefetchHooks Function()
        > {
  $$AgendaAkademikTableTableManager(
    _$AppDatabase db,
    $AgendaAkademikTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgendaAkademikTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgendaAkademikTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgendaAkademikTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<String> jenis = const Value.absent(),
                Value<DateTime> tanggalMulai = const Value.absent(),
                Value<DateTime?> tanggalSelesai = const Value.absent(),
                Value<int> pengingatMenit = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => AgendaAkademikCompanion(
                id: id,
                judul: judul,
                jenis: jenis,
                tanggalMulai: tanggalMulai,
                tanggalSelesai: tanggalSelesai,
                pengingatMenit: pengingatMenit,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String judul,
                Value<String> jenis = const Value.absent(),
                required DateTime tanggalMulai,
                Value<DateTime?> tanggalSelesai = const Value.absent(),
                Value<int> pengingatMenit = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => AgendaAkademikCompanion.insert(
                id: id,
                judul: judul,
                jenis: jenis,
                tanggalMulai: tanggalMulai,
                tanggalSelesai: tanggalSelesai,
                pengingatMenit: pengingatMenit,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AgendaAkademikTable, AgendaAkademikRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AgendaAkademikTable,
                    AgendaAkademikRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AgendaAkademikTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AgendaAkademikTable,
      AgendaAkademikRow,
      $$AgendaAkademikTableFilterComposer,
      $$AgendaAkademikTableOrderingComposer,
      $$AgendaAkademikTableAnnotationComposer,
      $$AgendaAkademikTableCreateCompanionBuilder,
      $$AgendaAkademikTableUpdateCompanionBuilder,
      (
        AgendaAkademikRow,
        BaseReferences<_$AppDatabase, $AgendaAkademikTable, AgendaAkademikRow>,
      ),
      AgendaAkademikRow,
      PrefetchHooks Function()
    >;
typedef $$JadwalUjianTableCreateCompanionBuilder =
    JadwalUjianCompanion Function({
      Value<int> id,
      required int kelasId,
      required String jenis,
      required DateTime tanggal,
      required String jamMulai,
      required String jamSelesai,
      Value<String> ruang,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$JadwalUjianTableUpdateCompanionBuilder =
    JadwalUjianCompanion Function({
      Value<int> id,
      Value<int> kelasId,
      Value<String> jenis,
      Value<DateTime> tanggal,
      Value<String> jamMulai,
      Value<String> jamSelesai,
      Value<String> ruang,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$JadwalUjianTableReferences
    extends BaseReferences<_$AppDatabase, $JadwalUjianTable, JadwalUjianRow> {
  $$JadwalUjianTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KelasTable _kelasIdTable(_$AppDatabase db) =>
      db.kelas.createAlias('jadwal_ujian__kelas_id__kelas__id');

  $$KelasTableProcessedTableManager get kelasId {
    final $_column = $_itemColumn<int>('kelas_id')!;

    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kelasIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JadwalUjianTableFilterComposer
    extends Composer<_$AppDatabase, $JadwalUjianTable> {
  $$JadwalUjianTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jamMulai => $composableBuilder(
    column: $table.jamMulai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jamSelesai => $composableBuilder(
    column: $table.jamSelesai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruang => $composableBuilder(
    column: $table.ruang,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$KelasTableFilterComposer get kelasId {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JadwalUjianTableOrderingComposer
    extends Composer<_$AppDatabase, $JadwalUjianTable> {
  $$JadwalUjianTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jamMulai => $composableBuilder(
    column: $table.jamMulai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jamSelesai => $composableBuilder(
    column: $table.jamSelesai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruang => $composableBuilder(
    column: $table.ruang,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$KelasTableOrderingComposer get kelasId {
    final $$KelasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableOrderingComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JadwalUjianTableAnnotationComposer
    extends Composer<_$AppDatabase, $JadwalUjianTable> {
  $$JadwalUjianTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<String> get jamMulai =>
      $composableBuilder(column: $table.jamMulai, builder: (column) => column);

  GeneratedColumn<String> get jamSelesai => $composableBuilder(
    column: $table.jamSelesai,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruang =>
      $composableBuilder(column: $table.ruang, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$KelasTableAnnotationComposer get kelasId {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JadwalUjianTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JadwalUjianTable,
          JadwalUjianRow,
          $$JadwalUjianTableFilterComposer,
          $$JadwalUjianTableOrderingComposer,
          $$JadwalUjianTableAnnotationComposer,
          $$JadwalUjianTableCreateCompanionBuilder,
          $$JadwalUjianTableUpdateCompanionBuilder,
          (JadwalUjianRow, $$JadwalUjianTableReferences),
          JadwalUjianRow,
          PrefetchHooks Function({bool kelasId})
        > {
  $$JadwalUjianTableTableManager(_$AppDatabase db, $JadwalUjianTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JadwalUjianTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JadwalUjianTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JadwalUjianTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> kelasId = const Value.absent(),
                Value<String> jenis = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<String> jamMulai = const Value.absent(),
                Value<String> jamSelesai = const Value.absent(),
                Value<String> ruang = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => JadwalUjianCompanion(
                id: id,
                kelasId: kelasId,
                jenis: jenis,
                tanggal: tanggal,
                jamMulai: jamMulai,
                jamSelesai: jamSelesai,
                ruang: ruang,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int kelasId,
                required String jenis,
                required DateTime tanggal,
                required String jamMulai,
                required String jamSelesai,
                Value<String> ruang = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => JadwalUjianCompanion.insert(
                id: id,
                kelasId: kelasId,
                jenis: jenis,
                tanggal: tanggal,
                jamMulai: jamMulai,
                jamSelesai: jamSelesai,
                ruang: ruang,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JadwalUjianTable, JadwalUjianRow>(table),
                  $$JadwalUjianTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({kelasId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (kelasId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.kelasId,
                        referencedTable: $$JadwalUjianTableReferences
                            ._kelasIdTable(db),
                        referencedColumn: $$JadwalUjianTableReferences
                            ._kelasIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JadwalUjianTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JadwalUjianTable,
      JadwalUjianRow,
      $$JadwalUjianTableFilterComposer,
      $$JadwalUjianTableOrderingComposer,
      $$JadwalUjianTableAnnotationComposer,
      $$JadwalUjianTableCreateCompanionBuilder,
      $$JadwalUjianTableUpdateCompanionBuilder,
      (JadwalUjianRow, $$JadwalUjianTableReferences),
      JadwalUjianRow,
      PrefetchHooks Function({bool kelasId})
    >;
typedef $$PrestasiTableCreateCompanionBuilder = PrestasiCompanion Function({
  Value<int> id,
  required int mahasiswaId,
  required String judul,
  Value<String> kategori,
  Value<String> tingkat,
  Value<DateTime?> tanggal,
  Value<String> deskripsi,
  Value<String?> lampiranPath,
  required DateTime updatedAt,
  required String deviceId,
});
typedef $$PrestasiTableUpdateCompanionBuilder = PrestasiCompanion Function({
  Value<int> id,
  Value<int> mahasiswaId,
  Value<String> judul,
  Value<String> kategori,
  Value<String> tingkat,
  Value<DateTime?> tanggal,
  Value<String> deskripsi,
  Value<String?> lampiranPath,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
});

final class $$PrestasiTableReferences
    extends BaseReferences<_$AppDatabase, $PrestasiTable, PrestasiRow> {
  $$PrestasiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) =>
      db.mahasiswa.createAlias('prestasi__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrestasiTableFilterComposer
    extends Composer<_$AppDatabase, $PrestasiTable> {
  $$PrestasiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tingkat => $composableBuilder(
    column: $table.tingkat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lampiranPath => $composableBuilder(
    column: $table.lampiranPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrestasiTableOrderingComposer
    extends Composer<_$AppDatabase, $PrestasiTable> {
  $$PrestasiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tingkat => $composableBuilder(
    column: $table.tingkat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lampiranPath => $composableBuilder(
    column: $table.lampiranPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrestasiTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrestasiTable> {
  $$PrestasiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<String> get tingkat =>
      $composableBuilder(column: $table.tingkat, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<String> get deskripsi =>
      $composableBuilder(column: $table.deskripsi, builder: (column) => column);

  GeneratedColumn<String> get lampiranPath => $composableBuilder(
    column: $table.lampiranPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrestasiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrestasiTable,
          PrestasiRow,
          $$PrestasiTableFilterComposer,
          $$PrestasiTableOrderingComposer,
          $$PrestasiTableAnnotationComposer,
          $$PrestasiTableCreateCompanionBuilder,
          $$PrestasiTableUpdateCompanionBuilder,
          (PrestasiRow, $$PrestasiTableReferences),
          PrestasiRow,
          PrefetchHooks Function({bool mahasiswaId})
        > {
  $$PrestasiTableTableManager(_$AppDatabase db, $PrestasiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrestasiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrestasiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrestasiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<String> kategori = const Value.absent(),
                Value<String> tingkat = const Value.absent(),
                Value<DateTime?> tanggal = const Value.absent(),
                Value<String> deskripsi = const Value.absent(),
                Value<String?> lampiranPath = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => PrestasiCompanion(
                id: id,
                mahasiswaId: mahasiswaId,
                judul: judul,
                kategori: kategori,
                tingkat: tingkat,
                tanggal: tanggal,
                deskripsi: deskripsi,
                lampiranPath: lampiranPath,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mahasiswaId,
                required String judul,
                Value<String> kategori = const Value.absent(),
                Value<String> tingkat = const Value.absent(),
                Value<DateTime?> tanggal = const Value.absent(),
                Value<String> deskripsi = const Value.absent(),
                Value<String?> lampiranPath = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => PrestasiCompanion.insert(
                id: id,
                mahasiswaId: mahasiswaId,
                judul: judul,
                kategori: kategori,
                tingkat: tingkat,
                tanggal: tanggal,
                deskripsi: deskripsi,
                lampiranPath: lampiranPath,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrestasiTable, PrestasiRow>(table),
                  $$PrestasiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mahasiswaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mahasiswaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mahasiswaId,
                        referencedTable: $$PrestasiTableReferences
                            ._mahasiswaIdTable(db),
                        referencedColumn: $$PrestasiTableReferences
                            ._mahasiswaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrestasiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrestasiTable,
      PrestasiRow,
      $$PrestasiTableFilterComposer,
      $$PrestasiTableOrderingComposer,
      $$PrestasiTableAnnotationComposer,
      $$PrestasiTableCreateCompanionBuilder,
      $$PrestasiTableUpdateCompanionBuilder,
      (PrestasiRow, $$PrestasiTableReferences),
      PrestasiRow,
      PrefetchHooks Function({bool mahasiswaId})
    >;
typedef $$EdomPeriodeTableCreateCompanionBuilder =
    EdomPeriodeCompanion Function({
      Value<int> id,
      required int taId,
      Value<DateTime?> dibuka,
      Value<DateTime?> ditutup,
      Value<bool> isAktif,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$EdomPeriodeTableUpdateCompanionBuilder =
    EdomPeriodeCompanion Function({
      Value<int> id,
      Value<int> taId,
      Value<DateTime?> dibuka,
      Value<DateTime?> ditutup,
      Value<bool> isAktif,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$EdomPeriodeTableReferences
    extends BaseReferences<_$AppDatabase, $EdomPeriodeTable, EdomPeriodeRow> {
  $$EdomPeriodeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TahunAjaranTable _taIdTable(_$AppDatabase db) =>
      db.tahunAjaran.createAlias('edom_periode__ta_id__tahun_ajaran__id');

  $$TahunAjaranTableProcessedTableManager get taId {
    final $_column = $_itemColumn<int>('ta_id')!;

    final manager = $$TahunAjaranTableTableManager(
      $_db,
      $_db.tahunAjaran,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EdomPartisipasiTable, List<EdomPartisipasiRow>>
  _edomPartisipasiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomPartisipasi,
    aliasName: 'edom_periode__id__edom_partisipasi__periode_id',
  );

  $$EdomPartisipasiTableProcessedTableManager get edomPartisipasiRefs {
    final manager = $$EdomPartisipasiTableTableManager(
      $_db,
      $_db.edomPartisipasi,
    ).filter((f) => f.periodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _edomPartisipasiRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EdomJawabanTable, List<EdomJawabanRow>>
  _edomJawabanRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomJawaban,
    aliasName: 'edom_periode__id__edom_jawaban__periode_id',
  );

  $$EdomJawabanTableProcessedTableManager get edomJawabanRefs {
    final manager = $$EdomJawabanTableTableManager(
      $_db,
      $_db.edomJawaban,
    ).filter((f) => f.periodeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_edomJawabanRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EdomPeriodeTableFilterComposer
    extends Composer<_$AppDatabase, $EdomPeriodeTable> {
  $$EdomPeriodeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuka => $composableBuilder(
    column: $table.dibuka,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ditutup => $composableBuilder(
    column: $table.ditutup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAktif => $composableBuilder(
    column: $table.isAktif,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$TahunAjaranTableFilterComposer get taId {
    final $$TahunAjaranTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableFilterComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> edomPartisipasiRefs(
    Expression<bool> Function($$EdomPartisipasiTableFilterComposer f) f,
  ) {
    final $$EdomPartisipasiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPartisipasi,
      getReferencedColumn: (t) => t.periodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPartisipasiTableFilterComposer(
            $db: $db,
            $table: $db.edomPartisipasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> edomJawabanRefs(
    Expression<bool> Function($$EdomJawabanTableFilterComposer f) f,
  ) {
    final $$EdomJawabanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.periodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableFilterComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EdomPeriodeTableOrderingComposer
    extends Composer<_$AppDatabase, $EdomPeriodeTable> {
  $$EdomPeriodeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuka => $composableBuilder(
    column: $table.dibuka,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ditutup => $composableBuilder(
    column: $table.ditutup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAktif => $composableBuilder(
    column: $table.isAktif,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$TahunAjaranTableOrderingComposer get taId {
    final $$TahunAjaranTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableOrderingComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomPeriodeTableAnnotationComposer
    extends Composer<_$AppDatabase, $EdomPeriodeTable> {
  $$EdomPeriodeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dibuka =>
      $composableBuilder(column: $table.dibuka, builder: (column) => column);

  GeneratedColumn<DateTime> get ditutup =>
      $composableBuilder(column: $table.ditutup, builder: (column) => column);

  GeneratedColumn<bool> get isAktif =>
      $composableBuilder(column: $table.isAktif, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$TahunAjaranTableAnnotationComposer get taId {
    final $$TahunAjaranTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taId,
      referencedTable: $db.tahunAjaran,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TahunAjaranTableAnnotationComposer(
            $db: $db,
            $table: $db.tahunAjaran,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> edomPartisipasiRefs<T extends Object>(
    Expression<T> Function($$EdomPartisipasiTableAnnotationComposer a) f,
  ) {
    final $$EdomPartisipasiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomPartisipasi,
      getReferencedColumn: (t) => t.periodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPartisipasiTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPartisipasi,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> edomJawabanRefs<T extends Object>(
    Expression<T> Function($$EdomJawabanTableAnnotationComposer a) f,
  ) {
    final $$EdomJawabanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.periodeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableAnnotationComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EdomPeriodeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EdomPeriodeTable,
          EdomPeriodeRow,
          $$EdomPeriodeTableFilterComposer,
          $$EdomPeriodeTableOrderingComposer,
          $$EdomPeriodeTableAnnotationComposer,
          $$EdomPeriodeTableCreateCompanionBuilder,
          $$EdomPeriodeTableUpdateCompanionBuilder,
          (EdomPeriodeRow, $$EdomPeriodeTableReferences),
          EdomPeriodeRow,
          PrefetchHooks Function({
            bool taId,
            bool edomPartisipasiRefs,
            bool edomJawabanRefs,
          })
        > {
  $$EdomPeriodeTableTableManager(_$AppDatabase db, $EdomPeriodeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EdomPeriodeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EdomPeriodeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EdomPeriodeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> taId = const Value.absent(),
                Value<DateTime?> dibuka = const Value.absent(),
                Value<DateTime?> ditutup = const Value.absent(),
                Value<bool> isAktif = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => EdomPeriodeCompanion(
                id: id,
                taId: taId,
                dibuka: dibuka,
                ditutup: ditutup,
                isAktif: isAktif,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int taId,
                Value<DateTime?> dibuka = const Value.absent(),
                Value<DateTime?> ditutup = const Value.absent(),
                Value<bool> isAktif = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => EdomPeriodeCompanion.insert(
                id: id,
                taId: taId,
                dibuka: dibuka,
                ditutup: ditutup,
                isAktif: isAktif,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EdomPeriodeTable, EdomPeriodeRow>(table),
                  $$EdomPeriodeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                taId = false,
                edomPartisipasiRefs = false,
                edomJawabanRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (edomPartisipasiRefs) db.edomPartisipasi,
                    if (edomJawabanRefs) db.edomJawaban,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (taId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.taId,
                            referencedTable: $$EdomPeriodeTableReferences
                                ._taIdTable(db),
                            referencedColumn: $$EdomPeriodeTableReferences
                                ._taIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (edomPartisipasiRefs)
                        await $_getPrefetchedData<
                          EdomPeriodeRow,
                          $EdomPeriodeTable,
                          EdomPartisipasiRow
                        >(
                          currentTable: table,
                          referencedTable: $$EdomPeriodeTableReferences
                              ._edomPartisipasiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EdomPeriodeTableReferences(
                                db,
                                table,
                                p0,
                              ).edomPartisipasiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.periodeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (edomJawabanRefs)
                        await $_getPrefetchedData<
                          EdomPeriodeRow,
                          $EdomPeriodeTable,
                          EdomJawabanRow
                        >(
                          currentTable: table,
                          referencedTable: $$EdomPeriodeTableReferences
                              ._edomJawabanRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EdomPeriodeTableReferences(
                                db,
                                table,
                                p0,
                              ).edomJawabanRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.periodeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EdomPeriodeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EdomPeriodeTable,
      EdomPeriodeRow,
      $$EdomPeriodeTableFilterComposer,
      $$EdomPeriodeTableOrderingComposer,
      $$EdomPeriodeTableAnnotationComposer,
      $$EdomPeriodeTableCreateCompanionBuilder,
      $$EdomPeriodeTableUpdateCompanionBuilder,
      (EdomPeriodeRow, $$EdomPeriodeTableReferences),
      EdomPeriodeRow,
      PrefetchHooks Function({
        bool taId,
        bool edomPartisipasiRefs,
        bool edomJawabanRefs,
      })
    >;
typedef $$EdomPertanyaanTableCreateCompanionBuilder =
    EdomPertanyaanCompanion Function({
      Value<int> id,
      required String aspek,
      required String teks,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$EdomPertanyaanTableUpdateCompanionBuilder =
    EdomPertanyaanCompanion Function({
      Value<int> id,
      Value<String> aspek,
      Value<String> teks,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$EdomPertanyaanTableReferences
    extends
        BaseReferences<_$AppDatabase, $EdomPertanyaanTable, EdomPertanyaanRow> {
  $$EdomPertanyaanTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$EdomJawabanTable, List<EdomJawabanRow>>
  _edomJawabanRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.edomJawaban,
    aliasName: 'edom_pertanyaan__id__edom_jawaban__pertanyaan_id',
  );

  $$EdomJawabanTableProcessedTableManager get edomJawabanRefs {
    final manager = $$EdomJawabanTableTableManager(
      $_db,
      $_db.edomJawaban,
    ).filter((f) => f.pertanyaanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_edomJawabanRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EdomPertanyaanTableFilterComposer
    extends Composer<_$AppDatabase, $EdomPertanyaanTable> {
  $$EdomPertanyaanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aspek => $composableBuilder(
    column: $table.aspek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teks => $composableBuilder(
    column: $table.teks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> edomJawabanRefs(
    Expression<bool> Function($$EdomJawabanTableFilterComposer f) f,
  ) {
    final $$EdomJawabanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.pertanyaanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableFilterComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EdomPertanyaanTableOrderingComposer
    extends Composer<_$AppDatabase, $EdomPertanyaanTable> {
  $$EdomPertanyaanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aspek => $composableBuilder(
    column: $table.aspek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teks => $composableBuilder(
    column: $table.teks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EdomPertanyaanTableAnnotationComposer
    extends Composer<_$AppDatabase, $EdomPertanyaanTable> {
  $$EdomPertanyaanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get aspek =>
      $composableBuilder(column: $table.aspek, builder: (column) => column);

  GeneratedColumn<String> get teks =>
      $composableBuilder(column: $table.teks, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  Expression<T> edomJawabanRefs<T extends Object>(
    Expression<T> Function($$EdomJawabanTableAnnotationComposer a) f,
  ) {
    final $$EdomJawabanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.edomJawaban,
      getReferencedColumn: (t) => t.pertanyaanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomJawabanTableAnnotationComposer(
            $db: $db,
            $table: $db.edomJawaban,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EdomPertanyaanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EdomPertanyaanTable,
          EdomPertanyaanRow,
          $$EdomPertanyaanTableFilterComposer,
          $$EdomPertanyaanTableOrderingComposer,
          $$EdomPertanyaanTableAnnotationComposer,
          $$EdomPertanyaanTableCreateCompanionBuilder,
          $$EdomPertanyaanTableUpdateCompanionBuilder,
          (EdomPertanyaanRow, $$EdomPertanyaanTableReferences),
          EdomPertanyaanRow,
          PrefetchHooks Function({bool edomJawabanRefs})
        > {
  $$EdomPertanyaanTableTableManager(
    _$AppDatabase db,
    $EdomPertanyaanTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EdomPertanyaanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EdomPertanyaanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EdomPertanyaanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> aspek = const Value.absent(),
                Value<String> teks = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => EdomPertanyaanCompanion(
                id: id,
                aspek: aspek,
                teks: teks,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String aspek,
                required String teks,
                required DateTime updatedAt,
                required String deviceId,
              }) => EdomPertanyaanCompanion.insert(
                id: id,
                aspek: aspek,
                teks: teks,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EdomPertanyaanTable, EdomPertanyaanRow>(table),
                  $$EdomPertanyaanTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({edomJawabanRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (edomJawabanRefs) db.edomJawaban],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (edomJawabanRefs)
                    await $_getPrefetchedData<
                      EdomPertanyaanRow,
                      $EdomPertanyaanTable,
                      EdomJawabanRow
                    >(
                      currentTable: table,
                      referencedTable: $$EdomPertanyaanTableReferences
                          ._edomJawabanRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EdomPertanyaanTableReferences(
                            db,
                            table,
                            p0,
                          ).edomJawabanRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.pertanyaanId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EdomPertanyaanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EdomPertanyaanTable,
      EdomPertanyaanRow,
      $$EdomPertanyaanTableFilterComposer,
      $$EdomPertanyaanTableOrderingComposer,
      $$EdomPertanyaanTableAnnotationComposer,
      $$EdomPertanyaanTableCreateCompanionBuilder,
      $$EdomPertanyaanTableUpdateCompanionBuilder,
      (EdomPertanyaanRow, $$EdomPertanyaanTableReferences),
      EdomPertanyaanRow,
      PrefetchHooks Function({bool edomJawabanRefs})
    >;
typedef $$EdomPartisipasiTableCreateCompanionBuilder =
    EdomPartisipasiCompanion Function({
      Value<int> id,
      required int periodeId,
      required int mahasiswaId,
      required int kelasId,
      required DateTime waktu,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$EdomPartisipasiTableUpdateCompanionBuilder =
    EdomPartisipasiCompanion Function({
      Value<int> id,
      Value<int> periodeId,
      Value<int> mahasiswaId,
      Value<int> kelasId,
      Value<DateTime> waktu,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$EdomPartisipasiTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EdomPartisipasiTable,
          EdomPartisipasiRow
        > {
  $$EdomPartisipasiTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EdomPeriodeTable _periodeIdTable(_$AppDatabase db) => db.edomPeriode
      .createAlias('edom_partisipasi__periode_id__edom_periode__id');

  $$EdomPeriodeTableProcessedTableManager get periodeId {
    final $_column = $_itemColumn<int>('periode_id')!;

    final manager = $$EdomPeriodeTableTableManager(
      $_db,
      $_db.edomPeriode,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_periodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) =>
      db.mahasiswa.createAlias('edom_partisipasi__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KelasTable _kelasIdTable(_$AppDatabase db) =>
      db.kelas.createAlias('edom_partisipasi__kelas_id__kelas__id');

  $$KelasTableProcessedTableManager get kelasId {
    final $_column = $_itemColumn<int>('kelas_id')!;

    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kelasIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EdomPartisipasiTableFilterComposer
    extends Composer<_$AppDatabase, $EdomPartisipasiTable> {
  $$EdomPartisipasiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$EdomPeriodeTableFilterComposer get periodeId {
    final $$EdomPeriodeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodeId,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableFilterComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableFilterComposer get kelasId {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomPartisipasiTableOrderingComposer
    extends Composer<_$AppDatabase, $EdomPartisipasiTable> {
  $$EdomPartisipasiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$EdomPeriodeTableOrderingComposer get periodeId {
    final $$EdomPeriodeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodeId,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableOrderingComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableOrderingComposer get kelasId {
    final $$KelasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableOrderingComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomPartisipasiTableAnnotationComposer
    extends Composer<_$AppDatabase, $EdomPartisipasiTable> {
  $$EdomPartisipasiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$EdomPeriodeTableAnnotationComposer get periodeId {
    final $$EdomPeriodeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodeId,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableAnnotationComposer get kelasId {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomPartisipasiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EdomPartisipasiTable,
          EdomPartisipasiRow,
          $$EdomPartisipasiTableFilterComposer,
          $$EdomPartisipasiTableOrderingComposer,
          $$EdomPartisipasiTableAnnotationComposer,
          $$EdomPartisipasiTableCreateCompanionBuilder,
          $$EdomPartisipasiTableUpdateCompanionBuilder,
          (EdomPartisipasiRow, $$EdomPartisipasiTableReferences),
          EdomPartisipasiRow,
          PrefetchHooks Function({
            bool periodeId,
            bool mahasiswaId,
            bool kelasId,
          })
        > {
  $$EdomPartisipasiTableTableManager(
    _$AppDatabase db,
    $EdomPartisipasiTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EdomPartisipasiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EdomPartisipasiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EdomPartisipasiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> periodeId = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<int> kelasId = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => EdomPartisipasiCompanion(
                id: id,
                periodeId: periodeId,
                mahasiswaId: mahasiswaId,
                kelasId: kelasId,
                waktu: waktu,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int periodeId,
                required int mahasiswaId,
                required int kelasId,
                required DateTime waktu,
                required DateTime updatedAt,
                required String deviceId,
              }) => EdomPartisipasiCompanion.insert(
                id: id,
                periodeId: periodeId,
                mahasiswaId: mahasiswaId,
                kelasId: kelasId,
                waktu: waktu,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EdomPartisipasiTable, EdomPartisipasiRow>(table),
                  $$EdomPartisipasiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({periodeId = false, mahasiswaId = false, kelasId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (periodeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.periodeId,
                            referencedTable: $$EdomPartisipasiTableReferences
                                ._periodeIdTable(db),
                            referencedColumn: $$EdomPartisipasiTableReferences
                                ._periodeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (mahasiswaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mahasiswaId,
                            referencedTable: $$EdomPartisipasiTableReferences
                                ._mahasiswaIdTable(db),
                            referencedColumn: $$EdomPartisipasiTableReferences
                                ._mahasiswaIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (kelasId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.kelasId,
                            referencedTable: $$EdomPartisipasiTableReferences
                                ._kelasIdTable(db),
                            referencedColumn: $$EdomPartisipasiTableReferences
                                ._kelasIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EdomPartisipasiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EdomPartisipasiTable,
      EdomPartisipasiRow,
      $$EdomPartisipasiTableFilterComposer,
      $$EdomPartisipasiTableOrderingComposer,
      $$EdomPartisipasiTableAnnotationComposer,
      $$EdomPartisipasiTableCreateCompanionBuilder,
      $$EdomPartisipasiTableUpdateCompanionBuilder,
      (EdomPartisipasiRow, $$EdomPartisipasiTableReferences),
      EdomPartisipasiRow,
      PrefetchHooks Function({bool periodeId, bool mahasiswaId, bool kelasId})
    >;
typedef $$EdomJawabanTableCreateCompanionBuilder =
    EdomJawabanCompanion Function({
      Value<int> id,
      required int periodeId,
      required int dosenId,
      required int kelasId,
      required int pertanyaanId,
      required int skor,
      Value<String> komentar,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$EdomJawabanTableUpdateCompanionBuilder =
    EdomJawabanCompanion Function({
      Value<int> id,
      Value<int> periodeId,
      Value<int> dosenId,
      Value<int> kelasId,
      Value<int> pertanyaanId,
      Value<int> skor,
      Value<String> komentar,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$EdomJawabanTableReferences
    extends BaseReferences<_$AppDatabase, $EdomJawabanTable, EdomJawabanRow> {
  $$EdomJawabanTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EdomPeriodeTable _periodeIdTable(_$AppDatabase db) =>
      db.edomPeriode.createAlias('edom_jawaban__periode_id__edom_periode__id');

  $$EdomPeriodeTableProcessedTableManager get periodeId {
    final $_column = $_itemColumn<int>('periode_id')!;

    final manager = $$EdomPeriodeTableTableManager(
      $_db,
      $_db.edomPeriode,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_periodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DosensTable _dosenIdTable(_$AppDatabase db) =>
      db.dosens.createAlias('edom_jawaban__dosen_id__dosens__id');

  $$DosensTableProcessedTableManager get dosenId {
    final $_column = $_itemColumn<int>('dosen_id')!;

    final manager = $$DosensTableTableManager(
      $_db,
      $_db.dosens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dosenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KelasTable _kelasIdTable(_$AppDatabase db) =>
      db.kelas.createAlias('edom_jawaban__kelas_id__kelas__id');

  $$KelasTableProcessedTableManager get kelasId {
    final $_column = $_itemColumn<int>('kelas_id')!;

    final manager = $$KelasTableTableManager(
      $_db,
      $_db.kelas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kelasIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EdomPertanyaanTable _pertanyaanIdTable(_$AppDatabase db) => db
      .edomPertanyaan
      .createAlias('edom_jawaban__pertanyaan_id__edom_pertanyaan__id');

  $$EdomPertanyaanTableProcessedTableManager get pertanyaanId {
    final $_column = $_itemColumn<int>('pertanyaan_id')!;

    final manager = $$EdomPertanyaanTableTableManager(
      $_db,
      $_db.edomPertanyaan,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pertanyaanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EdomJawabanTableFilterComposer
    extends Composer<_$AppDatabase, $EdomJawabanTable> {
  $$EdomJawabanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skor => $composableBuilder(
    column: $table.skor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get komentar => $composableBuilder(
    column: $table.komentar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$EdomPeriodeTableFilterComposer get periodeId {
    final $$EdomPeriodeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodeId,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableFilterComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableFilterComposer get dosenId {
    final $$DosensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableFilterComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableFilterComposer get kelasId {
    final $$KelasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableFilterComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EdomPertanyaanTableFilterComposer get pertanyaanId {
    final $$EdomPertanyaanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pertanyaanId,
      referencedTable: $db.edomPertanyaan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPertanyaanTableFilterComposer(
            $db: $db,
            $table: $db.edomPertanyaan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomJawabanTableOrderingComposer
    extends Composer<_$AppDatabase, $EdomJawabanTable> {
  $$EdomJawabanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skor => $composableBuilder(
    column: $table.skor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get komentar => $composableBuilder(
    column: $table.komentar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$EdomPeriodeTableOrderingComposer get periodeId {
    final $$EdomPeriodeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodeId,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableOrderingComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableOrderingComposer get dosenId {
    final $$DosensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableOrderingComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableOrderingComposer get kelasId {
    final $$KelasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableOrderingComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EdomPertanyaanTableOrderingComposer get pertanyaanId {
    final $$EdomPertanyaanTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pertanyaanId,
      referencedTable: $db.edomPertanyaan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPertanyaanTableOrderingComposer(
            $db: $db,
            $table: $db.edomPertanyaan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomJawabanTableAnnotationComposer
    extends Composer<_$AppDatabase, $EdomJawabanTable> {
  $$EdomJawabanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get skor =>
      $composableBuilder(column: $table.skor, builder: (column) => column);

  GeneratedColumn<String> get komentar =>
      $composableBuilder(column: $table.komentar, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$EdomPeriodeTableAnnotationComposer get periodeId {
    final $$EdomPeriodeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodeId,
      referencedTable: $db.edomPeriode,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPeriodeTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPeriode,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosensTableAnnotationComposer get dosenId {
    final $$DosensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dosenId,
      referencedTable: $db.dosens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosensTableAnnotationComposer(
            $db: $db,
            $table: $db.dosens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KelasTableAnnotationComposer get kelasId {
    final $$KelasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.kelasId,
      referencedTable: $db.kelas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KelasTableAnnotationComposer(
            $db: $db,
            $table: $db.kelas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EdomPertanyaanTableAnnotationComposer get pertanyaanId {
    final $$EdomPertanyaanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pertanyaanId,
      referencedTable: $db.edomPertanyaan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EdomPertanyaanTableAnnotationComposer(
            $db: $db,
            $table: $db.edomPertanyaan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EdomJawabanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EdomJawabanTable,
          EdomJawabanRow,
          $$EdomJawabanTableFilterComposer,
          $$EdomJawabanTableOrderingComposer,
          $$EdomJawabanTableAnnotationComposer,
          $$EdomJawabanTableCreateCompanionBuilder,
          $$EdomJawabanTableUpdateCompanionBuilder,
          (EdomJawabanRow, $$EdomJawabanTableReferences),
          EdomJawabanRow,
          PrefetchHooks Function({
            bool periodeId,
            bool dosenId,
            bool kelasId,
            bool pertanyaanId,
          })
        > {
  $$EdomJawabanTableTableManager(_$AppDatabase db, $EdomJawabanTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EdomJawabanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EdomJawabanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EdomJawabanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> periodeId = const Value.absent(),
                Value<int> dosenId = const Value.absent(),
                Value<int> kelasId = const Value.absent(),
                Value<int> pertanyaanId = const Value.absent(),
                Value<int> skor = const Value.absent(),
                Value<String> komentar = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => EdomJawabanCompanion(
                id: id,
                periodeId: periodeId,
                dosenId: dosenId,
                kelasId: kelasId,
                pertanyaanId: pertanyaanId,
                skor: skor,
                komentar: komentar,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int periodeId,
                required int dosenId,
                required int kelasId,
                required int pertanyaanId,
                required int skor,
                Value<String> komentar = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
              }) => EdomJawabanCompanion.insert(
                id: id,
                periodeId: periodeId,
                dosenId: dosenId,
                kelasId: kelasId,
                pertanyaanId: pertanyaanId,
                skor: skor,
                komentar: komentar,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EdomJawabanTable, EdomJawabanRow>(table),
                  $$EdomJawabanTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                periodeId = false,
                dosenId = false,
                kelasId = false,
                pertanyaanId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (periodeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.periodeId,
                            referencedTable: $$EdomJawabanTableReferences
                                ._periodeIdTable(db),
                            referencedColumn: $$EdomJawabanTableReferences
                                ._periodeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (dosenId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.dosenId,
                            referencedTable: $$EdomJawabanTableReferences
                                ._dosenIdTable(db),
                            referencedColumn: $$EdomJawabanTableReferences
                                ._dosenIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (kelasId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.kelasId,
                            referencedTable: $$EdomJawabanTableReferences
                                ._kelasIdTable(db),
                            referencedColumn: $$EdomJawabanTableReferences
                                ._kelasIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (pertanyaanId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.pertanyaanId,
                            referencedTable: $$EdomJawabanTableReferences
                                ._pertanyaanIdTable(db),
                            referencedColumn: $$EdomJawabanTableReferences
                                ._pertanyaanIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$EdomJawabanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EdomJawabanTable,
      EdomJawabanRow,
      $$EdomJawabanTableFilterComposer,
      $$EdomJawabanTableOrderingComposer,
      $$EdomJawabanTableAnnotationComposer,
      $$EdomJawabanTableCreateCompanionBuilder,
      $$EdomJawabanTableUpdateCompanionBuilder,
      (EdomJawabanRow, $$EdomJawabanTableReferences),
      EdomJawabanRow,
      PrefetchHooks Function({
        bool periodeId,
        bool dosenId,
        bool kelasId,
        bool pertanyaanId,
      })
    >;
typedef $$DokumenArsipTableCreateCompanionBuilder =
    DokumenArsipCompanion Function({
      Value<int> id,
      required int mahasiswaId,
      required String jenis,
      required String namaBerkas,
      required String pathTerenkripsi,
      Value<int> ukuran,
      Value<int?> diunggahOleh,
      required DateTime waktu,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$DokumenArsipTableUpdateCompanionBuilder =
    DokumenArsipCompanion Function({
      Value<int> id,
      Value<int> mahasiswaId,
      Value<String> jenis,
      Value<String> namaBerkas,
      Value<String> pathTerenkripsi,
      Value<int> ukuran,
      Value<int?> diunggahOleh,
      Value<DateTime> waktu,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$DokumenArsipTableReferences
    extends BaseReferences<_$AppDatabase, $DokumenArsipTable, DokumenArsipRow> {
  $$DokumenArsipTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MahasiswaTable _mahasiswaIdTable(_$AppDatabase db) =>
      db.mahasiswa.createAlias('dokumen_arsip__mahasiswa_id__mahasiswa__id');

  $$MahasiswaTableProcessedTableManager get mahasiswaId {
    final $_column = $_itemColumn<int>('mahasiswa_id')!;

    final manager = $$MahasiswaTableTableManager(
      $_db,
      $_db.mahasiswa,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mahasiswaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _diunggahOlehTable(_$AppDatabase db) =>
      db.users.createAlias('dokumen_arsip__diunggah_oleh__users__id');

  $$UsersTableProcessedTableManager? get diunggahOleh {
    final $_column = $_itemColumn<int>('diunggah_oleh');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_diunggahOlehTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DokumenArsipTableFilterComposer
    extends Composer<_$AppDatabase, $DokumenArsipTable> {
  $$DokumenArsipTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaBerkas => $composableBuilder(
    column: $table.namaBerkas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pathTerenkripsi => $composableBuilder(
    column: $table.pathTerenkripsi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ukuran => $composableBuilder(
    column: $table.ukuran,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$MahasiswaTableFilterComposer get mahasiswaId {
    final $$MahasiswaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableFilterComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get diunggahOleh {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diunggahOleh,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DokumenArsipTableOrderingComposer
    extends Composer<_$AppDatabase, $DokumenArsipTable> {
  $$DokumenArsipTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaBerkas => $composableBuilder(
    column: $table.namaBerkas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pathTerenkripsi => $composableBuilder(
    column: $table.pathTerenkripsi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ukuran => $composableBuilder(
    column: $table.ukuran,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$MahasiswaTableOrderingComposer get mahasiswaId {
    final $$MahasiswaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableOrderingComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get diunggahOleh {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diunggahOleh,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DokumenArsipTableAnnotationComposer
    extends Composer<_$AppDatabase, $DokumenArsipTable> {
  $$DokumenArsipTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<String> get namaBerkas => $composableBuilder(
    column: $table.namaBerkas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pathTerenkripsi => $composableBuilder(
    column: $table.pathTerenkripsi,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ukuran =>
      $composableBuilder(column: $table.ukuran, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$MahasiswaTableAnnotationComposer get mahasiswaId {
    final $$MahasiswaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mahasiswaId,
      referencedTable: $db.mahasiswa,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MahasiswaTableAnnotationComposer(
            $db: $db,
            $table: $db.mahasiswa,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get diunggahOleh {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diunggahOleh,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DokumenArsipTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DokumenArsipTable,
          DokumenArsipRow,
          $$DokumenArsipTableFilterComposer,
          $$DokumenArsipTableOrderingComposer,
          $$DokumenArsipTableAnnotationComposer,
          $$DokumenArsipTableCreateCompanionBuilder,
          $$DokumenArsipTableUpdateCompanionBuilder,
          (DokumenArsipRow, $$DokumenArsipTableReferences),
          DokumenArsipRow,
          PrefetchHooks Function({bool mahasiswaId, bool diunggahOleh})
        > {
  $$DokumenArsipTableTableManager(_$AppDatabase db, $DokumenArsipTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DokumenArsipTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DokumenArsipTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DokumenArsipTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mahasiswaId = const Value.absent(),
                Value<String> jenis = const Value.absent(),
                Value<String> namaBerkas = const Value.absent(),
                Value<String> pathTerenkripsi = const Value.absent(),
                Value<int> ukuran = const Value.absent(),
                Value<int?> diunggahOleh = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => DokumenArsipCompanion(
                id: id,
                mahasiswaId: mahasiswaId,
                jenis: jenis,
                namaBerkas: namaBerkas,
                pathTerenkripsi: pathTerenkripsi,
                ukuran: ukuran,
                diunggahOleh: diunggahOleh,
                waktu: waktu,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mahasiswaId,
                required String jenis,
                required String namaBerkas,
                required String pathTerenkripsi,
                Value<int> ukuran = const Value.absent(),
                Value<int?> diunggahOleh = const Value.absent(),
                required DateTime waktu,
                required DateTime updatedAt,
                required String deviceId,
              }) => DokumenArsipCompanion.insert(
                id: id,
                mahasiswaId: mahasiswaId,
                jenis: jenis,
                namaBerkas: namaBerkas,
                pathTerenkripsi: pathTerenkripsi,
                ukuran: ukuran,
                diunggahOleh: diunggahOleh,
                waktu: waktu,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DokumenArsipTable, DokumenArsipRow>(table),
                  $$DokumenArsipTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mahasiswaId = false, diunggahOleh = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mahasiswaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mahasiswaId,
                        referencedTable: $$DokumenArsipTableReferences
                            ._mahasiswaIdTable(db),
                        referencedColumn: $$DokumenArsipTableReferences
                            ._mahasiswaIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (diunggahOleh) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.diunggahOleh,
                        referencedTable: $$DokumenArsipTableReferences
                            ._diunggahOlehTable(db),
                        referencedColumn: $$DokumenArsipTableReferences
                            ._diunggahOlehTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DokumenArsipTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DokumenArsipTable,
      DokumenArsipRow,
      $$DokumenArsipTableFilterComposer,
      $$DokumenArsipTableOrderingComposer,
      $$DokumenArsipTableAnnotationComposer,
      $$DokumenArsipTableCreateCompanionBuilder,
      $$DokumenArsipTableUpdateCompanionBuilder,
      (DokumenArsipRow, $$DokumenArsipTableReferences),
      DokumenArsipRow,
      PrefetchHooks Function({bool mahasiswaId, bool diunggahOleh})
    >;
typedef $$SavedFiltersTableCreateCompanionBuilder =
    SavedFiltersCompanion Function({
      Value<int> id,
      required String nama,
      required String kriteriaJson,
      Value<int?> userId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String deviceId,
    });
typedef $$SavedFiltersTableUpdateCompanionBuilder =
    SavedFiltersCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String> kriteriaJson,
      Value<int?> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
    });

final class $$SavedFiltersTableReferences
    extends BaseReferences<_$AppDatabase, $SavedFiltersTable, SavedFilterRow> {
  $$SavedFiltersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('saved_filters__user_id__users__id');

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SavedFiltersTableFilterComposer
    extends Composer<_$AppDatabase, $SavedFiltersTable> {
  $$SavedFiltersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kriteriaJson => $composableBuilder(
    column: $table.kriteriaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SavedFiltersTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedFiltersTable> {
  $$SavedFiltersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kriteriaJson => $composableBuilder(
    column: $table.kriteriaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SavedFiltersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedFiltersTable> {
  $$SavedFiltersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get kriteriaJson => $composableBuilder(
    column: $table.kriteriaJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SavedFiltersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedFiltersTable,
          SavedFilterRow,
          $$SavedFiltersTableFilterComposer,
          $$SavedFiltersTableOrderingComposer,
          $$SavedFiltersTableAnnotationComposer,
          $$SavedFiltersTableCreateCompanionBuilder,
          $$SavedFiltersTableUpdateCompanionBuilder,
          (SavedFilterRow, $$SavedFiltersTableReferences),
          SavedFilterRow,
          PrefetchHooks Function({bool userId})
        > {
  $$SavedFiltersTableTableManager(_$AppDatabase db, $SavedFiltersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedFiltersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedFiltersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedFiltersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String> kriteriaJson = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
              }) => SavedFiltersCompanion(
                id: id,
                nama: nama,
                kriteriaJson: kriteriaJson,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                required String kriteriaJson,
                Value<int?> userId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                required String deviceId,
              }) => SavedFiltersCompanion.insert(
                id: id,
                nama: nama,
                kriteriaJson: kriteriaJson,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deviceId: deviceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavedFiltersTable, SavedFilterRow>(table),
                  $$SavedFiltersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$SavedFiltersTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$SavedFiltersTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SavedFiltersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedFiltersTable,
      SavedFilterRow,
      $$SavedFiltersTableFilterComposer,
      $$SavedFiltersTableOrderingComposer,
      $$SavedFiltersTableAnnotationComposer,
      $$SavedFiltersTableCreateCompanionBuilder,
      $$SavedFiltersTableUpdateCompanionBuilder,
      (SavedFilterRow, $$SavedFiltersTableReferences),
      SavedFilterRow,
      PrefetchHooks Function({bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ProdiTableTableManager get prodi =>
      $$ProdiTableTableManager(_db, _db.prodi);
  $$DosensTableTableManager get dosens =>
      $$DosensTableTableManager(_db, _db.dosens);
  $$MahasiswaTableTableManager get mahasiswa =>
      $$MahasiswaTableTableManager(_db, _db.mahasiswa);
  $$TahunAjaranTableTableManager get tahunAjaran =>
      $$TahunAjaranTableTableManager(_db, _db.tahunAjaran);
  $$MataKuliahTableTableManager get mataKuliah =>
      $$MataKuliahTableTableManager(_db, _db.mataKuliah);
  $$PrasyaratMkTableTableManager get prasyaratMk =>
      $$PrasyaratMkTableTableManager(_db, _db.prasyaratMk);
  $$KelasTableTableManager get kelas =>
      $$KelasTableTableManager(_db, _db.kelas);
  $$KrsTableTableManager get krs => $$KrsTableTableManager(_db, _db.krs);
  $$NilaiTableTableManager get nilai =>
      $$NilaiTableTableManager(_db, _db.nilai);
  $$SesiPresensiTableTableManager get sesiPresensi =>
      $$SesiPresensiTableTableManager(_db, _db.sesiPresensi);
  $$PresensiTableTableManager get presensi =>
      $$PresensiTableTableManager(_db, _db.presensi);
  $$CatatanBimbinganTableTableManager get catatanBimbingan =>
      $$CatatanBimbinganTableTableManager(_db, _db.catatanBimbingan);
  $$PeringatanTableTableManager get peringatan =>
      $$PeringatanTableTableManager(_db, _db.peringatan);
  $$AuditLogTableTableManager get auditLog =>
      $$AuditLogTableTableManager(_db, _db.auditLog);
  $$SyncLogTableTableManager get syncLog =>
      $$SyncLogTableTableManager(_db, _db.syncLog);
  $$PengaturanTableTableManager get pengaturan =>
      $$PengaturanTableTableManager(_db, _db.pengaturan);
  $$PengumumanTableTableManager get pengumuman =>
      $$PengumumanTableTableManager(_db, _db.pengumuman);
  $$AgendaAkademikTableTableManager get agendaAkademik =>
      $$AgendaAkademikTableTableManager(_db, _db.agendaAkademik);
  $$JadwalUjianTableTableManager get jadwalUjian =>
      $$JadwalUjianTableTableManager(_db, _db.jadwalUjian);
  $$PrestasiTableTableManager get prestasi =>
      $$PrestasiTableTableManager(_db, _db.prestasi);
  $$EdomPeriodeTableTableManager get edomPeriode =>
      $$EdomPeriodeTableTableManager(_db, _db.edomPeriode);
  $$EdomPertanyaanTableTableManager get edomPertanyaan =>
      $$EdomPertanyaanTableTableManager(_db, _db.edomPertanyaan);
  $$EdomPartisipasiTableTableManager get edomPartisipasi =>
      $$EdomPartisipasiTableTableManager(_db, _db.edomPartisipasi);
  $$EdomJawabanTableTableManager get edomJawaban =>
      $$EdomJawabanTableTableManager(_db, _db.edomJawaban);
  $$DokumenArsipTableTableManager get dokumenArsip =>
      $$DokumenArsipTableTableManager(_db, _db.dokumenArsip);
  $$SavedFiltersTableTableManager get savedFilters =>
      $$SavedFiltersTableTableManager(_db, _db.savedFilters);
}
