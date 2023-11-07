import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateTableView extends StatefulWidget {
  const CreateTableView({super.key});

  @override
  State<CreateTableView> createState() => _CreateTableViewState();
}

class _CreateTableViewState extends State<CreateTableView> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreateTableDialogBloc, CreateTableDialogState>(
        builder: (context, state) {
          final bloc = context.read<CreateTableDialogBloc>();
          final isEnoughElements = bloc.columns.isNotEmpty;
          return ActionDialog(
              title: "Создать таблицу",
              formKey: formKey,
              forms: [
                buildTextFormBuilder(
                  name: 'table_name',
                  labelText: 'Название таблицы (пр: имя_бд.имя_табл)',
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !isEnoughElements,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Должен быть хотя бы один столбец!",
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showActionDialog<api.Column>(
                    context: context,
                    builder: (_) => ColumnDialog.empty(),
                    onData: (data) => context
                        .read<CreateTableDialogBloc>()
                        .add(AddColumnEvent(data)),
                  ),
                  child: const Text("Добавить столбец"),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      itemCount: bloc.columns.values.length,
                      itemBuilder: (context, index) {
                        final element = bloc.columns.values.elementAt(index);
                        return ListTile(
                          leading: ElevatedButton(
                            child: const Icon(Icons.edit),
                            onPressed: () => showActionDialog<api.Column>(
                              context: context,
                              builder: (_) => ColumnDialog(column: element),
                              onData: (data) =>
                                  bloc.add(UpdateColumnEvent(data)),
                            ),
                          ),
                          title: Text(element.columnName),
                          trailing: ElevatedButton(
                            child: const Icon(Icons.delete),
                            onPressed: () =>
                                bloc.add(RemoveColumnEvent(element)),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'primary_key',
                  decoration: const InputDecoration(
                    label: Text('Выберите тип данных'),
                  ),
                  items: context
                      .read<CreateTableDialogBloc>()
                      .columns
                      .keys
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
              ],
              onSubmit: () {
                if (isEnoughElements) {
                  Navigator.of(context)
                      .pop<(String, List<api.Column>, String)>((
                    formKey.currentState?.fields['table_name']?.value,
                    bloc.columns.values.toList(),
                    formKey.currentState?.fields['primary_key']?.value,
                  ));
                }
              });
        },
      );
}
