import 'package:flutter_template/app/shared/core/error/failures/failures.dart';

abstract class SplashState {}

class SplashLoading extends SplashState {}

class SplashSetupCompleted extends SplashState {
  SplashSetupCompleted({required this.showOnboarding});

  final bool showOnboarding;
}

class SplashError extends SplashState {
  SplashError(this.failure);

  final Failure failure;
}
