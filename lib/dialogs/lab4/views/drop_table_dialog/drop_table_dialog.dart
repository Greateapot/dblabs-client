import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropTableDialog extends StatelessWidget {
  DropTableDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Удаление таблицы",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_таблицы)',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop(
          formKey.currentState?.fields['table_name']?.value,
        ),
      );
}
