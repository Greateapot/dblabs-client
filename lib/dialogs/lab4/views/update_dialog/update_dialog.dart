import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({super.key});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  bool _rowCountHasError = false;
  int rowCount = 0;
  bool desc = false;

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Обновление",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'kv',
            labelText:
                'Перечисление назначений (через запятую. пр: fieldA = 1, fieldB = fieldA + 1)',
            isRequired: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'where_cond',
            labelText: 'Удаление по условию (выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            autovalidateMode: AutovalidateMode.always,
            name: 'row_count',
            decoration: InputDecoration(
              border: formInputDecorationBorder,
              labelText: 'Макс. кол-во удаляемых строк',
              suffixIcon: _rowCountHasError
                  ? const Icon(Icons.error, color: Colors.red)
                  : const Icon(Icons.check, color: Colors.green),
            ),
            initialValue: rowCount.toString(),
            onChanged: (val) {
              setState(() {
                _rowCountHasError =
                    !(formKey.currentState?.fields['row_count']?.validate() ??
                        false);
                if (!_rowCountHasError && val != null) {
                  rowCount = int.tryParse(val) ?? rowCount;
                }
              });
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(),
              FormBuilderValidators.min(0),
            ]),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
        ],
        onSubmit: () {
          if (!_rowCountHasError) {
            Navigator.of(context).pop<
                (
                  String,
                  Map<String, String>,
                  String,
                  int,
                )>((
              formKey.currentState?.fields['table_name']?.value ?? '',
              Map.fromEntries(formKey.currentState?.fields['kv']?.value
                      .toString()
                      .split(',')
                      .map(
                        (e) => e.split('=').map((e) => e.trim()).toList(),
                      )
                      .map((e) => MapEntry(e.first, e.last))
                      .toList() ??
                  []),
              formKey.currentState?.fields['where_cond']?.value ?? '',
              rowCount,
            ));
          }
        },
      );
}
