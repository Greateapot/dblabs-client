import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CallProcedureDialogFormBloc extends FormBloc<String, String> {
  final expr = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  CallProcedureDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      expr,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.callProcedure(
        expr: expr.value,
      );
      emitLoaded();
      emitSuccess(
        canSubmitAgain: true,
        successResponse: "Выражение выполнено(?)",
      );
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class CallProcedureDialog extends StatelessWidget {
  const CallProcedureDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CallProcedureDialogFormBloc(),
        child: BaseDialog<CallProcedureDialogFormBloc>(
          title: "Выполнить(?) выражение (процедуру)",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.expr,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Выражение',
                  hintText: 'пр: имя_бд.имя_проц(парам1, парам2, ...)',
                ),
              ),
            ],
          ),
        ),
      );
}
