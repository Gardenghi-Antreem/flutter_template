import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_bloc.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_event.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_state.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_cell.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_row.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_widget.dart';
import 'package:flutter_template/app/shared/components/spinner/spinner.dart';
import 'package:flutter_template/app/shared/style/app_colors.dart';
import 'package:flutter_template/app/shared/style/app_text_style.dart';

class AccordionTableScreen<T, R> extends StatelessWidget {
  const AccordionTableScreen({
    super.key,
    required this.columnHeaders,
    required this.rows,
    required this.infiniteScroll,
    required this.touchableRows,
    this.count,
    this.highlighted,
    this.headOfRowElement,
    this.endOfRowElement,
    this.onPageChanged,
  });

  final List<ColumnHeader> columnHeaders;
  final List<TableRowData<T, R>> rows;
  final int? count;
  final T? highlighted;
  final bool infiniteScroll;
  final bool touchableRows;
  final Widget Function({bool rowIsOpen})? headOfRowElement;
  final Widget Function(T?, {bool rowIsOpen})? endOfRowElement;
  final FutureOr<void> Function(int page, int maxItemIndexOnThisPage)?
      onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: BlocBuilder<AccordionTableBloc<T, R>, AccordionTableState<T>>(
            buildWhen: (previous, current) {
              return previous.selectedRow != current.selectedRow;
            },
            builder: (context, state) {
              if (infiniteScroll) {
                return ListView.builder(
                  itemCount: count == null || count == rows.length
                      ? rows.length
                      : (rows.length + 1),
                  itemBuilder: (context, index) {
                    if (index == rows.length) {
                      onPageChanged?.call(1, 0);
                      return const SizedBox(
                        height: 65,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: AppSpinner(),
                        ),
                      );
                    }
                    return _getRow(context, state, index);
                  },
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _getRows(context, state),
                );
              }
            },
          ),
        ),
        if (infiniteScroll)
          BlocBuilder<AccordionTableBloc<T, R>, AccordionTableState<T>>(
            builder: (context, state) => state.selectedRow != null &&
                    rows[state.selectedRow!].infiniteScrollChild != null
                ? SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: _getRow(context, state, state.selectedRow!),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        Container(
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.grayWhite,
            boxShadow: [
              BoxShadow(
                color: AppColors.gray10,
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Row(
            children: [
              Visibility(
                visible: false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: headOfRowElement?.call(rowIsOpen: false) ?? Container(),
              ),
              ...columnHeaders.map(
                (header) => AccordionTableCell(
                  flex: header.flex,
                  text: header.text,
                  textStyle: AppTextStyles.body12pxBoldGrey80Sx,
                ),
              ),
              Visibility(
                visible: false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: endOfRowElement?.call(null, rowIsOpen: false) ??
                    Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<AccordionTableRow<T, R>> _getRows(
    BuildContext context,
    AccordionTableState<T> state,
  ) {
    return rows
        .asMap()
        .entries
        .map(
          (entry) => AccordionTableRow<T, R>(
            row: entry.value,
            columnHeaders: columnHeaders,
            index: entry.key,
            isOpen: state.selectedRow == entry.key,
            onRowOpen: () => context.read<AccordionTableBloc<T, R>>().add(
                  SelectRow<T>(
                    selectedRow: entry.key, //entry.value.payload,
                  ),
                ),
            isHighlighted:
                entry.value.payload == highlighted && highlighted != null,
            headOfRowElement: headOfRowElement,
            endOfRowElement: endOfRowElement,
            touchableRows: touchableRows,
          ),
        )
        .toList();
  }

  AccordionTableRow<T, R> _getRow(
    BuildContext context,
    AccordionTableState<T> state,
    int i,
  ) {
    return AccordionTableRow<T, R>(
      row: rows[i],
      columnHeaders: columnHeaders,
      index: i,
      isOpen: state.selectedRow == i,
      onRowOpen: () {
        rows[i].onRowOpen?.call(rows[i].payload, i);
        context.read<AccordionTableBloc<T, R>>().add(
              SelectRow<T>(
                selectedRow: i, //entry.value.payload,
              ),
            );
      },
      isHighlighted: rows[i].payload == highlighted && highlighted != null,
      headOfRowElement: headOfRowElement,
      endOfRowElement: endOfRowElement,
      touchableRows: touchableRows,
    );
  }
}
