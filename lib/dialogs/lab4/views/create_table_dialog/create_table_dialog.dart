import 'package:dblabs/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;

class CreateTableDialog extends StatelessWidget {
  const CreateTableDialog({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CreateTableDialogBloc({
          'id': api.Column(
            columnName: 'id',
            dataType: api.DataType(
              type: api.DataTypeType.INT,
              intAttrs: api.IntDataTypeAttrs(
                unsigned: true,
                autoIncrement: true,
              ),
            ),
          ),
        }),
        child: const CreateTableView(),
      );
}
