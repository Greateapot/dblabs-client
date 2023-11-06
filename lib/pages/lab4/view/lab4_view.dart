import 'package:dblabs/pages/lab4/lab4.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lab4View extends StatelessWidget {
  const Lab4View({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 60,
            child: ButtonsRow(buttonValues: [
              ButtonsRowElement(
                label: "Вывести список баз данных",
                onPressed: () =>
                    context.read<Lab4Bloc>().add(const Lab4ShowDatabases()),
              ),
              ButtonsRowElement(
                label: "Вывести список таблиц",
                onPressed: () => showActionDialog<String>(
                  context: context,
                  builder: (_) => ShowTablesDialog(),
                  onData: (data) => context
                      .read<Lab4Bloc>()
                      .add(Lab4ShowTables(databaseName: data)),
                ),
              ),
              ButtonsRowElement(
                label: "Вывести структуру таблицы",
                onPressed: () => showActionDialog<(String, String)>(
                  context: context,
                  builder: (_) => ShowTableStructDialog(),
                  onData: (data) =>
                      context.read<Lab4Bloc>().add(Lab4ShowTableStruct(
                            databaseName: data.$1,
                            tableName: data.$2,
                          )),
                ),
              ),
              ButtonsRowElement(
                label: "Создать базу данных",
                onPressed: () => showActionDialog<String>(
                  context: context,
                  builder: (_) => CreateDatabaseDialog(),
                  onData: (data) => context
                      .read<Lab4Bloc>()
                      .add(Lab4CreateDatabase(databaseName: data)),
                ),
              ),
              ButtonsRowElement(
                label: "Удалить базу данных",
                onPressed: () => showActionDialog<String>(
                  context: context,
                  builder: (_) => DropDatabaseDialog(),
                  onData: (data) => context
                      .read<Lab4Bloc>()
                      .add(Lab4DropDatabase(databaseName: data)),
                ),
              ),
            ]),
          ),
          const Expanded(child: LabsBlocBuilder<Lab4Bloc>()),
        ],
      );
}
