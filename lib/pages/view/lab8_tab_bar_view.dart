import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Lab8TabBarView extends StatelessWidget {
  const Lab8TabBarView({super.key});

  @override
  Widget build(BuildContext context) => ButtonsRow(buttons: [
        ButtonsRowElement(
          label: "Удалить процедуру",
          onPressed: () => context.go('/dropProcedure'),
        ),
        ButtonsRowElement(
          label: "Создать процедуру",
          onPressed: () => context.go('/createProcedure'),
        ),
        ButtonsRowElement(
          label: "Вызвать процедуру",
          onPressed: () => context.go('/callProcedure'),
        ),
        ButtonsRowElement(
          label: "Создать переменную",
          onPressed: () => context.go('/set'),
        ),
      ]);
}
