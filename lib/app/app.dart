import 'package:flutter/material.dart';
import 'package:flutter_template/app/shared/core/routes/routes.dart';
import 'package:flutter_template/l10n/app_translations.dart';
import 'package:flutter_template/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('it'),
      builder: (context, child) {
        AppTranslations.init(context);
        return child ?? const Text('Missin');
      },
    );
  }
}

class _AppHome extends StatefulWidget {
  const _AppHome();

  @override
  State<_AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<_AppHome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      AppTranslations.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
