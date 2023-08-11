import 'package:bloc/bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_template/app/shared/core/form_fields/password_field.dart';
import 'package:flutter_template/app/shared/core/form_fields/username_field.dart';
import 'package:flutter_template/app/shared/domain/repositories/authentication_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginRepository,
  }) : super(
          const LoginState(
            status: LoginStatus.idle,
          ),
        ) {
    on<LoginButtonPressed>(_onButtonPressedEvent);
    on<TogglePasswordIconPressed>(_togglePasswordVisibility);
    on<UsernameChanged>(_updateUsername);
    on<PasswordChanged>(_updatePassword);
  }

  final AuthenticationRepository loginRepository;

  Future<void> _onButtonPressedEvent(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result =
        await loginRepository.login(state.username.value, state.password.value);
    result.fold(
      onSuccess: (user) {
        emit(state.copyWith(status: LoginStatus.succeeded));
        emit(state.copyWith(status: LoginStatus.idle));
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            failureProvider: () => failure,
          ),
        );
        emit(state.copyWith(status: LoginStatus.idle));
      },
    );
  }

  Future<void> _togglePasswordVisibility(
    TogglePasswordIconPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<void> _updateUsername(
    UsernameChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        username: UsernameField.dirty(value: event.newUsername),
      ),
    );
  }

  Future<void> _updatePassword(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        password: PasswordField.dirty(value: event.newPassword),
      ),
    );
  }
}
