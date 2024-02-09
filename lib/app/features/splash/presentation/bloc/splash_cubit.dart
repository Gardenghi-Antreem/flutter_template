import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_template/app/shared/app_state/app_bloc.dart';
import 'package:flutter_template/app/shared/core/error/failures/failures.dart';
import 'package:flutter_template/app/shared/domain/entities/user.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';
import 'package:flutter_template/app/shared/domain/repositories/settings_repository.dart';
import 'package:flutter_template/app/shared/utils/storage.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.settingsRepository,
    required this.authenticationRepository,
    required this.appBloc,
  }) : super(SplashLoading()) {
    _checkInitialConfiguration();
  }

  final SettingsRepository settingsRepository;
  final AuthenticationRepository authenticationRepository;
  final AppCubit appBloc;

  Future<void> _checkInitialConfiguration() async {
    emit(SplashLoading());
    // load data or do the necessary checks
    try {
      final loadError = await _loadUser();
      if (loadError != null) {
        emit(SplashError(loadError));
        return;
      }
    } on Exception catch (e) {
      emit(SplashError(Failure.fromException(e)));
      return;
    }
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

  Future<Failure?> _loadUser() async {
    Failure? loadError;
    final userData = await appBloc.appStorage.read(key: AppStorage.userKey);
    final userPassword =
        await appBloc.appStorage.read(key: AppStorage.userPasswordKey);
    if (userData != null && userPassword != null) {
      final json = jsonDecode(userData) as Map<String, dynamic>;
      var user = User.fromJson(json);
      final response = await authenticationRepository.login(
        user.username,
        userPassword,
      );
      response.fold(
        onSuccess: (loggedUser) {
          user = loggedUser;
        },
        onFailure: (failure) {
          loadError = failure;
        },
      );
      await appBloc.setUser(user, userPassword);
    }
    return loadError;
  }
}
