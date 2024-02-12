import 'package:flutter/material.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_template/app/shared/app_state/app_bloc.dart';
import 'package:flutter_template/app/shared/core/config/config.dart';
import 'package:flutter_template/app/shared/core/locator/injection_container.dart';
import 'package:flutter_template/app/shared/data/repositories/settings_repository_impl.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';
import 'package:flutter_template/app/shared/domain/repositories/settings_repository.dart';
import 'package:flutter_template/app/shared/utils/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'app_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  group('App', () {
    testWidgets('renders MaterialApp', (tester) async {
      sl
        ..registerLazySingleton(Config.new)
        ..registerLazySingleton(AppStorage.new)
        ..registerLazySingleton<SettingsRepository>(
          SettingsRepositoryImplementation.new,
        )
        ..registerLazySingleton<AuthenticationRepository>(
          MockAuthenticationRepository.new,
        )
        ..registerLazySingleton<AppCubit>(() => AppCubit(appStorage: sl()))
        ..registerLazySingleton(
          () => SplashCubit(
            settingsRepository: sl(),
            appBloc: sl(),
            authenticationRepository: sl(),
          ),
        );
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
