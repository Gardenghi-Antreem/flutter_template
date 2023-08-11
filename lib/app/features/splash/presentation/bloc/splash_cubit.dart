import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_template/app/shared/domain/repositories/settings_repository.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.settingsRepository}) : super(SplashLoading()) {
    _checkInitialConfiguration();
  }

  final SettingsRepository settingsRepository;

  Future<void> _checkInitialConfiguration() async {
    emit(SplashLoading());
    // load data or do the necessary checks
    await _goAhead();
  }

  /// Startup completed
  Future<void> _goAhead() async {
    final showOnboardingResult =
        await settingsRepository.shouldShowOnboardingPage();
    showOnboardingResult.fold(
      onSuccess: (showOnboarding) {
        emit(SplashSetupCompleted(showOnboarding: showOnboarding));
      },
      onFailure: (_) => emit(
        SplashSetupCompleted(showOnboarding: true),
      ),
    );
  }

  void retry() {
    _checkInitialConfiguration();
  }
}
