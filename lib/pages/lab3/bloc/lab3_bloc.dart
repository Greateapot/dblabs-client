import 'package:bloc/bloc.dart';
import 'package:dblabs/shared/bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart';

part 'lab3_sql_queries.dart';
part 'lab3_event.dart';

class Lab3Bloc extends Bloc<Lab3Event, LabsState> {
  Lab3Bloc(this._apiRepository) : super(LabsInitial()) {
    on<Lab3CreateDatabaseEvent>(_onLab3CreateDatabaseEvent);
    on<Lab3DropDatabaseEvent>(_onLab3DropDatabaseEvent);
    on<Lab3CreateTableEvent>(_onLab3CreateTableEvent);
    on<Lab3DropTableEvent>(_onLab3DropTableEvent);
    on<Lab3FillTableEvent>(_onLab3FillTableEvent);
    on<Lab3GetEmployeesEvent>(_onLab3GetEmployeesEvent);
    on<Lab3GetEmployeesPhoneNumbersAndSalaryEvent>(
        _onLab3GetEmployeesPhoneNumbersAndSalaryEvent);
    on<Lab3GetEmployeesSortedByAddressEvent>(
        _onLab3GetEmployeesSortedByAddressEvent);
    on<Lab3FindEmployeesByWorkDurationEvent>(
        _onLab3FindEmployeesByWorkDurationEvent);
  }

  final ApiRepository _apiRepository;

  void _onLab3CreateDatabaseEvent(
    Lab3CreateDatabaseEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await Lab3SqlQueries.createDatabase(_apiRepository);
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3DropDatabaseEvent(
    Lab3DropDatabaseEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await Lab3SqlQueries.dropDatabase(_apiRepository);
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3CreateTableEvent(
    Lab3CreateTableEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await Lab3SqlQueries.createTable(_apiRepository);
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3DropTableEvent(
    Lab3DropTableEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await Lab3SqlQueries.dropTable(_apiRepository);
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3FillTableEvent(
    Lab3FillTableEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await Lab3SqlQueries.fillTable(_apiRepository);
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3GetEmployeesEvent(
    Lab3GetEmployeesEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await Lab3SqlQueries.getEmployees(_apiRepository);
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3GetEmployeesPhoneNumbersAndSalaryEvent(
    Lab3GetEmployeesPhoneNumbersAndSalaryEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table =
          await Lab3SqlQueries.getEmployeesPhoneNubersAndSalary(_apiRepository);
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3GetEmployeesSortedByAddressEvent(
    Lab3GetEmployeesSortedByAddressEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table =
          await Lab3SqlQueries.getEmployeesSortedByAddress(_apiRepository);
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab3FindEmployeesByWorkDurationEvent(
    Lab3FindEmployeesByWorkDurationEvent event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await Lab3SqlQueries.getEmployeesFilteredByWorkDuration(
          _apiRepository);
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }
}
