import 'package:equatable/equatable.dart';
import 'package:flutter_template/app/shared/domain/entities/user.dart';

class AppState extends Equatable {
  const AppState({
    this.user,
  });

  final User? user;

  AppState copyWith({
    User? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
