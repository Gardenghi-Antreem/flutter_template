import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_template/app/features/login/presentation/ui/login_screen.dart';
import 'package:flutter_template/app/shared/components/button/app_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/helpers.dart';
import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginBloc])
void main() {
  late MockLoginBloc mockLoginBloc;
  late LoginScreen loginScreen;

  const testUsername = 'test';
  const testPassword = 'pwd1234!';

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    loginScreen = const LoginScreen();
  });

  group('LoginScreen', () {
    testWidgets('ButtonPressed event is triggered', (tester) async {
      when(mockLoginBloc.state)
          .thenReturn(const LoginState(status: LoginStatus.idle));
      when(mockLoginBloc.stream).thenAnswer(
        (_) =>
            Stream.fromIterable([const LoginState(status: LoginStatus.idle)]),
      );

      // ignore: unnecessary_cast
      await tester.pumpApp(
        Scaffold(
          body: BlocProvider.value(
            // ignore: unnecessary_cast
            value: mockLoginBloc as LoginBloc,
            child: loginScreen,
          ),
        ),
      );

      await tester.enterText(find.byKey(usernameFieldKey), testUsername);
      await tester.enterText(find.byKey(passwordFieldKey), testPassword);
      await tester.tap(find.byType(AppButton));

      verify(
        mockLoginBloc.add(const UsernameChanged(newUsername: testUsername)),
      ).called(1);
      verify(
        mockLoginBloc.add(const PasswordChanged(newPassword: testPassword)),
      ).called(1);
      verify(mockLoginBloc.add(const LoginButtonPressed())).called(1);
    });
  });
}
