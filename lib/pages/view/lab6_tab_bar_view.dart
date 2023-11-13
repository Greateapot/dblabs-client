import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Lab6TabBarView extends StatelessWidget {
  const Lab6TabBarView({super.key});

  @override
  Widget build(BuildContext context) => ButtonsRow(buttons: [
        ButtonsRowElement(
          label: "Удалить триггер",
          onPressed: () => context.go('/dropTrigger'),
        ),
        ButtonsRowElement(
          label: "Создать триггер",
          onPressed: () => context.go('/createTrigger'),
        ),
      ]);
}
