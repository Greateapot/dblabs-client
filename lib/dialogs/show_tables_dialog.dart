import 'dart:async';

import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ShowTablesDialogFormBloc extends FormBloc<String, String> {
  final databaseName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  ShowTablesDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      databaseName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      api.Table table = await api.ApiRepository.instance.showTables(
        databaseName: databaseName.value,
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

class ShowTablesDialog extends StatelessWidget {
  const ShowTablesDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ShowTablesDialogFormBloc(),
        child: BaseDialog<ShowTablesDialogFormBloc>(
          popOnSuccess: true,
          title: "Показать список таблиц",
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
            ],
          ),
        ),
      );
}
