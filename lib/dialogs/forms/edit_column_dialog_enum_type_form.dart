import 'package:dblabs/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EditColumnDialogEnumTypeForms extends StatelessWidget {
  const EditColumnDialogEnumTypeForms({super.key});

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<EditColumnDialogFormBloc>();

    return Column(
      children: [
        TextFieldBlocBuilder(
          textFieldBloc: formBloc.enumValues,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Допустимые значения',
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
