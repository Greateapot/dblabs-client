import 'package:flutter/material.dart';

class OkView extends StatelessWidget {
  const OkView({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          "Успешно!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
