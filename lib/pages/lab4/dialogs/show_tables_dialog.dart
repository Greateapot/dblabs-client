import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ShowTablesDialog extends StatelessWidget {
  ShowTablesDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Вывести список таблиц",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'database_name',
            labelText: 'Название существующей базы данных',
          ),
        ],
        onSubmit: () => Navigator.of(context)
            .pop(formKey.currentState?.getRawValue<String>('database_name')),
      );
}
