import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateTableDialogFormBloc extends FormBloc<String, String> {
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final primaryKey = SelectFieldBloc(
    items: <String>[],
    validators: [FieldBlocValidators.required],
  );

  final Map<String, api.Column> columns = {};

  CreateTableDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      tableName,
      primaryKey,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.createTable(
        tableName: tableName.value,
        options: [
          for (final column in columns.values)
            api.CreateTableOption(
              type: api.CreateTableOptionType.COLUMN,
              column: column,
            ),
          if (primaryKey.value != null)
            api.CreateTableOption(
              type: api.CreateTableOptionType.PRIMARY_KEY,
              primaryKey: api.PrimaryKey(keyParts: [primaryKey.value!]),
            ),
        ],
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Таблица создана");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }

  void addColumn(api.Column column) {
    columns[column.columnName] = column;
    primaryKey.emit(primaryKey.state.copyWith(
      items: columns.keys.toList(),
      isValueChanged: true,
    ));
  }

  void removeColumn(String columnName) {
    columns.remove(columnName);
    primaryKey.emit(primaryKey.state.copyWith(
      items: columns.keys.toList(),
      isValueChanged: true,
    ));
  }
}

class CreateTableDialog extends StatelessWidget {
  const CreateTableDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateTableDialogFormBloc(),
        child: BaseDialog<CreateTableDialogFormBloc>(
          title: "Создать таблицу",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.tableName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название новой таблицы',
                  hintText: 'имя_бд.имя_табл',
                ),
              ),
              BlocBuilder(
                bloc: formBloc.primaryKey,
                builder: (context, state) => Visibility(
                  visible: formBloc.columns.isEmpty,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Должен быть хотя бы один столбец!",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              BlocBuilder(
                bloc: formBloc.primaryKey,
                builder: (context, state) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final entry in formBloc.columns.entries)
                      ListTile(
                        leading: ElevatedButton(
                          child: const Icon(Icons.edit),
                          onPressed: () => context.go(
                            '/createTable/editColumn',
                            extra: {
                              "callback": (api.Column column) {
                                formBloc.removeColumn(entry.value.columnName);
                                formBloc.addColumn(column);
                              },
                              "column": entry.value,
                            },
                          ),
                        ),
                        title: Text(entry.key),
                        trailing: ElevatedButton(
                          child: const Icon(Icons.delete),
                          onPressed: () => formBloc.removeColumn(entry.key),
                        ),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text("Добавить столбец"),
                onPressed: () => context.go(
                  '/createTable/editColumn',
                  extra: {
                    "callback": (api.Column column) {
                      debugPrint(
                        "asd${column.dataType.intAttrs.autoIncrement.toString()}",
                      );
                      formBloc.addColumn(column);
                    }
                  },
                ),
              ),
              BlocBuilder(
                bloc: formBloc.primaryKey,
                builder: (context, state) => formBloc.columns.isEmpty
                    ? const SizedBox.square(dimension: 0)
                    : DropdownFieldBlocBuilder(
                        decoration: const InputDecoration(
                          labelText: 'Первичный ключ',
                        ),
                        selectFieldBloc: formBloc.primaryKey,
                        itemBuilder: (context, value) =>
                            FieldItem(child: Text(value)),
                      ),
              ),
            ],
          ),
        ),
      );
}
