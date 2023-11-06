import 'package:flutter/material.dart';

class HelloView extends StatelessWidget {
  const HelloView({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          "Привет, пользователь!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
