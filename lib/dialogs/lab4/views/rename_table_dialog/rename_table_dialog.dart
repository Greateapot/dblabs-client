import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RenameTableDialog extends StatelessWidget {
  RenameTableDialog({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Переименовать таблицу",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'old_table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_табл)',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'new_table_name',
            labelText: 'Новое название таблицы (пр: имя_бд.имя_табл)',
          ),
        ],
        onSubmit: () => Navigator.of(context).pop((
          formKey.currentState?.fields['old_table_name']?.value,
          formKey.currentState?.fields['new_table_name']?.value,
        )),
      );
}
