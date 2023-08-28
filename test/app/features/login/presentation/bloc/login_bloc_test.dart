import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_template/app/shared/core/error/failures/failures.dart';
import 'package:flutter_template/app/shared/core/form_fields/password_field.dart';
import 'package:flutter_template/app/shared/core/form_fields/username_field.dart';
import 'package:flutter_template/app/shared/core/result/result.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationRepository])
void main() {
  late MockAuthenticationRepository mockAuthRepository;
  late LoginBloc loginBloc;

  const testUsername = 'test';
  const testPassword = 'pwd1234!';

  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    loginBloc = LoginBloc(loginRepository: mockAuthRepository);
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'emits no state when nothing is added',
      build: () => loginBloc,
      expect: () => <LoginState>[],
    );

    blocTest<LoginBloc, LoginState>(
      'emits Loading, Success and Idle when LoginButtonPressed is added and the use case succeeds',
      build: () => loginBloc,
      setUp: () {
        when(mockAuthRepository.login(any, any))
            .thenAnswer((_) async => Success(null));
      },
      act: (bloc) => bloc
        ..add(const UsernameChanged(newUsername: testUsername))
        ..add(const PasswordChanged(newPassword: testPassword))
        ..add(const LoginButtonPressed()),
      expect: () => [
        const LoginState(
          status: LoginStatus.idle,
          username: UsernameField.dirty(value: testUsername),
        ),
        const LoginState(
          status: LoginStatus.idle,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
        const LoginState(
          status: LoginStatus.loading,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
        const LoginState(
          status: LoginStatus.succeeded,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
        const LoginState(
          status: LoginStatus.idle,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits Loading, Error and Idle when LoginButtonPressed is added and the use case fails',
      build: () => loginBloc,
      setUp: () {
        when(mockAuthRepository.login(any, any))
            .thenAnswer((_) async => Error(UnknownFailure()));
      },
      act: (bloc) => bloc
        ..add(const UsernameChanged(newUsername: testUsername))
        ..add(const PasswordChanged(newPassword: testPassword))
        ..add(const LoginButtonPressed()),
      expect: () => [
        const LoginState(
          status: LoginStatus.idle,
          username: UsernameField.dirty(value: testUsername),
        ),
        const LoginState(
          status: LoginStatus.idle,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
        const LoginState(
          status: LoginStatus.loading,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
        LoginState(
          status: LoginStatus.failure,
          failure: UnknownFailure(),
          username: const UsernameField.dirty(value: testUsername),
          password: const PasswordField.dirty(value: testPassword),
        ),
        const LoginState(
          status: LoginStatus.idle,
          username: UsernameField.dirty(value: testUsername),
          password: PasswordField.dirty(value: testPassword),
        ),
      ],
    );
  });
}
