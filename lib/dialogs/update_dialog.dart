import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class UpdateDialogFormBloc extends FormBloc<String, String> {
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final setStatement = TextFieldBloc();
  final whereCondition = TextFieldBloc();

  UpdateDialogFormBloc() {
    setStatement.updateValidators([setStatementValidate]);
    addFieldBlocs(fieldBlocs: [
      tableName,
      setStatement,
      whereCondition,
    ]);
  }

  Object? setStatementValidate(String? value) {
    if (value == null) {
      return "Это обяательное поле";
    }
    final pairs = value.split(',').map(
          (e) => e.trim().split('=').map((e) => e.trim()),
        );
    if (pairs.isEmpty ||
        pairs.any((element) =>
            element.isEmpty ||
            element.length > 2 ||
            element.any((element) => element.isEmpty))) {
      return "Выражение содержит ошибки";
    }
    return null;
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.update(
        tableName: tableName.value,
        whereCondition: whereCondition.value,
        assignmentList: api.AssignmentList(assignments: [
          for (final MapEntry entry in setStatement.value
              .split(',')
              .map(
                (e) => e.trim().split('=').map((e) => e.trim()),
              )
              .map((e) => MapEntry(e.first, e.last)))
            api.Assignment(
              columnName: entry.key,
              value: api.Value(
                type: api.ValueType.VALUE_EXPR,
                expr: entry.value,
              ),
            ),
        ]),
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Обновление успешно");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => UpdateDialogFormBloc(),
        child: BaseDialog<UpdateDialogFormBloc>(
          title: "Обновить",
          bodyBuilder: (BuildContext context, UpdateDialogFormBloc formBloc) =>
              Column(
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
                textFieldBloc: formBloc.setStatement,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Выражение обновления',
                  hintText: 'имя_кол = знач, имя_кол = ..., ...',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.whereCondition,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Выражение фильтрации обновляемых значений',
                  hintText: 'пр (имя_кол - INT): имя_кол > 4',
                ),
              ),
            ],
          ),
        ),
      );
}
