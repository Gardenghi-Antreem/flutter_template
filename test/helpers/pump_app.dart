import 'package:flutter/material.dart';
import 'package:flutter_template/l10n/app_translations.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            AppTranslations.init(context);
            return widget;
          },
        ),
      ),
    );
  }
}
