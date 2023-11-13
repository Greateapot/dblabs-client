import 'dart:async';

import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class JoinDialogFormBloc extends FormBloc<String, String> {
  final columnNames = TextFieldBloc();

  final firstTableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final secondTableName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final searchCondition = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  final firstTableAlias = TextFieldBloc();
  final secondTableAlias = TextFieldBloc();
  final whereCondition = TextFieldBloc();

  final joinType = SelectFieldBloc(
    initialValue: api.JoinType.INNER,
    items: api.JoinType.values,
    validators: [FieldBlocValidators.required],
  );

  JoinDialogFormBloc() {
    columnNames.updateValidators([columnNamesValidator]);
    addFieldBlocs(fieldBlocs: [
      columnNames,
      firstTableName,
      secondTableName,
      firstTableAlias,
      secondTableAlias,
      searchCondition,
      whereCondition,
    ]);
  }

  Object? columnNamesValidator(String? value) {
    if (value == null) {
      return "Это обязательное поле";
    }
    if (value.split(',').map((e) => e.trim()).where((e) => e != "").isEmpty) {
      return "Поле содержит ошибки";
    }
    return null;
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      final api.Table table = await api.ApiRepository.instance.join(
        firstTableName: firstTableName.value,
        firstTableAlias: firstTableAlias.value,
        secondTableName: secondTableName.value,
        secondTableAlias: secondTableAlias.value,
        columnNames: columnNames.value.split(',').map((e) => e.trim()),
        join: api.Join(
          joinType: joinType.value,
          joinSpecification: api.JoinSpecification(
            type: api.JoinSpecificationType.ON,
            searchCondition: searchCondition.value,
          ),
        ),
        whereCondition: whereCondition.value,
      );
      emitLoaded();
      TableBloc().add(TableEvent(table));
      emitSuccess(canSubmitAgain: true, successResponse: "Объединие успешно");
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class JoinDialog extends StatelessWidget {
  const JoinDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => JoinDialogFormBloc(),
        child: BaseDialog<JoinDialogFormBloc>(
          title: "Объединить",
          popOnSuccess: true,
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.firstTableName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название первой существующей таблицы',
                  hintText: 'имя_бд.имя_табл',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.firstTableAlias,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Псевдоним первой таблицы',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.secondTableName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название второй существующей таблицы',
                  hintText: 'имя_бд.имя_табл',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.secondTableAlias,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Псевдоним второй таблицы',
                ),
              ),
              DropdownFieldBlocBuilder(
                selectFieldBloc: formBloc.joinType,
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value.toString()),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.searchCondition,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Условие объединения (выражение)',
                  hintText: 'имя_1_табл.имя_кол = имя_2_табл.имя_кол',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.columnNames,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Названия столбцов (через запятую)',
                  hintText: 'имя_1_табл.имя_3_кол, имя_2_табл.имя_4_кол, ...',
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.whereCondition,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Выражение фильтрации полученных строк',
                  hintText: 'пр: имя_1_табл.имя_3_кол > 4',
                ),
              ),
            ],
          ),
        ),
      );
}
