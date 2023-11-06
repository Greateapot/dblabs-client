import 'package:dblabs/pages/lab4/lab4.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lab4View extends StatelessWidget {
  const Lab4View({super.key});

  void showActionDialog<T>({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
    void Function(T data)? onData,
  }) async {
    final T? data = await showDialog<T>(context: context, builder: builder);
    if (onData != null && data != null) onData(data);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 60,
            child: ButtonsRow(buttonValues: [
              ButtonsRowElement(
                label: "drop db `Vozovikov`",
                onPressed: () => showActionDialog<String>(
                  context: context,
                  builder: (context) => const DropDatabaseDialog(),
                  onData: (data) => context
                      .read<Lab4Bloc>()
                      .add(Lab4DropDatabase(databaseName: data)),
                ),
              ),
            ]),
          ),
          const Expanded(child: LabsBlocBuilder<Lab4Bloc>()),
        ],
      );
}
