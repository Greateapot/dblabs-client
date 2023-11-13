import 'dart:async';

import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ShowTableStructDialogFormBloc extends FormBloc<String, String> {
  final databaseName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  ShowTableStructDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      databaseName,
      tableName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      api.Table table = await api.ApiRepository.instance.showTableStruct(
        databaseName: databaseName.value,
        tableName: tableName.value,
      );
      emitLoaded();
      TableBloc().add(TableEvent(table));
      emitSuccess();
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class ShowTableStructDialog extends StatelessWidget {
  const ShowTableStructDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ShowTableStructDialogFormBloc(),
        child: BaseDialog<ShowTableStructDialogFormBloc>(
          title: "Показать структуру таблицы",
          popOnSuccess: true,
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.databaseName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название существующей базы данных',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.tableName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название существующей таблицы',
                ),
              ),
            ],
          ),
        ),
      );
}
