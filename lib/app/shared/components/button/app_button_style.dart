import 'package:flutter/material.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';

enum AppButtonSize {
  medium._(50, 16, 22);

  const AppButtonSize._(this.buttonHeight, this.fontSize, this.iconSize);

  final double buttonHeight;
  final double fontSize;
  final double iconSize;
}

enum AppButtonVariant {
  primary,
}

/// *******************  STYLES DEFINITION ***********************

const _borderRadius = BorderRadius.all(Radius.circular(25));

class SvgColorDef {
  SvgColorDef({
    required this.enabledColor,
    required this.disabledColor,
  });
  Color enabledColor;
  Color disabledColor;
}

SvgColorDef primarySvgColors() => SvgColorDef(
      enabledColor: AppButtonColors.buttonLabelPrimary,
      disabledColor: AppButtonColors.buttonLabelPrimaryDisabled,
    );

ButtonStyle primaryButtonStyle({bool disabled = false}) =>
    ElevatedButton.styleFrom(
      disabledBackgroundColor: AppButtonColors.buttonPrimaryDisabled,
      disabledForegroundColor: AppButtonColors.buttonLabelPrimaryDisabled,
      backgroundColor: AppButtonColors.buttonPrimary,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: disabled
              ? AppButtonColors.buttonBorderPrimaryDisabled
              : AppButtonColors.buttonBorderPrimary,
          width: 2,
        ),
        borderRadius: _borderRadius,
      ),
      foregroundColor: AppButtonColors.buttonLabelPrimary,
    );

abstract class AppButtonColors {
  static const Color buttonPrimary = AppColors.accentMain;
  static const Color buttonPrimaryDisabled = AppColors.gray20;
  static const Color buttonLabelPrimaryDisabled = AppColors.grayWhite;
  static const Color buttonBorderPrimaryDisabled = AppColors.gray20;
  static const Color buttonRipplePrimary = AppColors.grayWhite;
  static const Color buttonLabelPrimary = AppColors.secondaryDark;
  static const Color buttonBorderPrimary = AppColors.accentMain;
}
