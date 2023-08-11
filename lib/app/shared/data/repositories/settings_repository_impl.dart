import 'package:flutter_template/app/shared/core/result/result.dart';
import 'package:flutter_template/app/shared/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _onboardingShownKey = 'onboardingShown';

class SettingsRepositoryImplementation implements SettingsRepository {
  @override
  AsyncResult<void> hideOnboardingPageForever() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingShownKey, false);

    return Future.value(Success(null));
  }

  @override
  AsyncResult<bool> shouldShowOnboardingPage() async {
    final prefs = await SharedPreferences.getInstance();
    return Success((prefs.getBool(_onboardingShownKey)) ?? false);
  }
}
