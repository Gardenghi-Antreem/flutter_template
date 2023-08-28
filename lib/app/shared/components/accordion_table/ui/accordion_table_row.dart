import 'package:flutter/material.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_cell.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_widget.dart';
import 'package:flutter_template/app/shared/components/alert/app_alert.dart';
import 'package:flutter_template/app/shared/components/alert/app_alert_style.dart';
import 'package:flutter_template/app/shared/components/spinner/spinner.dart';
import 'package:flutter_template/app/shared/components/spinner/spinner_style.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_text_style.dart';

const accordionTableRowHeight = 40.0;

/// T represents the type of the payload data associated with the row,
/// R represents the type of Data needed to openAccordionChildBuilder to build the child
class AccordionTableRow<T, R> extends StatelessWidget {
  const AccordionTableRow({
    super.key,
    required this.row,
    required this.columnHeaders,
    required this.index,
    required this.touchableRows,
    this.isHighlighted = false,
    this.isOpen = false,
    this.onRowOpen,
    this.headOfRowElement,
    this.endOfRowElement,
  });

  final TableRowData<T, R> row;
  final List<ColumnHeader> columnHeaders;
  final int index;
  final bool isHighlighted;
  final bool isOpen;
  final bool touchableRows;
  final void Function()? onRowOpen;
  final Widget Function({bool rowIsOpen})? headOfRowElement;
  final Widget Function(T?, {bool rowIsOpen})? endOfRowElement;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: touchableRows ? onRowOpen : null,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: accordionTableRowHeight,
        ),
        color: _getBackGroundColor(isOpen, isHighlighted, index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                headOfRowElement?.call(rowIsOpen: isOpen) ?? Container(),
                ...row
                    .cells(isOpen: isOpen, isHighlighted: isHighlighted)
                    .asMap()
                    .entries
                    .map(
                      (entry) => AccordionTableCell(
                        flex: columnHeaders[entry.key].flex,
                        textStyle: AppTextStyles.body12pxRegularGrey80Sx,
                        child: entry.value,
                      ),
                    ),
                endOfRowElement?.call(row.payload, rowIsOpen: isOpen) ??
                    Container(),
              ],
            ),
            if (isOpen && row.infiniteScrollChild != null)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: row.infiniteScrollChild ?? const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            if (isOpen &&
                row.onRowOpen != null &&
                row.infiniteScrollChild == null)
              FutureBuilder(
                future: row.onRowOpen?.call(row.payload, index),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final result = snapshot.data;
                    Widget? openAccordionChildWidget;
                    if (result != null) {
                      result.fold(
                        onSuccess: (data) {
                          openAccordionChildWidget = row
                              .openAccordionChildBuilder
                              ?.call(data, row.payload);
                        },
                        onFailure: (failure) {
                          AppAlert.show(
                            context,
                            failure.message(),
                            variant: AppAlertVariant.error,
                          );
                        },
                      );
                    }
                    return openAccordionChildWidget ?? Container();
                  }
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      40,
                    ),
                    child: AppSpinner(
                      size: AppSpinnerSize.m,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

Color? _getBackGroundColor(bool isOpen, bool isHighlighted, int index) {
  if (isOpen) return AppColors.primaryXLighter;
  if (isHighlighted) return AppColors.accentLighter;
  if (index.isEven) {
    return AppColors.grayWhite;
  } else {
    return AppColors.gray10;
  }
}
