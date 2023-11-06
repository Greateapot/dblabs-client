part of 'lab3_bloc.dart';

@immutable
sealed class Lab3Event {}

final class Lab3CreateTableEvent extends Lab3Event {}

final class Lab3DropTableEvent extends Lab3Event {}

final class Lab3FillTableEvent extends Lab3Event {}

final class Lab3GetEmployeesEvent extends Lab3Event {}

final class Lab3GetEmployeesPhoneNumbersAndSalaryEvent extends Lab3Event {}

final class Lab3GetEmployeesSortedByAddressEvent extends Lab3Event {}

final class Lab3FindEmployeesByWorkDurationEvent extends Lab3Event {}
