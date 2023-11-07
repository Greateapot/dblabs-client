import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TableView extends StatelessWidget {
  final api.Table table;

  const TableView({required this.table, super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columns: <DataColumn2>[
        for (final v in table.columnNames) DataColumn2(label: SelectableText(v)),
      ],
      rows: <DataRow2>[
        for (final List<dynamic> v in table.rows)
          DataRow2(cells: [
            for (final dynamic e in v)
              DataCell(SelectableText(e == null ? "" : e.toString())),
          ]),
      ],
    );
  }
}
