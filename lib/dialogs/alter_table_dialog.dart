import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

typedef Validator = Object? Function(String? value);

Validator orValidator(Validator v1, Validator v2) =>
    (String? value) => v1(value) ?? v2(value);

class AlterTableDialogFormBloc extends FormBloc<String, String> {
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final newColumnName = TextFieldBloc();
  final oldColumnName = TextFieldBloc();
  final columnName = TextFieldBloc();

  final type = SelectFieldBloc(
    items: [
      api.AlterTableOptionType.ADD_COLUMN,
      api.AlterTableOptionType.RENAME_COLUMN,
      api.AlterTableOptionType.DROP_COLUMN,
      api.AlterTableOptionType.CHANGE,
    ],
    validators: [FieldBlocValidators.required],
  );

  api.Column column = api.Column(
    columnName: "new_col",
    dataType: api.DataType(type: api.DataTypeType.INT),
  );

  AlterTableDialogFormBloc() {
    columnName.updateValidators([dropColumnValidator]);
    newColumnName.updateValidators([renameColumnValidator]);
    oldColumnName.updateValidators([
      orValidator(renameColumnValidator, changeValidator),
    ]);

    addFieldBlocs(fieldBlocs: [
      tableName,
      type,
      newColumnName,
      oldColumnName,
      columnName,
    ]);
  }

  bool get isColumnRequired =>
      type.value == api.AlterTableOptionType.ADD_COLUMN ||
      type.value == api.AlterTableOptionType.CHANGE;

  bool get isOldColumnNameRequired =>
      type.value == api.AlterTableOptionType.RENAME_COLUMN ||
      type.value == api.AlterTableOptionType.CHANGE;

  bool get isNewColumnNameRequired =>
      type.value == api.AlterTableOptionType.RENAME_COLUMN;

  bool get isColumnNameRequired =>
      type.value == api.AlterTableOptionType.DROP_COLUMN;

  void updateColumn(api.Column value) {
    column = value;
    tableName.updateValue(tableName.value);
  }

  Object? renameColumnValidator(String? value) =>
      type.value == api.AlterTableOptionType.RENAME_COLUMN && value == null
          ? "Это обязательное поле"
          : null;

  Object? dropColumnValidator(String? value) =>
      type.value == api.AlterTableOptionType.DROP_COLUMN && value == null
          ? "Это обязательное поле"
          : null;

  Object? changeValidator(String? value) =>
      type.value == api.AlterTableOptionType.CHANGE && value == null
          ? "Это обязательное поле"
          : null;

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.alterTable(
        tableName: tableName.value,
        options: [
          api.AlterTableOption(
            type: type.value,
            addColumn: type.value == api.AlterTableOptionType.ADD_COLUMN
                ? api.AddColumn(column: column)
                : null,
            renameColumn: type.value == api.AlterTableOptionType.RENAME_COLUMN
                ? api.RenameColumn(
                    newColumnName: newColumnName.value,
                    oldColumnName: oldColumnName.value,
                  )
                : null,
            dropColumn: type.value == api.AlterTableOptionType.DROP_COLUMN
                ? api.DropColumn(columnName: columnName.value)
                : null,
            change: type.value == api.AlterTableOptionType.CHANGE
                ? api.Change(
                    oldColumnName: oldColumnName.value,
                    newColumn: column,
                  )
                : null,
          ),
        ],
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Таблица изменена");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class AlterTableDialog extends StatelessWidget {
  const AlterTableDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AlterTableDialogFormBloc(),
        child: BaseDialog<AlterTableDialogFormBloc>(
          title: "Изменить таблицу",
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
                  labelText: 'Название существующей таблицы',
                  hintText: 'пр: имя_бд.имя_табл',
                ),
              ),
              DropdownFieldBlocBuilder(
                selectFieldBloc: formBloc.type,
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value.name),
                ),
              ),
              BlocBuilder(
                bloc: formBloc.type,
                builder: (context, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: formBloc.isColumnRequired,
                      child: ListTile(
                        leading: ElevatedButton(
                          child: const Icon(Icons.edit),
                          onPressed: () => context.go(
                            '/alterTable/editColumn',
                            extra: {
                              "callback": formBloc.column,
                              "column": formBloc.column
                            },
                          ),
                        ),
                        title: Text(formBloc.column.columnName),
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isOldColumnNameRequired,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.oldColumnName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Название существующего столбца',
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isNewColumnNameRequired,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.newColumnName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Новое название столбца',
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isColumnNameRequired,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.columnName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Название существующего столбца',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
