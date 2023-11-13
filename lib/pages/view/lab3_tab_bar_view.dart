import 'package:dblabs/pages/bloc/lab3_sql_queries.dart';
import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Lab3TabBarView extends StatelessWidget {
  const Lab3TabBarView({super.key});

  @override
  Widget build(BuildContext context) => ButtonsRow(buttons: [
        ButtonsRowElement(
          label: "Создать базу данных",
          onPressed: () => Lab3SqlQueries.createDatabase().then(
            (value) => context.go('/success'),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip: "CREATE DATABASE `Vozovikov`",
        ),
        ButtonsRowElement(
          label: "Удалить базу данных",
          onPressed: () => Lab3SqlQueries.dropDatabase().then(
            (value) => context.go('/success'),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip: "DROP DATABASE `Vozovikov`",
        ),
        ButtonsRowElement(
          label: "Создать таблицу",
          onPressed: () => Lab3SqlQueries.createTable().then(
            (value) => context.go('/success'),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip:
              "CREATE TABLE `Table_Vozovikov` (`id`, `last_name`, `first_name`, `patronymic`, `phone_number`, "
              "`address`, `salary`, `work_duration`)",
        ),
        ButtonsRowElement(
          label: "Удалить таблицу",
          onPressed: () => Lab3SqlQueries.dropTable().then(
            (value) => context.go('/success'),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip: "DROP TABLE `Table_Vozovikov`",
        ),
        ButtonsRowElement(
          label: "Добавить значения в таблицу",
          onPressed: () => Lab3SqlQueries.fillTable().then(
            (value) => context.go('/success'),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip:
              "INSERT INTO Table_Vozovikov(`id`, `last_name`, `first_name`, `patronymic`, `phone_number`, "
              "`address`, `salary`, `work_duration`) VALUES (...)",
        ),
        ButtonsRowElement(
          label: "Список сотрудников",
          onPressed: () => Lab3SqlQueries.getEmployees().then(
            (value) => TableBloc().add(TableEvent(value)),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip: "SELECT * FROM `Table_Vozovikov`",
        ),
        ButtonsRowElement(
          label: "Список номерамов и зарплат сотрудников",
          onPressed: () =>
              Lab3SqlQueries.getEmployeesPhoneNubersAndSalary().then(
            (value) => TableBloc().add(TableEvent(value)),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip:
              "SELECT `id`, `last_name`, `first_name`, `patronymic`, `phone_number`, `salary` FROM `Table_Vozovikov`",
        ),
        ButtonsRowElement(
          label: "Список адресов сотрудников (сорт. по адресу)",
          onPressed: () => Lab3SqlQueries.getEmployeesSortedByAddress().then(
            (value) => TableBloc().add(TableEvent(value)),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip:
              "SELECT `id`, `last_name`, `first_name`, `patronymic`, `address` FROM `Table_Vozovikov` ORDER BY `address`",
        ),
        ButtonsRowElement(
          label: "Список продолжительности работы сотрудников (п/р > 4)",
          onPressed: () =>
              Lab3SqlQueries.getEmployeesFilteredByWorkDuration().then(
            (value) => TableBloc().add(TableEvent(value)),
            onError: (error) => context.go('/failed', extra: error),
          ),
          tooltip:
              "SELECT `id`, `last_name`, `first_name`, `patronymic`, `work_duration` "
              "FROM `Table_Vozovikov` WHERE `work_duration` > 4",
        ),
      ]);
}
