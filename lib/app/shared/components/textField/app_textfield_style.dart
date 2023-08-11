import 'package:flutter/material.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_text_style.dart';

enum AppTextFieldLabelStyle {
  normal,
  bold,
  italics,
  boldItalics;
}

enum AppTextFieldLabelPosition {
  left,
  top;
}

enum AppTextFieldType {
  text,
  password,
  textArea;
}

enum AppTextFieldVariant {
  standard,
  filled,
  error;
}

TextStyle normalLabelStyle = AppTextStyles.body12pxRegularGrey80Sx;
TextStyle boldLabelStyle = AppTextStyles.body12pxBoldGrey80Sx;
TextStyle italicsLabelStyle =
    normalLabelStyle.copyWith(fontStyle: FontStyle.italic);
TextStyle boldItalicsLabelStyle =
    boldLabelStyle.copyWith(fontStyle: FontStyle.italic);

abstract class AppTextFieldColors {
  static const Color border = AppColors.gray20;
  static const Color borderError = AppColors.statusErrorLighter;
  static const Color text = AppColors.gray90;
  static const Color textError = AppColors.statusErrorLight;
  static const Color leftIcon = AppColors.gray90;
  static const Color rightIcon = AppColors.secondaryMain;
  static const Color fill = AppColors.primaryXLighter;
  static const Color background = AppColors.grayWhite;
}

TextStyle textFieldPlaceHolderStyle =
    AppTextStyles.body16pxRegularWhiteSx.copyWith(color: AppColors.gray30);
