import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Exception error;

  const ErrorView({required this.error, super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: SelectableText(
          error.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
