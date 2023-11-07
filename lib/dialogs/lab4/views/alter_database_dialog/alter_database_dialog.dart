import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AlterDatabaseDialog extends StatelessWidget {
  AlterDatabaseDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Изменение базы данных",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'database_name',
            labelText: 'Название существующей базы данных',
          ),
          const SizedBox(height: 16),
          FormBuilderCheckbox(
            name: 'read_only',
            title: const Text("Только для чтения"),
            initialValue: false,
          ),
        ],
        onSubmit: () => Navigator.of(context).pop((
          formKey.currentState?.fields['database_name']?.value,
          formKey.currentState?.fields['read_only']?.value,
        )),
      );
}
