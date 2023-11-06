import 'package:flutter/material.dart';

class DropDatabaseDialog extends StatelessWidget {
  const DropDatabaseDialog({super.key});

  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("drop `Vozovikov` db?"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop("Vozovikov"),
                child: const Text("ok"),
              ),
            ],
          ),
        ),
      );
}
