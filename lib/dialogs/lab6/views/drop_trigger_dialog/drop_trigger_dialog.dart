import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropTriggerDialog extends StatelessWidget {
  DropTriggerDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Удаление триггера",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'trigger_name',
            labelText: 'Название существующего триггера (пр: имя_бд.имя_триг)',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop(
          formKey.currentState?.fields['trigger_name']?.value,
        ),
      );
}
