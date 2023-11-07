import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ShowTableStructDialog extends StatelessWidget {
  ShowTableStructDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Вывести структуру таблицы",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'database_name',
            labelText: 'Название существующей базы данных',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop((
          formKey.currentState?.fields['database_name']?.value,
          formKey.currentState?.fields['table_name']?.value,
        )),
      );
}
