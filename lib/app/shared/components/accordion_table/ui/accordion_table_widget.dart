import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_bloc.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_event.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_state.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_cell.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_row.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_screen.dart';
import 'package:flutter_template/app/shared/components/pager/pager.dart';
import 'package:flutter_template/app/shared/core/result/result.dart';

const _bottomPadding = 100;

class AccordionTable<T, R> extends StatelessWidget {
  const AccordionTable({
    super.key,
    required this.columnHeaders,
    required this.rows,
    this.itemCount,
    this.highlighted,
    this.headOfRowElement,
    this.endOfRowElement,
    this.onPageChanged,
    this.infiniteScroll = false,
    this.touchableRows = true,
  });

  final List<ColumnHeader> columnHeaders;
  final List<TableRowData<T, R>> rows;
  final int? itemCount;
  final T? highlighted;
  final bool infiniteScroll;
  final bool touchableRows;
  final Widget Function({bool rowIsOpen})? headOfRowElement;
  final Widget Function(T? element, {bool rowIsOpen})? endOfRowElement;
  final FutureOr<void> Function(int page, int maxItemIndexOnThisPage)?
      onPageChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (contex, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: BlocProvider(
            create: (context) => AccordionTableBloc<T, R>(
              rows: rows,
              itemCount: itemCount,
              onPageChanged: onPageChanged,
              numberOfRowsPerPage: _getNumberOfRowsPerPage(constraints),
            ),
            child:
                BlocBuilder<AccordionTableBloc<T, R>, AccordionTableState<T>>(
              builder: (context, state) {
                return Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: infiniteScroll ? constraints.maxHeight : null,
                      width: infiniteScroll ? constraints.maxWidth : null,
                      child: AccordionTableScreen<T, R>(
                        columnHeaders: columnHeaders,
                        rows: _getCurrentPageRows(state),
                        count: itemCount,
                        highlighted: highlighted,
                        onPageChanged: onPageChanged,
                        infiniteScroll: infiniteScroll,
                        touchableRows: touchableRows,
                        headOfRowElement: headOfRowElement,
                        endOfRowElement: endOfRowElement,
                      ),
                    ),
                    if (!infiniteScroll)
                      const SizedBox(
                        height: 20,
                      ),
                    if (!infiniteScroll && state.pages > 1)
                      Pager(
                        pagesNumber: state.pages,
                        currentPage: state.currentPage,
                        onRightArrowPress: (currentPage) => context
                            .read<AccordionTableBloc<T, R>>()
                            .add(ChangePage(page: currentPage + 1)),
                        onLeftArrowPress: (currentPage) => context
                            .read<AccordionTableBloc<T, R>>()
                            .add(ChangePage(page: currentPage - 1)),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  int _getNumberOfRowsPerPage(BoxConstraints constraints) {
    if (constraints.maxHeight != double.infinity) {
      return (constraints.maxHeight - _bottomPadding) ~/
          accordionTableRowHeight;
    }
    return itemCount ?? rows.length;
  }

  List<TableRowData<T, R>> _getCurrentPageRows(
    AccordionTableState<T> state,
  ) {
    if (infiniteScroll) return rows;

    final currentPage = state.currentPage;
    final pages = state.pages;
    final numberOfRowsPerPage = state.numberOfRowsPerPage;

    final minIndex = currentPage * numberOfRowsPerPage;
    final maxIndex = min(
      currentPage == pages - 1
          ? itemCount ?? rows.length
          : (currentPage + 1) * numberOfRowsPerPage,
      rows.length,
    );
    if (pages != 0 && minIndex < rows.length) {
      return rows
          .getRange(
            minIndex,
            maxIndex,
          )
          .toList();
    } else {
      return [];
    }
  }
}

class ColumnHeader {
  const ColumnHeader({required this.text, this.flex = defaultTableCellFlex});

  final String text;
  final int flex;
}

/// T represents the type of the payload data associated with the row,
/// R represents the type of Data needed to openAccordionChildBuilder to build the child
class TableRowData<T, R> {
  TableRowData({
    required this.cells,
    this.payload,
    this.onRowOpen,
    this.openAccordionChildBuilder,
    this.infiniteScrollChild,
  });

  final List<Widget> Function({bool isOpen, bool isHighlighted}) cells;

  /// T represents the type of the payload data associated with the row,
  final T? payload;

  /// T represents the type of the payload data associated with the row,
  /// R represents the type of Data needed to openAccordionChildBuilder to build the child
  AsyncResult<R> Function(T? payload, int index)? onRowOpen;

  /// T represents the type of the payload data associated with the row,
  /// R represents the type of Data needed to openAccordionChildBuilder to build the child
  Widget Function(R data, T? payload)? openAccordionChildBuilder;
  Widget? infiniteScrollChild;
}
