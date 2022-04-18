// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class User extends _User with RealmEntity, RealmObject {
  User(
    String email,
    String name,
    String password, {
    String? cpf,
  }) {
    RealmObject.set(this, 'email', email);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'cpf', cpf);
    RealmObject.set(this, 'password', password);
  }

  User._();

  @override
  String get email => RealmObject.get<String>(this, 'email') as String;
  @override
  set email(String value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  String? get cpf => RealmObject.get<String>(this, 'cpf') as String?;
  @override
  set cpf(String? value) => RealmObject.set(this, 'cpf', value);

  @override
  String get password => RealmObject.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObject.set(this, 'password', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObject.getChanges<User>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(User._);
    return const SchemaObject(User, [
      SchemaProperty('email', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('cpf', RealmPropertyType.string, optional: true),
      SchemaProperty('password', RealmPropertyType.string),
    ]);
  }
}
