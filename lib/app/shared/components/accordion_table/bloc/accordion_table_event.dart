import 'package:equatable/equatable.dart';

abstract class AccordionTableEvent extends Equatable {
  const AccordionTableEvent();

  @override
  List<Object?> get props => [];
}

class SelectRow<T> extends AccordionTableEvent {
  const SelectRow({required this.selectedRow});

  final int? selectedRow;

  @override
  List<Object?> get props => [selectedRow];
}

class ChangePage extends AccordionTableEvent {
  const ChangePage({required this.page});

  final int page;

  @override
  List<Object?> get props => [page];
}
