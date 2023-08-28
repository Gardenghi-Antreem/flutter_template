import 'package:flutter/material.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final headingLevel2BoldWhiteSx = GoogleFonts.inter(
    color: AppColors.grayWhite,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 28,
  );
  static final body16pxRegularWhiteSx = GoogleFonts.inter(
    color: AppColors.grayWhite,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 16,
  );
  static final body12pxRegularGrey80Sx = GoogleFonts.inter(
    color: AppColors.gray80,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );
  static final body12pxBoldGrey80Sx = GoogleFonts.inter(
    color: AppColors.gray80,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );
  static final interactive12pxRegularEnabledC = GoogleFonts.inter(
    color: AppColors.secondaryMain,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );
  static final interactive12pxBoldDarkC = GoogleFonts.inter(
    color: AppColors.secondaryDark,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );
}
