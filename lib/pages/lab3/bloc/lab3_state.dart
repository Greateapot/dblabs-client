part of 'lab3_bloc.dart';

@immutable
sealed class Lab3State {
  const Lab3State();
}

final class Lab3Initial extends Lab3State {}

final class Lab3Ok extends Lab3State {}

final class Lab3Loading extends Lab3State {}

final class Lab3Error extends Lab3State {
  final ApiException exception;

  const Lab3Error(this.exception);
}

final class Lab3Employees extends Lab3State {
  final Table table;

  const Lab3Employees(this.table);
}

final class Lab3EmployeesPhoneNumbersAndSalary extends Lab3State {
  final Table table;

  const Lab3EmployeesPhoneNumbersAndSalary(this.table);
}

final class Lab3EmployeesSortedByAddress extends Lab3State {
  final Table table;

  const Lab3EmployeesSortedByAddress(this.table);
}

final class Lab3EmployeesByWorkDuration extends Lab3State {
  final Table table;

  const Lab3EmployeesByWorkDuration(this.table);
}
