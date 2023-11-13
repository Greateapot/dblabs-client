import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Lab4TabBarView extends StatelessWidget {
  const Lab4TabBarView({super.key});

  void showDatabases(BuildContext context) async =>
      await api.ApiRepository.instance.showDatabases().then(
            (value) => TableBloc().add(TableEvent(value)),
            onError: (error) => context.go('/failed', extra: error),
          );

  void select(BuildContext context, api.SelectData selectData) async =>
      await api.ApiRepository.instance.select(selectData: selectData).then(
            (value) => TableBloc().add(TableEvent(value)),
            onError: (error) => context.go('/failed', extra: error),
          );

  @override
  Widget build(BuildContext context) => ButtonsRow(buttons: [
        ButtonsRowElement(
          label: "Вывести список баз данных",
          onPressed: () => showDatabases(context),
        ),
        ButtonsRowElement(
          label: "Вывести список таблиц",
          onPressed: () => context.go('/showTables'),
        ),
        ButtonsRowElement(
          label: "Вывести структуру таблицы",
          onPressed: () => context.go('/showTableStruct'),
        ),
        ButtonsRowElement(
          label: "Создать базу данных",
          onPressed: () => context.go('/createDatabase'),
        ),
        ButtonsRowElement(
          label: "Изменить базу данных",
          onPressed: () => context.go('/alterDatabase'),
        ),
        ButtonsRowElement(
          label: "Удалить базу данных",
          onPressed: () => context.go('/dropDatabase'),
        ),
        ButtonsRowElement(
          label: "Создать таблицу",
          onPressed: () => context.go('/createTable'),
        ),
        ButtonsRowElement(
          label: "Изменить таблицу",
          onPressed: () => context.go('/alterTable'),
        ),
        ButtonsRowElement(
          label: "Удалить таблицу",
          onPressed: () => context.go('/dropTable'),
        ),
        ButtonsRowElement(
          label: "Переимновать таблицу",
          onPressed: () => context.go('/renameTable'),
        ),
        ButtonsRowElement(
          label: "Очистить таблицу",
          onPressed: () => context.go('/truncateTable'),
        ),
        ButtonsRowElement(
          label: "Удалить",
          onPressed: () => context.go('/delete'),
        ),
        ButtonsRowElement(
          label: "Обновить",
          onPressed: () => context.go('/update'),
        ),
        ButtonsRowElement(
          label: "Объединить",
          onPressed: () => context.go('/join'),
        ),
        ButtonsRowElement(
          label: "Выбрать",
          onPressed: () => context.go(
            '/editSelectData',
            extra: {"callback": (selectData) => select(context, selectData)},
          ),
        ),
      ]);
}
