part of 'table_bloc.dart';

@immutable
sealed class TableState {
  const TableState();
}

final class TableInitial extends TableState {}

final class TableUpdated extends TableState {
  final api.Table table;

  const TableUpdated(this.table);
}
