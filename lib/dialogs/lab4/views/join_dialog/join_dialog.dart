import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class JoinDialog extends StatefulWidget {
  const JoinDialog({super.key});

  @override
  State<JoinDialog> createState() => _JoinDialogState();
}

class _JoinDialogState extends State<JoinDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  api.JoinType joinType = api.JoinType.INNER;

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Объединение",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'col_names',
            labelText: 'Названия столбцов (через запятую (можно с пробелом))',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'first_table_name',
            labelText: 'Название первой таблицы',
            isRequired: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'first_table_alias',
            labelText: 'Псевдоним первой таблицы',
            isRequired: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'second_table_name',
            labelText: 'Название второй таблицы',
            isRequired: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'second_table_alias',
            labelText: 'Псевдоним второй таблицы',
            isRequired: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'search_cond',
            labelText: 'Условие объединения (выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'where_cond',
            labelText: 'Фильтрование результата по условию (выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
        ],
        onSubmit: () => Navigator.of(context).pop<
            (
              List<String>,
              String,
              String,
              String,
              String,
              api.JoinType,
              String,
              String
            )>((
          formKey.currentState?.fields['col_names']?.value
                  .toString()
                  .split(',')
                  .toList() ??
              [],
          formKey.currentState?.fields['first_table_name']?.value ?? '',
          formKey.currentState?.fields['first_table_alias']?.value ?? '',
          formKey.currentState?.fields['second_table_name']?.value ?? '',
          formKey.currentState?.fields['second_table_alias']?.value ?? '',
          joinType,
          formKey.currentState?.fields['search_cond']?.value ?? '',
          formKey.currentState?.fields['where_cond']?.value ?? '',
        )),
      );
}
