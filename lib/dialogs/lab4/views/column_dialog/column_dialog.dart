import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:form_builder_validators/form_builder_validators.dart';

class ColumnDialog extends StatefulWidget {
  const ColumnDialog({required this.column, super.key});

  final api.Column column;

  factory ColumnDialog.empty([Key? key]) => ColumnDialog(
        column: api.Column(
          columnName: "",
          dataType: api.DataType(type: api.DataTypeType.INT),
        ),
        key: key,
      );

  @override
  State<ColumnDialog> createState() => _ColumnDialogState();
}

class _ColumnDialogState extends State<ColumnDialog> {
  final formKey = GlobalKey<FormBuilderState>();

  bool _floatSizeHasError = false;
  bool _floatDHasError = false;
  bool _timeFspHasError = false;
  bool _strSizeHasError = false;

  final List<api.DataTypeType> intTypes = [
    api.DataTypeType.INT,
    api.DataTypeType.SMALLINT,
    api.DataTypeType.TINYINT,
    api.DataTypeType.MEDIUMINT,
    api.DataTypeType.BIGINT,
  ];

  final List<api.DataTypeType> floatTypes = [
    api.DataTypeType.FLOAT,
    api.DataTypeType.DOUBLE,
    api.DataTypeType.NUMERIC,
    api.DataTypeType.DECIMAL,
  ];

  final List<api.DataTypeType> timeTypes = [
    api.DataTypeType.DATETIME,
    api.DataTypeType.TIMESTAMP,
    api.DataTypeType.TIME,
  ];

  final List<api.DataTypeType> stringTypes = [
    api.DataTypeType.CHAR,
    api.DataTypeType.VARCHAR,
    api.DataTypeType.BINARY,
    api.DataTypeType.VARBINARY,
    api.DataTypeType.BLOB,
    api.DataTypeType.TEXT,
  ];

  late api.DataTypeType data_type_type = widget.column.dataType.type;
  late bool int_unsigned = widget.column.dataType.intAttrs.unsigned;
  late bool int_auto_inc = widget.column.dataType.intAttrs.autoIncrement;
  late int float_size = widget.column.dataType.doubleAttrs.size;
  late int float_d = widget.column.dataType.doubleAttrs.d;
  late int time_fsp = widget.column.dataType.timeAttrs.fsp;
  late int str_size = widget.column.dataType.stringAttrs.size;
  late bool not_null = widget.column.notNull;

  @override
  Widget build(BuildContext context) => ActionDialog(
        title: "Изменение столбца",
        formKey: formKey,
        forms: [
          buildTextFormBuilder(
            initialValue: widget.column.columnName,
            name: 'col_name',
            labelText: 'Название столбца',
          ),
          const SizedBox(height: 16),
          FormBuilderDropdown<api.DataTypeType>(
            name: 'data_type_type',
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(
              label: Text('Выберите тип данных'),
            ),
            initialValue: data_type_type,
            onChanged: (value) =>
                setState(() => data_type_type = value ?? data_type_type),
            items: api.DataTypeType.values
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e.name)),
                )
                .toList(),
          ),
          Visibility(
            visible: intTypes.contains(data_type_type),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                FormBuilderCheckbox(
                  name: 'int_unsigned',
                  initialValue: int_unsigned,
                  title: const Text('Беззнаковое'),
                  onChanged: (val) => int_unsigned = val ?? int_unsigned,
                ),
                const SizedBox(height: 16),
                FormBuilderCheckbox(
                  name: 'int_auto_inc',
                  initialValue: int_auto_inc,
                  title: const Text('Автоматическое приращение'),
                  onChanged: (val) => int_auto_inc = val ?? int_auto_inc,
                ),
              ],
            ),
          ),
          Visibility(
            visible: floatTypes.contains(data_type_type),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'float_size',
                  decoration: InputDecoration(
                    border: formInputDecorationBorder,
                    labelText: 'Кол-во цифр',
                    suffixIcon: _floatSizeHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  initialValue: float_size.toString(),
                  onChanged: (val) {
                    setState(() {
                      _floatSizeHasError = !(formKey
                              .currentState?.fields['float_size']
                              ?.validate() ??
                          false);
                      if (!_floatSizeHasError && val != null) {
                        float_size = int.tryParse(val) ?? float_size;
                      }
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.integer(),
                    FormBuilderValidators.max(70),
                    FormBuilderValidators.min(0),
                  ]),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'float_d',
                  decoration: InputDecoration(
                    border: formInputDecorationBorder,
                    labelText: 'Кол-во цифр после запятой',
                    suffixIcon: _floatDHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  initialValue: float_d.toString(),
                  onChanged: (val) {
                    setState(() {
                      _floatDHasError = !(formKey
                              .currentState?.fields['float_d']
                              ?.validate() ??
                          false);
                      if (!_floatDHasError && val != null) {
                        float_d = int.tryParse(val) ?? float_d;
                      }
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.integer(),
                    FormBuilderValidators.max(70),
                    FormBuilderValidators.min(0),
                  ]),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
          Visibility(
            visible: timeTypes.contains(data_type_type),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'time_fsp',
                  decoration: InputDecoration(
                    border: formInputDecorationBorder,
                    labelText: 'Точность долей секунды',
                    suffixIcon: _timeFspHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  initialValue: time_fsp.toString(),
                  onChanged: (val) {
                    setState(() {
                      _timeFspHasError = !(formKey
                              .currentState?.fields['time_fsp']
                              ?.validate() ??
                          false);
                      if (!_timeFspHasError && val != null) {
                        time_fsp = int.tryParse(val) ?? time_fsp;
                      }
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.integer(),
                    FormBuilderValidators.max(999),
                    FormBuilderValidators.min(0),
                  ]),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
          Visibility(
            visible: stringTypes.contains(data_type_type),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'str_size',
                  decoration: InputDecoration(
                    border: formInputDecorationBorder,
                    labelText: 'Длина столбца в символах',
                    suffixIcon: _strSizeHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  initialValue: str_size.toString(),
                  onChanged: (val) {
                    setState(() {
                      _strSizeHasError = !(formKey
                              .currentState?.fields['str_size']
                              ?.validate() ??
                          false);
                      if (!_strSizeHasError && val != null) {
                        str_size = int.tryParse(val) ?? str_size;
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
            ),
          ),
          Visibility(
            visible: data_type_type == api.DataTypeType.ENUM,
            child: buildTextFormBuilder(
              name: 'enum_values',
              labelText: 'Значения перечисления (через запятую: a,b,c,d...)',
            ),
          ),
          const SizedBox(height: 16),
          FormBuilderCheckbox(
            name: 'not_null',
            initialValue: not_null,
            title: const Text('Столбец НЕ может принимать значение null'),
            onChanged: (val) => not_null = val ?? not_null,
          ),
        ],
        onSubmit: () => Navigator.of(context).pop(
          api.Column(
            columnName:
                formKey.currentState?.fields['col_name']?.value.toString(),
            dataType: api.DataType(
              type: data_type_type,
              intAttrs: api.IntDataTypeAttrs(
                autoIncrement: int_auto_inc,
                unsigned: int_unsigned,
              ),
              doubleAttrs: api.DoubleDataTypeAttrs(
                d: float_d,
                size: float_size,
              ),
              timeAttrs: api.TimeDataTypeAttrs(fsp: time_fsp),
              stringAttrs: api.StringDataTypeAttrs(size: str_size),
              enumAttrs: api.EnumDataTypeAttrs(
                  values: formKey.currentState?.fields['enum_values']?.value
                      .toString()
                      .split(',')),
            ),
            notNull: not_null,
          ),
        ),
      );
}
