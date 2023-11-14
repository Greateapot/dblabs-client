import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditProcedureParameterDialogFormBloc extends FormBloc<String, String> {
  final paramName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final type = SelectFieldBloc(
    items: api.ProcedureParameterType.values,
    validators: [FieldBlocValidators.required],
  );
  final dataType = SelectFieldBloc(
    items: api.DataTypeType.values,
    validators: [FieldBlocValidators.required],
  );
  final unsigned = BooleanFieldBloc();
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

  final void Function(api.ProcedureParameter parameter) callback;

  EditProcedureParameterDialogFormBloc(
    this.callback, [
    api.ProcedureParameter? parameter,
  ]) {
    if (parameter != null) {
      paramName.updateValue(parameter.paramName);
      type.updateValue(parameter.type);
      dataType.updateValue(parameter.dataType.type);
      unsigned.updateValue(parameter.dataType.intAttrs.unsigned);
      floatSize.updateValue(parameter.dataType.doubleAttrs.size.toString());
      stringSize.updateValue(parameter.dataType.stringAttrs.size.toString());
      d.updateValue(parameter.dataType.doubleAttrs.d.toString());
      fsp.updateValue(parameter.dataType.timeAttrs.fsp.toString());
      enumValues.updateValue(parameter.dataType.enumAttrs.values.join(', '));
    }

    stringSize.updateValidators([stringValidator]);
    floatSize.updateValidators([floatValidator]);
    d.updateValidators([floatValidator]);
    fsp.updateValidators([timeValidator]);
    enumValues.updateValidators([enumValidator]);

    addFieldBlocs(fieldBlocs: [
      paramName,
      type,
      dataType,
      unsigned,
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
    emitSuccess(canSubmitAgain: true);
    callback(api.ProcedureParameter(
      paramName: paramName.value,
      type: type.value,
      dataType: api.DataType(
        type: dataType.value,
        intAttrs: isIntType
            ? api.IntDataTypeAttrs(
                unsigned: unsigned.value,
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
    ));
  }
}

class EditProcedureParameterDialog extends StatelessWidget {
  const EditProcedureParameterDialog({
    required this.callback,
    this.parameter,
    super.key,
  });

  final void Function(api.ProcedureParameter column) callback;
  final api.ProcedureParameter? parameter;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) =>
            EditProcedureParameterDialogFormBloc(callback, parameter),
        child: BaseDialog<EditProcedureParameterDialogFormBloc>(
          popOnSuccess: true,
          title: "Редактирование столбца",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownFieldBlocBuilder<api.ProcedureParameterType>(
                selectFieldBloc: formBloc.type,
                decoration: const InputDecoration(
                  labelText: 'Тип параметра',
                ),
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value.name),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.paramName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название параметра',
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
              BlocBuilder(
                bloc: formBloc.dataType,
                builder: (context, _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: formBloc.isIntType,
                      child: CheckboxFieldBlocBuilder(
                        booleanFieldBloc: formBloc.unsigned,
                        body: const Text("Беззнаковое"),
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
