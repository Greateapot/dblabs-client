import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'view.dart';

class AlterTableDialog extends StatefulWidget {
  const AlterTableDialog({super.key});

  @override
  State<AlterTableDialog> createState() => _AlterTableDialogState();
}

class _AlterTableDialogState extends State<AlterTableDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  final List<api.AlterTableOptionType> supportedTypes = [
    api.AlterTableOptionType.ADD_COLUMN,
    api.AlterTableOptionType.DROP_COLUMN,
    api.AlterTableOptionType.RENAME_COLUMN,
    api.AlterTableOptionType.CHANGE,
  ];

  api.AlterTableOptionType? type;

  @override
  Widget build(BuildContext context) => ActionDialog(
      title: "Изменить таблицу",
      formKey: formKey,
      forms: [
        FormBuilderDropdown<api.AlterTableOptionType>(
          name: 'type',
          items: supportedTypes
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
          initialValue: type,
          onChanged: (val) => type = val,
        ),
      ],
      onSubmit: () => switch (type) {
            api.AlterTableOptionType.ADD_COLUMN => Navigator.of(context)
                .pop((_) => const AlterTableAddColumnDialog()),
            api.AlterTableOptionType.DROP_COLUMN => Navigator.of(context)
                .pop((_) => const AlterTableDropColumnDialog()),
            api.AlterTableOptionType.RENAME_COLUMN => Navigator.of(context)
                .pop((_) => const AlterTableDropColumnDialog()),
            api.AlterTableOptionType.CHANGE =>
              Navigator.of(context).pop((_) => const AlterTableChangeDialog()),
            _ => null,
          });
}
