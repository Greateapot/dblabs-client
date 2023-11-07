import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateDatabaseDialog extends StatelessWidget {
  CreateDatabaseDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Создание базы данных",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'database_name',
            labelText: 'Название новой базы данных',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop(
          formKey.currentState?.fields['database_name']?.value,
        ),
      );
}
