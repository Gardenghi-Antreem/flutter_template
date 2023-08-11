import 'package:flutter/material.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_template/app/shared/core/locator/injection_container.dart';
import 'package:flutter_template/app/shared/data/repositories/settings_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders MaterialApp', (tester) async {
      sl.registerLazySingleton(
        () =>
            SplashCubit(settingsRepository: SettingsRepositoryImplementation()),
      );
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
