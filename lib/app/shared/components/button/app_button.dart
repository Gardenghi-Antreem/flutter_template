import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/app/shared/components/button/app_button_style.dart';

class AppButton extends StatelessWidget {
  ///App standard button
  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.disabled = false,
    this.size = AppButtonSize.medium,
    required this.onClick,
    this.textDirection = TextDirection.rtl,
    this.image,
  });

  ///OPTIONAL. Disables the button. Default: false
  final bool disabled;

  ///OPTIONAL. Changes button's size. Default: AppButtonSize.medium
  final AppButtonSize size;

  ///OPTIONAL. Changes button's style. Default: AppButtonVariant.primary
  final AppButtonVariant variant;

  ///OPTIONAL. The text shown in the button.
  final String text;

  ///OPTIONAL. The icon shown in the button.
  final String? icon;

  ///REQUIRED. OnClick callback function.
  final void Function() onClick;

  ///OPTIONAL. The direction text in the button
  final TextDirection textDirection;

  final Image? image;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final svgCol = _getSVGColors();
    final labelStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: size.fontSize);
    return SizedBox(
      height: size.buttonHeight,
      child: //if icon not defined
          (icon?.isEmpty ?? true)
              ? ElevatedButton(
                  onPressed: disabled ? null : onClick,
                  style: buttonStyle,
                  child: Text(text.toUpperCase(), style: labelStyle),
                )
              : //if icon defined but no text
              (text.isEmpty)
                  ? IconButton(
                      // <-- ElevatedButton
                      onPressed: disabled ? null : onClick,
                      icon: SvgPicture.asset(
                        icon!,
                        colorFilter: disabled
                            ? ColorFilter.mode(
                                svgCol.disabledColor,
                                BlendMode.srcIn,
                              )
                            : ColorFilter.mode(
                                svgCol.enabledColor,
                                BlendMode.srcIn,
                              ),
                      ),
                      style: buttonStyle,
                    )
                  : //if icon and text
                  Directionality(
                      textDirection: textDirection,
                      child: ElevatedButton.icon(
                        // <-- ElevatedButton
                        onPressed: disabled ? null : onClick,
                        icon: icon!.contains('png')
                            ? Image.asset(
                                icon!,
                                height: size.iconSize,
                                width: size.iconSize,
                              )
                            : SvgPicture.asset(
                                icon!,
                                width: size.iconSize,
                                height: size.iconSize,
                                colorFilter: disabled
                                    ? ColorFilter.mode(
                                        svgCol.disabledColor,
                                        BlendMode.srcIn,
                                      )
                                    : ColorFilter.mode(
                                        svgCol.enabledColor,
                                        BlendMode.srcIn,
                                      ),
                              ),
                        label: Text(text.toUpperCase(), style: labelStyle),
                        style: buttonStyle,
                      ),
                    ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (variant) {
      case AppButtonVariant.primary:
        return primaryButtonStyle(disabled: disabled);
    }
  }

  SvgColorDef _getSVGColors() {
    switch (variant) {
      case AppButtonVariant.primary:
        return primarySvgColors();
    }
  }
}
