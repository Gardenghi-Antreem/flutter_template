import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flutter_template/app/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_template/app/shared/components/alert/app_alert.dart';
import 'package:flutter_template/app/shared/components/alert/app_alert_style.dart';
import 'package:flutter_template/app/shared/core/routes/routes_paths.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_images.dart';
import 'package:flutter_template/app/shared/utils/constants.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSetupCompleted) {
            context.go(
              state.showOnboarding ? RoutesPaths.onboarding : RoutesPaths.login,
            );
          } else if (state is SplashError) {
            AppAlert.show(
              context,
              state.failure.message(),
              showCloseIcon: false,
              variant: AppAlertVariant.error,
              duration: unlimitedDuration,
              callToAction: AppAlertAction(
                label: l10n.commonButtonRetry,
                onPressed: () {
                  context.read<SplashCubit>().retry();
                },
              ),
            );
          }
        },
        child: ColoredBox(
          color: AppColors.primaryMain,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0x00000000), Color(0x5f000000)],
                stops: [0, 1],
              ),
            ),
            child: Center(
              child: Image.asset(
                AppImages.company_logo,
                width: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
