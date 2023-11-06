import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class LabsBlocBuilder<T extends StateStreamable<LabsState>>
    extends StatelessWidget {
  const LabsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, LabsState>(
      builder: (context, state) => switch (state) {
        final LabsInitial _ => const HelloView(),
        final LabsOk _ => const OkView(),
        final LabsLoading _ => const LoadingView(),
        final LabsError e => ErrorView(error: e.exception),
        final LabsTable t => TableView(table: t.table),
      },
    );
  }
}
