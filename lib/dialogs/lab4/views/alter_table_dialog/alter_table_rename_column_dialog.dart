import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AlterTableRenameColumnDialog extends StatefulWidget {
  const AlterTableRenameColumnDialog({super.key});

  @override
  State<AlterTableRenameColumnDialog> createState() =>
      _AlterTableRenameColumnDialogState();
}

class _AlterTableRenameColumnDialogState
    extends State<AlterTableRenameColumnDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Изменение таблицы: переименование столбца",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_табл)',
          ),
          buildTextFormBuilder(
            name: 'old_col_name',
            labelText: 'Текущее название столбца',
          ),
          buildTextFormBuilder(
            name: 'new_col_name',
            labelText: 'Новое название столбца',
          ),
        ],
        onSubmit: () =>
            Navigator.of(context).pop<(String, api.AlterTableOption)>((
          formKey.currentState?.fields['table_name']?.value,
          api.AlterTableOption(
            type: api.AlterTableOptionType.RENAME_COLUMN,
            renameColumn: api.RenameColumn(
              oldColumnName:
                  formKey.currentState?.fields['old_col_name']?.value,
              newColumnName:
                  formKey.currentState?.fields['new_col_name']?.value,
            ),
          ),
        )),
      );
}
