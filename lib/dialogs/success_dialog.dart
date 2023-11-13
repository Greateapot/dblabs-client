import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({this.successResponse, Key? key}) : super(key: key);

  final String? successResponse;

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
              "Успешно",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (successResponse != null) const SizedBox(height: 16),
            if (successResponse != null) Text(successResponse!),
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
