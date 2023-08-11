import 'package:flutter_template/app/shared/core/result/result.dart';

abstract class SettingsRepository {
  AsyncResult<void> hideOnboardingPageForever();
  AsyncResult<bool> shouldShowOnboardingPage();
}
