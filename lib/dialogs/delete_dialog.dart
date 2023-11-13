import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DeleteDialogFormBloc extends FormBloc<String, String> {
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final tableAlias = TextFieldBloc();
  final whereCondition = TextFieldBloc();


  DeleteDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      tableName,
      tableAlias,
      whereCondition,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.delete(
        tableName: tableName.value,
        tableAlias: tableAlias.value,
        whereCondition: whereCondition.value,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Удаление успешно");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key
  });

  

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DeleteDialogFormBloc(),
        child: BaseDialog<DeleteDialogFormBloc>(
          title: "Удалить", bodyBuilder: (context, formBloc) => Column(mainAxisSize: MainAxisSize.min, children:  [
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
              textFieldBloc: formBloc.tableAlias,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Псевдоним таблицы',
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.whereCondition,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Выражение фильтрации удаляемых строк',
                hintText: 'пр: имя_табл.имя_кол > 4',
              ),
            ),
          ],),
        ),
      );
}
