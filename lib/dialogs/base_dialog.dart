import 'package:dblabs/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:go_router/go_router.dart';

class BaseDialog<DialogFormBloc extends FormBloc<String, String>>
    extends StatelessWidget {
  const BaseDialog({
    required this.title,
    required this.bodyBuilder,
    this.popOnSuccess = false,
    super.key,
  });

  final bool popOnSuccess;

  final Widget Function(
    BuildContext context,
    DialogFormBloc formBloc,
  ) bodyBuilder;
  final String title;

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<DialogFormBloc>(context);
    final size = MediaQuery.of(context).size;

    return FormBlocListener<DialogFormBloc, String, String>(
      onSubmitting: (context, state) {
        if (!popOnSuccess) {
          LoadingDialog.show(context);
        }
      },
      onLoaded: (context, state) {
        LoadingDialog.hide(context);
      },
      onSuccess: (context, state) {
        if (popOnSuccess) {
          if (context.canPop()) context.pop();
        } else {
          context.go(
            '/${GoRouterState.of(context).path}/success',
            extra: state.successResponse,
          );
        }
      },
      onFailure: (context, state) {
        context.go(
          '/${GoRouterState.of(context).path}/failed',
          extra: state.failureResponse,
        );
      },
      child: ScrollableFormBlocManager(
        formBloc: formBloc,
        child: Container(
          constraints: BoxConstraints(maxWidth: size.width / 2),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                bodyBuilder(context, formBloc),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        onPressed: formBloc.submit,
                        child: const Text('Подтвердить'),
                      ),
                    ),
                  ],
                ),
              ]
                  .map((e) => e.runtimeType != BlocBuilder
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: e,
                        )
                      : e)
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
