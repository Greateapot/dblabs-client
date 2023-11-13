import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TruncateTableDialogFormBloc extends FormBloc<String, String> {
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  TruncateTableDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      tableName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.truncateTable(
        tableName: tableName.value,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Таблица очищена");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class TruncateTableDialog extends StatelessWidget {
  const TruncateTableDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TruncateTableDialogFormBloc(),
        child: BaseDialog<TruncateTableDialogFormBloc>(
          title: "Очистить таблицу",
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
            ],
          ),
        ),
      );
}
