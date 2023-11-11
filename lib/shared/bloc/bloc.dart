import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class LabsBlocBuilder<T extends StateStreamable> extends StatelessWidget {
  const LabsBlocBuilder({this.buildWhen, super.key});

  final bool Function(dynamic, dynamic)? buildWhen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, dynamic>(
      buildWhen: buildWhen,
      builder: (context, state) => switch (state) {
        final LabsInitial _ => const HelloView(),
        final LabsOk _ => const OkView(),
        final LabsLoading _ => const LoadingView(),
        final LabsApiError e => ApiErrorView(error: e.exception),
        final LabsError e => ErrorView(error: e.exception),
        final LabsTable t => TableView(table: t.table),
        _ => throw UnimplementedError(),
      },
    );
  }
}
