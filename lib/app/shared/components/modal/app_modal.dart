import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/app/shared/components/button/app_button.dart';
import 'package:flutter_template/app/shared/components/modal/base_modal.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_icons.dart';
import 'package:flutter_template/app/shared/style/app_text_style.dart';
import 'package:flutter_template/app/shared/utils/color_extensions.dart';

class AppModal extends StatelessWidget {
  const AppModal({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.showCloseButton = false,
    this.onCloseButtonPressed,
    this.buttonIcon,
  });

  final String title;
  final String message;
  final String buttonText;
  final void Function() onButtonPressed;
  final bool showCloseButton;
  final void Function()? onCloseButtonPressed;
  final String? buttonIcon;

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryDark),
            color: AppColors.secondaryDark,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: AppColors.primaryDarker,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.headingLevel2BoldWhiteSx.copyWith(
                          color: AppColors.accentMain,
                        ),
                      ),
                      IconButton(
                        iconSize: 32,
                        onPressed:
                            onCloseButtonPressed ?? () => closeModal(context),
                        icon: SvgPicture.asset(
                          AppIcons.close,
                          colorFilter: AppColors.accentMain.filterSrcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                child:
                    Text(message, style: AppTextStyles.body16pxRegularWhiteSx),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (showCloseButton)
                      AppButton(
                        icon: AppIcons.close,
                        onClick: () {
                          onCloseButtonPressed?.call();
                          closeModal(context);
                        },
                        coverHorizontalSpace: false,
                      ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: showCloseButton ? 8 : 0,
                        ),
                        child: AppButton(
                          text: buttonText,
                          icon: buttonIcon,
                          onClick: () {
                            onButtonPressed();
                            closeModal(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
