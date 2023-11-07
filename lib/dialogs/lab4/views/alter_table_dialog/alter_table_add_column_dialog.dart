import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AlterTableAddColumnDialog extends StatefulWidget {
  const AlterTableAddColumnDialog({super.key});

  @override
  State<AlterTableAddColumnDialog> createState() =>
      _AlterTableAddColumnDialogState();
}

class _AlterTableAddColumnDialogState extends State<AlterTableAddColumnDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  api.Column column = api.Column(
    columnName: "new_col",
    dataType: api.DataType(type: api.DataTypeType.INT),
  );

  bool insertFirst = false;

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Изменение таблицы: добавление столбца",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы (пр: имя_бд.имя_табл)',
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: ElevatedButton(
              child: const Icon(Icons.edit),
              onPressed: () => showActionDialog<api.Column>(
                context: context,
                builder: (_) => ColumnDialog(column: column),
                onData: (data) => setState(() => column = data),
              ),
            ),
            title: Text(column.columnName),
          ),
          const SizedBox(height: 16),
          FormBuilderCheckbox(
            name: 'insert',
            title: const Text("Вставить в начало"),
            initialValue: insertFirst,
            onChanged: (val) => insertFirst = val ?? insertFirst,
          ),
        ],
        onSubmit: () =>
            Navigator.of(context).pop<(String, api.AlterTableOption)>((
          formKey.currentState?.fields['table_name']?.value,
          api.AlterTableOption(
            type: api.AlterTableOptionType.ADD_COLUMN,
            addColumn: api.AddColumn(
              column: column,
              insert: insertFirst
                  ? api.InsertColumn(type: api.InsertColumnType.FIRST)
                  : null,
            ),
          ),
        )),
      );
}