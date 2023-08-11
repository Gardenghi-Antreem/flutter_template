import 'package:flutter/material.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';

enum AppAlertSize {
  short,
  long;
}

enum AppAlertVariant {
  info,
  warning,
  error,
  success;
}

/// *******************  STYLES DEFINITION ***********************

abstract class AppAlertColors {
  static const Color alertFont = AppColors.gray80;
  static const Color infoAlertBackground = AppColors.primaryLighter;
  static const Color warningAlertBackground = AppColors.statusWarningLighter;
  static const Color successAlertBackground = AppColors.statusSuccessLighter;
  static const Color errorAlertBackground = AppColors.statusErrorLighter;
  static const Color infoAlertIcon = AppColors.secondaryMain;
  static const Color warningAlertIcon = AppColors.statusWarningMain;
  static const Color successAlertIcon = AppColors.statusSuccessMain;
  static const Color errorAlertIcon = AppColors.statusErrorMain;
}
