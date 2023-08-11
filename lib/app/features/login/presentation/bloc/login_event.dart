import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends LoginEvent {
  const UsernameChanged({required this.newUsername});

  final String newUsername;

  @override
  List<Object?> get props => [newUsername];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.newPassword});

  final String newPassword;

  @override
  List<Object?> get props => [newPassword];
}

class TogglePasswordIconPressed extends LoginEvent {
  @override
  List<Object?> get props => [];
}
