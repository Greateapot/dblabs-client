import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Lab7TabBarView extends StatelessWidget {
  const Lab7TabBarView({super.key});

  @override
  Widget build(BuildContext context) => ButtonsRow(buttons: [
        ButtonsRowElement(
          label: "Удалить представление",
          onPressed: () => context.go('/dropView'),
        ),
        ButtonsRowElement(
          label: "Создать представление",
          onPressed: () => context.go('/createView'),
        ),
      ]);
}
