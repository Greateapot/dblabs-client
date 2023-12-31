import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditColumnDialogFormBloc extends FormBloc<String, String> {
  final columnName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final dataType = SelectFieldBloc(
    items: api.DataTypeType.values,
    validators: [FieldBlocValidators.required],
  );
  final unsigned = BooleanFieldBloc();
  final autoIncrement = BooleanFieldBloc();
  final notNull = BooleanFieldBloc();

  final floatSize = TextFieldBloc();
  final stringSize = TextFieldBloc();
  final d = TextFieldBloc();
  final fsp = TextFieldBloc();
  final enumValues = TextFieldBloc();

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

  final void Function(api.Column column) callback;

  EditColumnDialogFormBloc(this.callback, [api.Column? column]) {
    if (column != null) {
      columnName.updateValue(column.columnName);
      dataType.updateValue(column.dataType.type);
      unsigned.updateValue(column.dataType.intAttrs.unsigned);
      autoIncrement.updateValue(column.dataType.intAttrs.autoIncrement);
      floatSize.updateValue(column.dataType.doubleAttrs.size.toString());
      stringSize.updateValue(column.dataType.stringAttrs.size.toString());
      d.updateValue(column.dataType.doubleAttrs.d.toString());
      fsp.updateValue(column.dataType.timeAttrs.fsp.toString());
      enumValues.updateValue(column.dataType.enumAttrs.values.join(', '));
      notNull.updateValue(column.notNull);
    }

    stringSize.updateValidators([stringValidator]);
    floatSize.updateValidators([floatValidator]);
    d.updateValidators([floatValidator]);
    fsp.updateValidators([timeValidator]);
    enumValues.updateValidators([enumValidator]);

    addFieldBlocs(fieldBlocs: [
      columnName,
      dataType,
      unsigned,
      autoIncrement,
      notNull,
      floatSize,
      stringSize,
      d,
      fsp,
    ]);
  }

  bool get isIntType => intTypes.contains(dataType.value);
  bool get isFloatType => floatTypes.contains(dataType.value);
  bool get isTimeType => timeTypes.contains(dataType.value);
  bool get isStringType => stringTypes.contains(dataType.value);
  bool get isEnumType => dataType.value == api.DataTypeType.ENUM;

  Object? numValidator(String? value) =>
      value != null && int.tryParse(value) == null
          ? "Это поле должно быть числом"
          : null;

  Object? floatValidator(String? value) =>
      isFloatType ? numValidator(value) : null;
  Object? timeValidator(String? value) =>
      isTimeType ? numValidator(value) : null;
  Object? stringValidator(String? value) =>
      isStringType ? numValidator(value) : null;

  Object? enumValidator(String? value) => isEnumType &&
          (value == null ||
              value
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e != "")
                  .isEmpty)
      ? "Это обязательное поле"
      : null;

  @override
  FutureOr<void> onSubmitting() {
    final c = api.Column(
      columnName: columnName.value,
      dataType: api.DataType(
        type: dataType.value,
        intAttrs: isIntType
            ? api.IntDataTypeAttrs(
                unsigned: unsigned.value,
                autoIncrement: autoIncrement.value,
              )
            : null,
        doubleAttrs: isFloatType
            ? api.DoubleDataTypeAttrs(
                size: floatSize.valueToInt,
                d: d.valueToInt,
              )
            : null,
        timeAttrs: isTimeType
            ? api.TimeDataTypeAttrs(
                fsp: fsp.valueToInt,
              )
            : null,
        stringAttrs: isStringType
            ? api.StringDataTypeAttrs(
                size: stringSize.valueToInt,
              )
            : null,
        enumAttrs: isEnumType
            ? api.EnumDataTypeAttrs(
                values: enumValues.value
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e != ""),
              )
            : null,
      ),
    );
    callback(c);
    emitSuccess(canSubmitAgain: true);
  }
}

class EditColumnDialog extends StatelessWidget {
  const EditColumnDialog({
    required this.callback,
    this.column,
    super.key,
  });

  final void Function(api.Column column) callback;
  final api.Column? column;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => EditColumnDialogFormBloc(callback, column),
        child: BaseDialog<EditColumnDialogFormBloc>(
          popOnSuccess: true,
          title: "Редактирование столбца",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.columnName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название столбца',
                ),
              ),
              DropdownFieldBlocBuilder<api.DataTypeType>(
                selectFieldBloc: formBloc.dataType,
                decoration: const InputDecoration(
                  labelText: 'Тип данных',
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value.name),
                ),
              ),
              CheckboxFieldBlocBuilder(
                booleanFieldBloc: formBloc.notNull,
                body: const Text("Не может принимать значение null"),
              ),
              BlocBuilder(
                bloc: formBloc.dataType,
                builder: (context, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: formBloc.isIntType,
                      child: Column(
                        children: [
                          CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.unsigned,
                            body: const Text("Беззнаковое"),
                          ),
                          CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.autoIncrement,
                            body: const Text("Автоматическое приращение"),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isFloatType,
                      child: Column(
                        children: [
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.floatSize,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Кол-во цифр в записи',
                            ),
                          ),
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.d,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Ко-во цифр после запятой',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isTimeType,
                      child: Column(
                        children: [
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.fsp,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Точность долей секунды',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isStringType,
                      child: Column(
                        children: [
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.stringSize,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Кол-во цифр в записи',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: formBloc.isEnumType,
                      child: Column(
                        children: [
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.enumValues,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Допустимые значения',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
