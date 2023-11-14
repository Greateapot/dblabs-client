import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateProcedureDialogFormBloc extends FormBloc<String, String> {
  final procedureName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final routineBody = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  final Map<String, api.ProcedureParameter> parameters = {};

  CreateProcedureDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      procedureName,
      routineBody,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.createProcedure(
        procedureName: procedureName.value,
        routineBody: routineBody.value,
        procedureParameters: parameters.values,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Процедура создана");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }

  void addParameter(api.ProcedureParameter parameter) {
    parameters[parameter.paramName] = parameter;
    updateCurrentStep(0);
    procedureName.emit(procedureName.state.copyWith(
      isValueChanged: true,
      isDirty: !procedureName.state.isDirty,
    ));
  }

  void removeParameter(String parameterName) {
    parameters.remove(parameterName);
    procedureName.emit(procedureName.state.copyWith(
      isValueChanged: true,
      isDirty: !procedureName.state.isDirty,
    ));
  }
}

class CreateProcedureDialog extends StatelessWidget {
  const CreateProcedureDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateProcedureDialogFormBloc(),
        child: BaseDialog<CreateProcedureDialogFormBloc>(
          title: "Создать процедуру",
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
                  labelText: 'Название новой процедуры',
                  hintText: 'имя_бд.имя_проц',
                ),
              ),
              BlocBuilder(
                bloc: formBloc.procedureName,
                builder: (context, state) => Column(
                  children: [
                    for (final entry in formBloc.parameters.entries)
                      ListTile(
                        leading: ElevatedButton(
                          child: const Icon(Icons.edit),
                          onPressed: () => context.go(
                            '/createProcedure/editProcedureParameter',
                            extra: {
                              "callback": (parameter) {
                                formBloc.removeParameter(entry.value.paramName);
                                formBloc.addParameter(parameter);
                              },
                              "parameter": entry.value,
                            },
                          ),
                        ),
                        title: Text(entry.key),
                        trailing: ElevatedButton(
                          child: const Icon(Icons.delete),
                          onPressed: () => formBloc.removeParameter(entry.key),
                        ),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text("Добавить параметр"),
                onPressed: () => context.go(
                  '/createProcedure/editProcedureParameter',
                  extra: {"callback": formBloc.addParameter},
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.routineBody,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'тело процедуры',
                  hintText: 'пр: SET @var = @var + 1',
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      );
}
