import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  bool _rowCountHasError = false;
  int rowCount = 0;

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Удаление строк",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            name: 'table_name',
            labelText: 'Название существующей таблицы',
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'table_alias',
            labelText: 'Псевдоним таблицы',
            isRequired: false,
          ),
          const SizedBox(height: 16),
          buildTextFormBuilder(
            name: 'where_cond',
            labelText: 'Удаление по условию (выражение)',
            isRequired: false,
            isIdentifier: false,
          ),
          const SizedBox(height: 8),
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
            Navigator.of(context)
                .pop<(String, String, String, int)>((
              formKey.currentState?.fields['table_name']?.value ?? '',
              formKey.currentState?.fields['table_alias']?.value ?? '',
              formKey.currentState?.fields['where_cond']?.value ?? '',
              rowCount,
            ));
          }
        },
      );
}
