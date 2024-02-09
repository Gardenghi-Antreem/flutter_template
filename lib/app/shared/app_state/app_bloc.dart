import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_template/app/shared/app_state/app_state.dart';
import 'package:flutter_template/app/shared/domain/entities/user.dart';
import 'package:flutter_template/app/shared/utils/storage.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.appStorage,
  }) : super(
          const AppState(),
        );

  final AppStorage appStorage;

  Future<void> setUser(
    User user,
    String password,
  ) async {
    await appStorage.write(
      key: AppStorage.userKey,
      value: jsonEncode(user.toJson()),
    );
    await appStorage.write(
      key: AppStorage.userPasswordKey,
      value: password,
    );
    emit(state.copyWith(user: user));
  }

  Future<void> removeUser() async {
    await appStorage.delete(key: AppStorage.userKey);
    await appStorage.delete(key: AppStorage.userPasswordKey);
    // ignore: avoid_redundant_argument_values
    emit(const AppState(user: null));
  }
}
