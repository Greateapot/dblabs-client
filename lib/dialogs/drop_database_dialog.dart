import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DropDatabaseDialogFormBloc extends FormBloc<String, String> {
  final databaseName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);


  DropDatabaseDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      databaseName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.dropDatabase(
        databaseName: databaseName.value,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "База данных удалена");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class DropDatabaseDialog extends StatelessWidget {
  const DropDatabaseDialog({super.key
  });

  

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropDatabaseDialogFormBloc(),
        child: BaseDialog<DropDatabaseDialogFormBloc>(
          title: "Удалить базу данных", bodyBuilder: (context, formBloc) => Column(mainAxisSize: MainAxisSize.min, children:  [
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
          ],),
        ),
      );
}
