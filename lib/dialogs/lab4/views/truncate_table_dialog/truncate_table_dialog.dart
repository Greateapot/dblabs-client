import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TruncateTableDialog extends StatelessWidget {
  TruncateTableDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Очистить таблицу",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_табл)',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop(
          formKey.currentState?.fields['table_name']?.value,
        ),
      );
}
