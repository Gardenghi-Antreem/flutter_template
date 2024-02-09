import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/shared/app_state/app_bloc.dart';
import 'package:flutter_template/app/shared/core/locator/injection_container.dart';
import 'package:flutter_template/bootstrap.dart';

void main() {
  bootstrap(
    () => BlocProvider<AppCubit>(
      create: (context) => sl(),
      child: const App(),
    ),
  );
}
