import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/features/login/presentation/bloc/login_bloc.dart';

import 'package:flutter_template/app/features/login/presentation/ui/login_screen.dart';
import 'package:flutter_template/app/shared/core/locator/injection_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl(),
      child: const LoginScreen(),
    );
  }
}
