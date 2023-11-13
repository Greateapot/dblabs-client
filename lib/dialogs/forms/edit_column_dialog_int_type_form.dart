import 'package:dblabs/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditColumnDialogIntTypeForms extends StatelessWidget {
  const EditColumnDialogIntTypeForms({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<EditColumnDialogFormBloc>();

    return Column(
      children: [
        CheckboxFieldBlocBuilder(
          booleanFieldBloc: formBloc.unsigned,
          body: const Text("Беззнаковое"),
        ),
        CheckboxFieldBlocBuilder(
          booleanFieldBloc: formBloc.autoIncrement,
          body: const Text("Автоматическое приращение"),
        ),
      ]
          .map((e) => Padding(
                padding: const EdgeInsets.all(8),
                child: e,
              ))
          .toList(),
    );
  }
}
