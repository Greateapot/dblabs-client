import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AlterDatabaseDialogFormBloc extends FormBloc<String, String> {
  final databaseName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  final isReadOnly = BooleanFieldBloc(initialValue: false);

  AlterDatabaseDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      databaseName,
      isReadOnly,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.alterDatabase(
        databaseName: databaseName.value,
        readOnly:
            isReadOnly.value ? api.ReadOnly.ENABLED : api.ReadOnly.DISABLED,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "База данных изменена");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class AlterDatabaseDialog extends StatelessWidget {
  const AlterDatabaseDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AlterDatabaseDialogFormBloc(),
        child: BaseDialog<AlterDatabaseDialogFormBloc>(
          title: "Изменить базу данных",
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
              CheckboxFieldBlocBuilder(
                booleanFieldBloc: formBloc.isReadOnly,
                body: const Text("Только для чтения"),
              ),
            ],
          ),
        ),
      );
}
