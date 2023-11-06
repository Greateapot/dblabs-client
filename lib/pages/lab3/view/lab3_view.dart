import 'package:dblabs/pages/lab3/lab3.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lab3View extends StatelessWidget {
  const Lab3View({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 60,
            child: ButtonsRow(
              buttonValues: [
                ButtonsRowElement(
                  label: "Создать базу данных",
                  onPressed: () =>
                      context.read<Lab3Bloc>().add(Lab3CreateDatabaseEvent()),
                  tooltip:
                      "CREATE DATABASE `Vozovikov`",
                ),
                ButtonsRowElement(
                  label: "Удалить базу данных",
                  onPressed: () =>
                      context.read<Lab3Bloc>().add(Lab3DropDatabaseEvent()),
                  tooltip:
                      "DROP DATABASE `Vozovikov`",
                ),
                ButtonsRowElement(
                  label: "Создать таблицу",
                  onPressed: () =>
                      context.read<Lab3Bloc>().add(Lab3CreateTableEvent()),
                  tooltip:
                      "CREATE TABLE `Table_Vozovikov` (`id`, `last_name`, `first_name`, `patronymic`, `phone_number`, `address`, `salary`, `work_duration`)",
                ),
                ButtonsRowElement(
                  label: "Удалить таблицу",
                  onPressed: () =>
                      context.read<Lab3Bloc>().add(Lab3DropTableEvent()),
                  tooltip: "DROP TABLE `Table_Vozovikov`",
                ),
                ButtonsRowElement(
                  label: "Добавить значения в таблицу",
                  onPressed: () =>
                      context.read<Lab3Bloc>().add(Lab3FillTableEvent()),
                  tooltip:
                      "INSERT INTO Table_Vozovikov(`id`, `last_name`, `first_name`, `patronymic`, `phone_number`, `address`, `salary`, `work_duration`) VALUES (...)",
                ),
                ButtonsRowElement(
                  label: "Список сотрудников",
                  onPressed: () =>
                      context.read<Lab3Bloc>().add(Lab3GetEmployeesEvent()),
                  tooltip: "SELECT * FROM `Table_Vozovikov`",
                ),
                ButtonsRowElement(
                  label: "Список номерамов и зарплат сотрудников",
                  onPressed: () => context
                      .read<Lab3Bloc>()
                      .add(Lab3GetEmployeesPhoneNumbersAndSalaryEvent()),
                  tooltip:
                      "SELECT `id`, `last_name`, `first_name`, `patronymic`, `phone_number`, `salary` FROM `Table_Vozovikov`",
                ),
                ButtonsRowElement(
                  label: "Список адресов сотрудников (сорт. по адресу)",
                  onPressed: () => context
                      .read<Lab3Bloc>()
                      .add(Lab3GetEmployeesSortedByAddressEvent()),
                  tooltip:
                      "SELECT `id`, `last_name`, `first_name`, `patronymic`, `address` FROM `Table_Vozovikov` ORDER BY `address`",
                ),
                ButtonsRowElement(
                  label:
                      "Список продолжительности работы сотрудников (п/р > 4)",
                  onPressed: () => context
                      .read<Lab3Bloc>()
                      .add(Lab3FindEmployeesByWorkDurationEvent()),
                  tooltip:
                      "SELECT `id`, `last_name`, `first_name`, `patronymic`, `work_duration` FROM `Table_Vozovikov` WHERE `work_duration` > 4",
                ),
              ],
            ),
          ),
          const Expanded(child: LabsBlocBuilder<Lab3Bloc>()),
        ],
      );
}
