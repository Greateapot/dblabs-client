import 'package:dblabs/pages/lab4/lab4.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dblabs/dialogs/lab4/lab4.dart';

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
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4ShowTableStruct(
                          databaseName: data.$1,
                          tableName: data.$2,
                        ),
                      ),
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
                label: "Изменить базу данных",
                onPressed: () => showActionDialog<(String, bool)>(
                  context: context,
                  builder: (_) => AlterDatabaseDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4AlterDatabase(
                          databaseName: data.$1,
                          readOnly: (data.$2
                              ? api.ReadOnly.ENABLED
                              : api.ReadOnly.DISABLED),
                        ),
                      ),
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
              ButtonsRowElement(
                label: "Создать таблицу",
                onPressed: () =>
                    showActionDialog<(String, List<api.Column>, String)>(
                  context: context,
                  builder: (_) => const CreateTableDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4CreateTable(
                          tableName: data.$1,
                          options: [
                            for (final c in data.$2)
                              api.CreateTableOption(
                                type: api.CreateTableOptionType.COLUMN,
                                column: c,
                              ),
                            api.CreateTableOption(
                              type: api.CreateTableOptionType.PRIMARY_KEY,
                              primaryKey: api.PrimaryKey(
                                keyParts: [data.$3],
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ),
              ButtonsRowElement(
                label: "Изменить таблицу",
                onPressed: () => showActionDialog<WidgetBuilder>(
                  context: context,
                  builder: (_) => const AlterTableDialog(),
                  onData: (data) =>
                      showActionDialog<(String, api.AlterTableOption)>(
                    context: context,
                    builder: data,
                    onData: (data) => context.read<Lab4Bloc>().add(
                          Lab4AlterTable(
                            tableName: data.$1,
                            options: [data.$2],
                          ),
                        ),
                  ),
                ),
              ),
              ButtonsRowElement(
                label: "Удалить таблицу",
                onPressed: () => showActionDialog<String>(
                  context: context,
                  builder: (_) => DropTableDialog(),
                  onData: (data) => context
                      .read<Lab4Bloc>()
                      .add(Lab4DropTable(tableName: data)),
                ),
              ),
              ButtonsRowElement(
                label: "Переимновать таблицу",
                onPressed: () => showActionDialog<(String, String)>(
                  context: context,
                  builder: (_) => RenameTableDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4RenameTable(
                          oldTableName: data.$1,
                          newTableName: data.$2,
                        ),
                      ),
                ),
              ),
              ButtonsRowElement(
                label: "Очистить таблицу",
                onPressed: () => showActionDialog<String>(
                  context: context,
                  builder: (_) => TruncateTableDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4TruncateTable(
                          tableName: data,
                        ),
                      ),
                ),
              ),
              ButtonsRowElement(
                label: "Удалить",
                onPressed: () =>
                    showActionDialog<(String, String, String, int)>(
                  context: context,
                  builder: (_) => const DeleteDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4Delete(
                          tableName: data.$1,
                          tableAlias: data.$2,
                          whereCondition: data.$3,
                          limit: data.$4,
                        ),
                      ),
                ),
              ),
              ButtonsRowElement(
                label: "Объединить",
                onPressed: () => showActionDialog<
                    (
                      List<String>,
                      String,
                      String,
                      String,
                      String,
                      api.JoinType,
                      String,
                      String,
                    )>(
                  context: context,
                  builder: (_) => const JoinDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4Join(
                          columnNames: data.$1,
                          firstTableName: data.$2,
                          firstTableAlias: data.$3,
                          secondTableName: data.$4,
                          secondTableAlias: data.$5,
                          join: api.Join(
                            joinType: data.$6,
                            joinSpecification: api.JoinSpecification(
                              type: api.JoinSpecificationType.ON,
                              searchCondition: data.$7,
                            ),
                          ),
                          whereCondition: data.$8,
                        ),
                      ),
                ),
              ),
              ButtonsRowElement(
                label: "Выбрать",
                onPressed: () => showActionDialog<
                    (
                      List<String>,
                      String,
                      String,
                      String,
                      String,
                      int,
                    )>(
                  context: context,
                  builder: (_) => const SelectDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4Select(
                          selectData: api.SelectData(
                            columnNames: data.$1,
                            tableName: data.$2,
                            whereCondition: data.$3,
                            groupByExpr: data.$4,
                            havingCondition: data.$5,
                            limit: data.$6,
                          ),
                        ),
                      ),
                ),
              ),
              ButtonsRowElement(
                label: "Обновить",
                onPressed: () => showActionDialog<
                    (
                      String,
                      Map<String, String>,
                      String,
                      int,
                    )>(
                  context: context,
                  builder: (_) => const UpdateDialog(),
                  onData: (data) => context.read<Lab4Bloc>().add(
                        Lab4Update(
                          tableName: data.$1,
                          whereCondition: data.$3,
                          limit: data.$4,
                          assignmentList: api.AssignmentList(
                            assignments: data.$2.entries.map(
                              (e) => api.Assignment(
                                columnName: e.key,
                                value: api.Value(
                                  type: api.ValueType.VALUE_EXPR,
                                  expr: e.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ]),
          ),
          const Expanded(child: LabsBlocBuilder<Lab4Bloc>()),
        ],
      );
}
