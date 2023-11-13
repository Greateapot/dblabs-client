import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RenameTableDialogFormBloc extends FormBloc<String, String> {
  final oldTableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final newTableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  RenameTableDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      oldTableName,
      newTableName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.renameTable(
        oldTableName: oldTableName.value,
        newTableName: newTableName.value,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Таблица переименована");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class RenameTableDialog extends StatelessWidget {
  const RenameTableDialog({super.key
  });

  

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => RenameTableDialogFormBloc(),
        child: BaseDialog<RenameTableDialogFormBloc>(
          title: "Переимновать таблицу",
          bodyBuilder: (context, formBloc) => Column(mainAxisSize: MainAxisSize.min, children: [
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.oldTableName,
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
              textFieldBloc: formBloc.newTableName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Новое название таблицы',
                hintText: 'имя_бд.имя_табл',
              ),
            ),
          ],),
        ),
      );
}
