import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SelectDialog extends StatefulWidget {
  const SelectDialog({super.key});

  @override
  State<SelectDialog> createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  bool _rowCountHasError = false;
  int rowCount = 0;

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Выборка",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'col_names',
            labelText: 'Названия столбцов (через запятую (можно с пробелом))',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'where',
            labelText: 'Выборка по условию (выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'group_by',
            labelText: 'Группировать по ... (идентификатор или выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'having',
            labelText: 'Содержит (выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            autovalidateMode: AutovalidateMode.always,
            name: 'row_count',
            decoration: InputDecoration(
              border: formInputDecorationBorder,
              labelText: 'Макс. кол-во выбираемых строк',
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
                  List<String>,
                  String,
                  String,
                  String,
                  String,
                  int,
                )>((
              formKey.currentState?.fields['col_names']?.value
                      .toString()
                      .split(',')
                      .toList() ??
                  [],
              formKey.currentState?.fields['table_name']?.value?? '',
              formKey.currentState?.fields['where']?.value?? '',
              formKey.currentState?.fields['group_by']?.value ?? '',
              formKey.currentState?.fields['having']?.value?? '',
              rowCount,
            ));
          }
        },
      );
}
