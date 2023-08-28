import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const defaultTableCellFlex = 3;

class AccordionTableCell extends StatelessWidget {
  const AccordionTableCell({
    super.key,
    this.text = '',
    this.child,
    this.textStyle,
    this.flex,
  });

  final String text;
  final Widget? child;
  final TextStyle? textStyle;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? defaultTableCellFlex,
      child: SizedBox(
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle.merge(
              style: textStyle,
              child: child ??
                  Text(
                    text,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
