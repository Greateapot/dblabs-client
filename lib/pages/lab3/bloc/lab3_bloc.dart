import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart';

part 'lab3_res.dart';
part 'lab3_event.dart';
part 'lab3_state.dart';

class Lab3Bloc extends Bloc<Lab3Event, Lab3State> {
  Lab3Bloc(this._apiRepository) : super(Lab3Initial()) {
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

  void _onLab3CreateTableEvent(
    Lab3CreateTableEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      await Lab3SqlQueries.createTable(_apiRepository);
      emit(Lab3Ok());
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }

  void _onLab3DropTableEvent(
    Lab3DropTableEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      await Lab3SqlQueries.dropTable(_apiRepository);
      emit(Lab3Ok());
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }

  void _onLab3FillTableEvent(
    Lab3FillTableEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      await Lab3SqlQueries.fillTable(_apiRepository);
      emit(Lab3Ok());
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }

  void _onLab3GetEmployeesEvent(
    Lab3GetEmployeesEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      Table table = await Lab3SqlQueries.getEmployees(_apiRepository);
      emit(Lab3Employees(table));
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }

  void _onLab3GetEmployeesPhoneNumbersAndSalaryEvent(
    Lab3GetEmployeesPhoneNumbersAndSalaryEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      Table table =
          await Lab3SqlQueries.getEmployeesPhoneNubersAndSalary(_apiRepository);
      emit(Lab3EmployeesPhoneNumbersAndSalary(table));
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }

  void _onLab3GetEmployeesSortedByAddressEvent(
    Lab3GetEmployeesSortedByAddressEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      Table table =
          await Lab3SqlQueries.getEmployeesSortedByAddress(_apiRepository);
      emit(Lab3EmployeesSortedByAddress(table));
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }

  void _onLab3FindEmployeesByWorkDurationEvent(
    Lab3FindEmployeesByWorkDurationEvent event,
    Emitter<Lab3State> emit,
  ) async {
    emit(Lab3Loading());
    try {
      Table table = await Lab3SqlQueries.getEmployeesFilteredByWorkDuration(
          _apiRepository);
      emit(Lab3EmployeesByWorkDuration(table));
    } on ApiException catch (exception) {
      emit(Lab3Error(exception));
    }
  }
}
