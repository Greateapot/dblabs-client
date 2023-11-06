import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final ApiException error;

  const ErrorView({required this.error, super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          "Ошибка! Код: ${error.code}\n${error.message}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
