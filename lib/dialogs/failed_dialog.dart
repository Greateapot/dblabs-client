import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FailedDialog extends StatelessWidget {
  const FailedDialog({this.failureResponse, Key? key}) : super(key: key);

  final String? failureResponse;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
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
          children: [
            Text(
              "Ошибка",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (failureResponse != null) const SizedBox(height: 16),
            if (failureResponse != null) SelectableText(failureResponse!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text("Закрыть"),
            ),
          ],
        ),
      ),
    );
  }
}
