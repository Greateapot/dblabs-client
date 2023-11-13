import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateDatabaseDialogFormBloc extends FormBloc<String, String> {
  final databaseName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  CreateDatabaseDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      databaseName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.createDatabase(
        databaseName: databaseName.value,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "База данных создана");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class CreateDatabaseDialog extends StatelessWidget {
  const CreateDatabaseDialog({super.key
  });

  

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateDatabaseDialogFormBloc(),
        child: BaseDialog<CreateDatabaseDialogFormBloc>(
          title: "Создать базу данных", bodyBuilder: (context, formBloc) => Column(mainAxisSize: MainAxisSize.min, children:  [
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.databaseName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Название новой базы данных',
              ),
            ),
          ],),
        ),
      );
}
