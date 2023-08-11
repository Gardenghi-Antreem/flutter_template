import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_template/app/features/splash/presentation/ui/splash_screen.dart';
import 'package:flutter_template/app/shared/core/locator/injection_container.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => sl(),
      child: const SplashScreen(),
    );
  }
}
