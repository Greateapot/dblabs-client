import 'package:bloc/bloc.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  static TableBloc? _isntance;

  TableBloc._() : super(TableInitial()) {
    on<TableEvent>((event, emit) => emit(TableUpdated(event.table)));
  }

  factory TableBloc() => _isntance ??= TableBloc._();

  @override
  Future<void> close() async {
    _isntance = null;
    super.close();
  }
}
