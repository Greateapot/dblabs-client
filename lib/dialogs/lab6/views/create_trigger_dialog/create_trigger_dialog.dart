import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateTriggerDialog extends StatefulWidget {
  const CreateTriggerDialog({super.key});

  @override
  State<CreateTriggerDialog> createState() => _CreateTriggerDialogState();
}

class _CreateTriggerDialogState extends State<CreateTriggerDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Создание триггера",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'trigger_name',
            labelText: 'Название существующего триггера (пр: имя_бд.имя_триг)',
          ),
          const SizedBox(height: 16),
          FormBuilderDropdown<api.TriggerTimeType>(
            name: 'trigger_time',
            initialValue: api.TriggerTimeType.BEFORE_EVENT,
            items: api.TriggerTimeType.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            validator: FormBuilderValidators.required<api.TriggerTimeType>(),
          ),
          const SizedBox(height: 16),
          FormBuilderDropdown<api.TriggerEventType>(
            name: 'trigger_event',
            initialValue: api.TriggerEventType.UPDATE,
            items: api.TriggerEventType.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            validator: FormBuilderValidators.required<api.TriggerEventType>(),
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_табл)',
          ),
          const SizedBox(height: 16),
          FormBuilderDropdown<api.TriggerOrderType?>(
            name: 'trigger_order_type',
            initialValue: null,
            items: [...api.TriggerOrderType.values, null]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e != null ? e.toString() : "--"),
                    ))
                .toList(),
            onChanged: (_) => setState(() {}),
          ),
          Visibility(
            visible:
                formKey.currentState?.fields['trigger_order_type']?.value !=
                    null,
            child: Column(children: [
              const SizedBox(height: 16),
              buildTextFormBuilder(
                name: 'trigger_order_other_trigger_name',
                labelText: 'Название другого существующего триггера',
              ),
            ]),
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'trigger_body',
            labelText: 'Тело триггера (пр: SET NEW.val = '
                'IF(NEW.val>10,OLD.val,NEW.val))',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop<
            (
              String,
              api.TriggerTimeType,
              api.TriggerEventType,
              String,
              api.TriggerOrderType?,
              String?,
              String,
            )>((
          formKey.currentState?.fields['trigger_name']?.value as String,
          formKey.currentState?.fields['trigger_time']?.value
              as api.TriggerTimeType,
          formKey.currentState?.fields['trigger_event']?.value
              as api.TriggerEventType,
          formKey.currentState?.fields['table_name']?.value as String,
          formKey.currentState?.fields['trigger_order_type']?.value
              as api.TriggerOrderType?,
          formKey.currentState?.fields['trigger_order_other_trigger_name']
              ?.value as String?,
          formKey.currentState?.fields['trigger_body']?.value as String,
        )),
      );
}
