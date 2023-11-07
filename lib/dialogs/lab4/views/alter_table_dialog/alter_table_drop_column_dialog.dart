import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AlterTableDropColumnDialog extends StatefulWidget {
  const AlterTableDropColumnDialog({super.key});

  @override
  State<AlterTableDropColumnDialog> createState() =>
      _AlterTableDropColumnDialogState();
}

class _AlterTableDropColumnDialogState
    extends State<AlterTableDropColumnDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Изменение таблицы: удаление столбца",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_табл)',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'col_name',
            labelText: 'Название столбца',
          ),
        ],
        onSubmit: () =>
            Navigator.of(context).pop<(String, api.AlterTableOption)>((
          formKey.currentState?.fields['table_name']?.value,
          api.AlterTableOption(
            type: api.AlterTableOptionType.DROP_COLUMN,
            dropColumn: api.DropColumn(
              columnName: formKey.currentState?.fields['col_name']?.value,
            ),
          ),
        )),
      );
}
