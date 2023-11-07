import 'package:bloc/bloc.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'create_table_dialog_event.dart';
part 'create_table_dialog_state.dart';

class CreateTableDialogBloc
    extends Bloc<CreateTableDialogEvent, CreateTableDialogState> {
  CreateTableDialogBloc([Map<String, api.Column>? columns])
      : super(CreateTableDialogInitial()) {
    on<AddColumnEvent>(_onAddColumnEvent);
    on<RemoveColumnEvent>(_onRemoveColumnEvent);
    on<UpdateColumnEvent>(_onUpdateColumnEvent);
    if (columns != null) this.columns.addAll(columns);
  }

  /// col_name: api.Column
  final Map<String, api.Column> columns = {};

  void _onAddColumnEvent(
    AddColumnEvent event,
    Emitter<CreateTableDialogState> emit,
  ) {
    columns[event.column.columnName] = event.column;
    emit(CreateTableDialogInitial());
  }

  void _onRemoveColumnEvent(
    RemoveColumnEvent event,
    Emitter<CreateTableDialogState> emit,
  ) {
    columns.remove(event.column.columnName);
    emit(CreateTableDialogInitial());
  }

  void _onUpdateColumnEvent(
    UpdateColumnEvent event,
    Emitter<CreateTableDialogState> emit,
  ) {
    columns[event.column.columnName] = event.column;
    emit(CreateTableDialogInitial());
  }
}
