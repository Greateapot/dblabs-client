import 'package:dblabs/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditColumnDialogStringTypeForms extends StatelessWidget {
  const EditColumnDialogStringTypeForms({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<EditColumnDialogFormBloc>();

    return Column(
      children: [
        TextFieldBlocBuilder(
          textFieldBloc: formBloc.stringSize,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Кол-во цифр в записи',
          ),
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
