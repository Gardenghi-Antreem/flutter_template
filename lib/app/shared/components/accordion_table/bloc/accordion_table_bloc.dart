import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_event.dart';
import 'package:flutter_template/app/shared/components/accordion_table/bloc/accordion_table_state.dart';
import 'package:flutter_template/app/shared/components/accordion_table/ui/accordion_table_widget.dart';

/// T represents the type of the payload data associated with the row,
/// R represents the type of Data needed to openAccordionChildBuilder to build the child
class AccordionTableBloc<T, R>
    extends Bloc<AccordionTableEvent, AccordionTableState<T>> {
  AccordionTableBloc({
    required this.rows,
    required this.numberOfRowsPerPage,
    this.onPageChanged,
    int? itemCount,
  }) : super(
          AccordionTableState(
            currentPage: 0,
            numberOfRowsPerPage: numberOfRowsPerPage,
            pages: numberOfRowsPerPage == 0
                ? numberOfRowsPerPage
                : ((itemCount ?? rows.length) / numberOfRowsPerPage).ceil(),
          ),
        ) {
    on<SelectRow<T>>(_onSelectRow);
    on<ChangePage>(_onChangePage);
  }

  List<TableRowData<T, R>> rows;
  int numberOfRowsPerPage;

  final FutureOr<void> Function(int page, int maxItemIndexOnThisPage)?
      onPageChanged;

  Future<void> _onSelectRow(
    SelectRow<T> event,
    Emitter<AccordionTableState<T>> emit,
  ) async {
    if (event.selectedRow != state.selectedRow) {
      emit(
        state.copyWith(
          selectedRow: event.selectedRow,
        ),
      );
    } else {
      emit(state.copyWith());
    }
  }

  Future<void> _onChangePage(
    ChangePage event,
    Emitter<AccordionTableState<T>> emit,
  ) async {
    onPageChanged?.call(
      event.page,
      state.numberOfRowsPerPage * (event.page + 1) - 1,
    );
    emit(state.copyWith(currentPage: event.page));
  }
}
