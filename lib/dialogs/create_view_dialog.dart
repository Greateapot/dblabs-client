import 'dart:async';

import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateViewDialogFormBloc extends FormBloc<String, String> {
  final viewName = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);
  final columnNames = TextFieldBloc(validators: [
    FieldBlocValidators.required,
  ]);

  final algorithm = SelectFieldBloc(
    items: api.ViewAlgorithmType.values,
  );
  final withCheckOption = SelectFieldBloc(
    items: api.ViewWithCheckOptionType.values,
  );
  final orReplace = BooleanFieldBloc();

  api.SelectData selectData = api.SelectData(columnNames: ['col_name']);

  CreateViewDialogFormBloc() {
    addFieldBlocs(fieldBlocs: [
      viewName,
      columnNames,
      algorithm,
      withCheckOption,
    ]);
  }

  void updateSelectData(api.SelectData value) {
    selectData = value;
    viewName.updateValue(viewName.value);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitLoading();
    try {
      await api.ApiRepository.instance.createView(
        viewName: viewName.value,
        selectData: selectData,
        algorithm: algorithm.value,
        columnList: columnNames.value.split(',').map((e) => e.trim()).toList(),
        withCheckOption: withCheckOption.value,
        orReplace: orReplace.value,
      );
      emitLoaded();
      emitSuccess(
        canSubmitAgain: true,
        successResponse: "Представление создано",
      );
    } catch (exception) {
      emitLoaded();
      emitFailure(failureResponse: exception.toString());
    }
  }
}

class CreateViewDialog extends StatelessWidget {
  const CreateViewDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateViewDialogFormBloc(),
        child: BaseDialog<CreateViewDialogFormBloc>(
          title: "Создать предстваление",
          bodyBuilder: (context, formBloc) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.viewName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Название нового предстваления',
                  hintText: 'имя_бд.имя_пред',
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
                  hintText: 'пр: имя_1_кол, имя_2_кол, ...',
                ),
              ),
              ListTile(
                leading: ElevatedButton(
                  child: const Icon(Icons.edit),
                  onPressed: () => context.go(
                    '/createView/editSelectData',
                    extra: {
                      "callback": formBloc.updateSelectData,
                      "selectData": formBloc.selectData
                    },
                  ),
                ),
                title: Text(
                  "Выборка: SELECT "
                  "${formBloc.selectData.columnNames.join(", ")}...",
                ),
              ),
              DropdownFieldBlocBuilder(
                decoration: const InputDecoration(
                  labelText: 'Алгоритм',
                ),
                selectFieldBloc: formBloc.algorithm,
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value.toString()),
                ),
              ),
              DropdownFieldBlocBuilder(
                decoration: const InputDecoration(
                  labelText: 'С условием проверки',
                ),
                selectFieldBloc: formBloc.withCheckOption,
                itemBuilder: (context, value) => FieldItem(
                  child: Text(value.toString()),
                ),
              ),
              CheckboxFieldBlocBuilder(
                booleanFieldBloc: formBloc.orReplace,
                body: const Text("Заменить если уже существует"),
              ),
            ],
          ),
        ),
      );
}
