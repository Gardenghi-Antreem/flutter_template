import 'package:equatable/equatable.dart';

/// T represents the type of the payload data associated with the row,
class AccordionTableState<T> extends Equatable {
  const AccordionTableState({
    this.selectedRow,
    required this.currentPage,
    required this.pages,
    required this.numberOfRowsPerPage,
  });

  final int? selectedRow;
  final int currentPage;
  final int pages;
  final int numberOfRowsPerPage;

  @override
  List<Object?> get props => [selectedRow, currentPage];

  AccordionTableState<T> copyWith({int? selectedRow, int? currentPage}) {
    return AccordionTableState(
      selectedRow: selectedRow,
      currentPage: currentPage ?? this.currentPage,
      pages: this.pages,
      numberOfRowsPerPage: this.numberOfRowsPerPage,
    );
  }
}
