import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateTriggerDialogFormBloc extends FormBloc<String, String> {
  final triggerName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final tableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final triggerBody = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  final triggerTime = SelectFieldBloc(
    items: api.TriggerTimeType.values,
    validators: [FieldBlocValidators.required],
  );
  final triggerEvent = SelectFieldBloc(
    items: api.TriggerEventType.values,
    validators: [FieldBlocValidators.required],
  );

  final triggerOrder = SelectFieldBloc(
    items: api.TriggerOrderType.values,
  );
  final triggerOrderOtherTriggerName = TextFieldBloc();

  CreateTriggerDialogFormBloc() {
    triggerOrderOtherTriggerName.updateValidators([customRequired]);
    addFieldBlocs(fieldBlocs: [
      triggerName,
      tableName,
      triggerBody,
      triggerTime,
      triggerEvent,
      triggerOrder,
      triggerOrderOtherTriggerName,
    ]);
  }

  Object? customRequired(String? value) =>
      triggerOrder.value == null ? null : FieldBlocValidators.required(value);

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.createTrigger(
        triggerName: triggerName.value,
        triggerBody: triggerBody.value,
        tableName: tableName.value,
        triggerEvent: triggerEvent.value!,
        triggerTime: triggerTime.value!,
        triggerOrder: triggerOrder.value != null
            ? api.TriggerOrder(
                type: triggerOrder.value,
                otherTriggerName: triggerOrderOtherTriggerName.value,
              )
            : null,
      );
      emitLoaded();
      emitSuccess(canSubmitAgain: true, successResponse: "Триггер создан");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class CreateTriggerDialog extends StatelessWidget {
  const CreateTriggerDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateTriggerDialogFormBloc(),
        child: BaseDialog<CreateTriggerDialogFormBloc>(
          title: "Создать триггер",
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
                  labelText: 'Название триггера',
                  hintText: 'имя_бд.имя_триг',
                ),
              ),
              DropdownFieldBlocBuilder<api.TriggerTimeType>(
                selectFieldBloc: formBloc.triggerTime,
                decoration: const InputDecoration(
                  labelText: 'Когда срабатывать',
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: switch (value) {
                    api.TriggerTimeType.BEFORE_EVENT =>
                      const Text("Перед событием"),
                    api.TriggerTimeType.AFTER_EVENT =>
                      const Text("После события"),
                    _ => throw UnimplementedError(),
                  },
                ),
              ),
              DropdownFieldBlocBuilder<api.TriggerEventType>(
                selectFieldBloc: formBloc.triggerEvent,
                decoration: const InputDecoration(
                  labelText: 'На какое сабытие',
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: switch (value) {
                    api.TriggerEventType.DELETE => const Text("Удаление"),
                    api.TriggerEventType.INSERT => const Text("Вставка"),
                    api.TriggerEventType.UPDATE => const Text("Обновление"),
                    _ => throw UnimplementedError(),
                  },
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.tableName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название существующей таблицы',
                  hintText: 'имя_бд.имя_табл',
                ),
              ),
              DropdownFieldBlocBuilder<api.TriggerOrderType>(
                selectFieldBloc: formBloc.triggerOrder,
                decoration: const InputDecoration(
                  labelText: 'Порядок выполнения',
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: switch (value) {
                    api.TriggerOrderType.FOLLOWS => const Text("После"),
                    api.TriggerOrderType.PRECEDES => const Text("Перед"),
                    _ => throw UnimplementedError(),
                  },
                ),
              ),
              BlocBuilder(
                bloc: formBloc.triggerOrder,
                builder: (context, _) => Visibility(
                  visible: formBloc.triggerOrder.value != null,
                  child: TextFieldBlocBuilder(
                    textFieldBloc: formBloc.triggerOrderOtherTriggerName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Название существующего триггера',
                      hintText: 'имя_бд.имя_табл',
                    ),
                  ),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.triggerBody,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Тело триггера',
                  hintText: 'пр: NEW.val = IF(NEW.val>100, OLD.val, NEW.val)',
                ),
              ),
            ],
          ),
        ),
      );
}
