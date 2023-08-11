import 'package:flutter/material.dart';
import 'package:flutter_template/app/features/login/presentation/ui/login_page.dart';
import 'package:flutter_template/app/features/splash/presentation/ui/splash_page.dart';
import 'package:flutter_template/app/shared/core/routes/routes_paths.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutesPaths.root,
  routes: <RouteBase>[
    GoRoute(
      path: RoutesPaths.root,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: RoutesPaths.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
  ],
);
