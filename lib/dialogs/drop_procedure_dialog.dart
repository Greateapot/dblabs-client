import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DropProcedureDialogFormBloc extends FormBloc<String, String> {
  final procedureName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  DropProcedureDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      procedureName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.dropProcedure(
        procedureName: procedureName.value,
      );
      emitLoaded();
      emitSuccess(
          canSubmitAgain: true, successResponse: "Процедура удалена удален");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class DropProcedureDialog extends StatelessWidget {
  const DropProcedureDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropProcedureDialogFormBloc(),
        child: BaseDialog<DropProcedureDialogFormBloc>(
          title: "Удалить процедуру",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.procedureName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название существующей процедуры',
                  hintText: 'имя_бд.имя_проц',
                ),
              ),
            ],
          ),
        ),
      );
}
