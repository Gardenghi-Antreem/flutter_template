// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credentials.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserCredentials extends UserCredentials {
  @override
  final String? id;
  @override
  final String? password;

  factory _$UserCredentials([void Function(UserCredentialsBuilder)? updates]) =>
      (new UserCredentialsBuilder()..update(updates))._build();

  _$UserCredentials._({this.id, this.password}) : super._();

  @override
  UserCredentials rebuild(void Function(UserCredentialsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserCredentialsBuilder toBuilder() =>
      new UserCredentialsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCredentials &&
        id == other.id &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserCredentials')
          ..add('id', id)
          ..add('password', password))
        .toString();
  }
}

class UserCredentialsBuilder
    implements Builder<UserCredentials, UserCredentialsBuilder> {
  _$UserCredentials? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  UserCredentialsBuilder() {
    UserCredentials._defaults(this);
  }

  UserCredentialsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCredentials other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserCredentials;
  }

  @override
  void update(void Function(UserCredentialsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserCredentials build() => _build();

  _$UserCredentials _build() {
    final _$result = _$v ?? new _$UserCredentials._(id: id, password: password);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
