import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DropTableDialogFormBloc extends FormBloc<String, String> {
  final databaseName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);


  DropTableDialogFormBloc() {
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
      emitSuccess(canSubmitAgain: true, successResponse: "Таблица удалена");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class DropTableDialog extends StatelessWidget {
  const DropTableDialog({super.key
  });

  

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropTableDialogFormBloc(),
        child: BaseDialog<DropTableDialogFormBloc>(
          title: "Удалить таблицу", bodyBuilder: (context, formBloc) => Column(mainAxisSize: MainAxisSize.min, children:  [
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.databaseName,
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
        ),),
      );
}
