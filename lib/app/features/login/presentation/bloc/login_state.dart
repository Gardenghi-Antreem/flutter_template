import 'package:equatable/equatable.dart';
import 'package:flutter_template/app/shared/core/error/failures/failures.dart';
import 'package:flutter_template/app/shared/core/form_fields/password_field.dart';
import 'package:flutter_template/app/shared/core/form_fields/username_field.dart';

enum LoginStatus { idle, loading, succeeded, failure }

class LoginState extends Equatable {
  const LoginState({
    required this.status,
    this.showPassword = false,
    this.failure,
    this.password = const PasswordField.pure(),
    this.username = const UsernameField.pure(),
  });

  final LoginStatus status;
  final bool showPassword;
  final Failure? failure;
  final PasswordField password;
  final UsernameField username;

  LoginState copyWith({
    LoginStatus? status,
    bool? showPassword,
    Failure? Function()? failureProvider,
    PasswordField? password,
    UsernameField? username,
  }) {
    return LoginState(
      status: status ?? this.status,
      showPassword: showPassword ?? this.showPassword,
      failure: failureProvider?.call(),
      password: password ?? this.password,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props =>
      [status, showPassword, failure, username, password];
}
