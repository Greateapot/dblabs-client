import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DropViewDialogFormBloc extends FormBloc<String, String> {
  final viewName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  DropViewDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      viewName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.dropView(
        viewName: viewName.value,
      );
      emitLoaded();
      emitSuccess(
          canSubmitAgain: true, successResponse: "Представление удалено");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class DropViewDialog extends StatelessWidget {
  const DropViewDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DropViewDialogFormBloc(),
        child: BaseDialog<DropViewDialogFormBloc>(
          title: "Удалить представление",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.viewName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название существующего представления',
                  hintText: 'имя_бд.имя_пред',
                ),
              ),
            ],
          ),
        ),
      );
}
