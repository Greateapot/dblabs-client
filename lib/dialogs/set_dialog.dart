import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SetDialogFormBloc extends FormBloc<String, String> {
  final varName = TextFieldBloc();
  final expr = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  SetDialogFormBloc() {
    varName.updateValidators([varNameValidator]);
    addFieldBlocs(fieldBlocs: [
      varName,
      expr,
    ]);
  }

  Object? varNameValidator(String? value) =>
      FieldBlocValidators.required(value) ??
      (!(value?.startsWith('@') ?? false)
          ? "Название переменной должно начинаться с символа @"
          : null);

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.set(
        varName: varName.value,
        expr: expr.value,
      );
      emitLoaded();
      emitSuccess(successResponse: "Переменная создана", canSubmitAgain: true);
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class SetDialog extends StatelessWidget {
  const SetDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => SetDialogFormBloc(),
        child: BaseDialog<SetDialogFormBloc>(
          title: "Создать переменную",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.varName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название новой переменной',
                  hintText: "пр: @myVar",
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.expr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Выражение',
                  hintText: "пр: 1, 0xFF, \"str\", ...",
                ),
              ),
            ],
          ),
        ),
      );
}
