import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DropTriggerDialogFormBloc extends FormBloc<String, String> {
  final triggerName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  DropTriggerDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      triggerName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.dropTrigger(
        triggerName: triggerName.value,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Триггер удален");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class DropTriggerDialog extends StatelessWidget {
  const DropTriggerDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropTriggerDialogFormBloc(),
        child: BaseDialog<DropTriggerDialogFormBloc>(
          title: "Удалить триггер",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.triggerName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название существующего триггера',
                  hintText: 'имя_бд.имя_триг',
                ),
              ),
            ],
          ),
        ),
      );
}
