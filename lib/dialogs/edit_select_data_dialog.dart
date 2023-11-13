import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditSelectDataDialogFormBloc extends FormBloc<String, String> {
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final columnNames = TextFieldBloc();
  final whereCondition = TextFieldBloc();

  final void Function(api.SelectData selectData) callback;

  EditSelectDataDialogFormBloc(this.callback, [api.SelectData? selectData]) {
    if (selectData != null) {
      tableName.updateValue(selectData.tableName);
      columnNames.updateValue(selectData.columnNames.join(', '));
      whereCondition.updateValue(selectData.whereCondition);
    }

    columnNames.updateValidators([columnNamesValidator]);

    addFieldBlocs(fieldBlocs: [
      tableName,
      columnNames,
      whereCondition,
    ]);
  }

  Object? columnNamesValidator(String? value) {
    if (value == null) {
      return "Это обязательное поле";
    }
    if (value.split(',').map((e) => e.trim()).where((e) => e != "").isEmpty) {
      return "Поле содержит ошибки";
    }
    return null;
  }

  @override
  FutureOr<void> onSubmitting() {
    callback(api.SelectData(
      tableName: tableName.value,
      columnNames: columnNames.value.split(',').map((e) => e.trim()),
      whereCondition: whereCondition.value,
    ));
    emitSuccess(canSubmitAgain: true);
  }
}

class EditSelectDataDialog extends StatelessWidget {
  const EditSelectDataDialog({
    required this.callback,
    this.selectData,
    super.key,
  });

  final void Function(api.SelectData column) callback;
  final api.SelectData? selectData;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => EditSelectDataDialogFormBloc(callback, selectData),
        child: BaseDialog<EditSelectDataDialogFormBloc>(
          title: "Редактирование выборки",
          popOnSuccess: true,
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
                  hintText: 'имя_бд.имя_табл',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.columnNames,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Названия столбцов (через запятую)',
                  hintText: 'имя_1_кол, имя_2_кол, ...',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.whereCondition,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Выражение фильтрации полученных строк',
                  hintText: 'пр: имя_кол > 4',
                ),
              ),
            ],
          ),
        ),
      );
}
