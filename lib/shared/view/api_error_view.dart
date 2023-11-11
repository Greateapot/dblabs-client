import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:flutter/material.dart';

class ApiErrorView extends StatelessWidget {
  final ApiException error;

  const ApiErrorView({required this.error, super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: SelectableText(
          "Ошибка! Код: ${error.code}\n${error.message}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
