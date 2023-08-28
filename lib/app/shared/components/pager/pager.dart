import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_icons.dart';
import 'package:flutter_template/app/shared/style/app_text_style.dart';
import 'package:flutter_template/app/shared/utils/color_extensions.dart';

class Pager extends StatelessWidget {
  const Pager({
    super.key,
    required this.pagesNumber,
    required this.currentPage,
    required this.onLeftArrowPress,
    required this.onRightArrowPress,
  });

  final int pagesNumber;
  final int currentPage;
  final void Function(int currentPage) onLeftArrowPress;
  final void Function(int currentPage) onRightArrowPress;

  @override
  Widget build(BuildContext context) {
    final lastPage = pagesNumber - 1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (currentPage != 0) onLeftArrowPress(currentPage);
          },
          child: SvgPicture.asset(
            AppIcons.chevron_left_filled,
            colorFilter:
                (currentPage == 0) ? AppColors.gray20.filterSrcIn : null,
          ),
        ),
        if (currentPage == lastPage && pagesNumber > 2)
          _PagerSlot(number: currentPage - 2),
        if (currentPage != 0 && pagesNumber > 1)
          _PagerSlot(number: currentPage - 1),
        _PagerSlot(
          number: currentPage,
          isCurrentPage: true,
        ),
        if (currentPage != lastPage && pagesNumber > 1)
          _PagerSlot(number: currentPage + 1),
        if (currentPage == 0 && pagesNumber > 2)
          _PagerSlot(number: currentPage + 2),
        GestureDetector(
          onTap: () {
            if (currentPage != lastPage) onRightArrowPress(currentPage);
          },
          child: SvgPicture.asset(
            AppIcons.chevron_right_filled,
            colorFilter:
                (currentPage == lastPage) ? AppColors.gray20.filterSrcIn : null,
          ),
        ),
      ],
    );
  }
}

class _PagerSlot extends StatelessWidget {
  const _PagerSlot({required this.number, this.isCurrentPage = false});

  final int? number;
  final bool isCurrentPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Center(
        child: (number != null)
            ? Text(
                (number! + 1).toString(),
                style: isCurrentPage
                    ? AppTextStyles.interactive12pxBoldDarkC
                    : AppTextStyles.interactive12pxRegularEnabledC,
              )
            : Text(
                '...',
                style: AppTextStyles.interactive12pxRegularEnabledC,
              ),
      ),
    );
  }
}
