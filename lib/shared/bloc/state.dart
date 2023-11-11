part of 'bloc.dart';

@immutable
sealed class LabsState {
  const LabsState();
}

final class LabsInitial extends LabsState {}

final class LabsOk extends LabsState {}

final class LabsLoading extends LabsState {}

final class LabsApiError extends LabsState {
  final api.ApiException exception;

  const LabsApiError(this.exception);
}

final class LabsError extends LabsState {
  final Exception exception;

  const LabsError(this.exception);
}

final class LabsTable extends LabsState {
  final api.Table table;

  const LabsTable(this.table);
}
