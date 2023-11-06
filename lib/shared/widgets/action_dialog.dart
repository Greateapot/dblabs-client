import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    required this.title,
    required this.forms,
    required this.formKey,
    required this.onSubmit,
    super.key,
  });

  final String title;
  final List<Widget> forms;
  final GlobalKey<FormBuilderState> formKey;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width / 2,
          child: SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  ...forms,
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Отмена'),
                        ),
                      ),
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.saveAndValidate() ??
                                false) onSubmit();
                          },
                          child: const Text('Подтвердить'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

const InputBorder formInputDecorationBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
);

FormBuilderTextField buildTextFormBuilder({
  required String name,
  required String labelText,
}) =>
    FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        border: formInputDecorationBorder,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: "Это поле не может быть пустым",
        ),
        FormBuilderValidators.match(
          identifierPattern,
          errorText: "Значение не является идентификатором",
        ),
      ]),
    );
