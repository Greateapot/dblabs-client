part of 'lab4_bloc.dart';

@immutable
sealed class Lab4Event {
  const Lab4Event();
}

final class Lab4ShowDatabases extends Lab4Event {
  final bool? showSys;

  const Lab4ShowDatabases({this.showSys});
}

final class Lab4ShowTables extends Lab4Event {
  final String databaseName;

  const Lab4ShowTables({required this.databaseName});
}

final class Lab4ShowTableStruct extends Lab4Event {
  final String databaseName;
  final String tableName;

  const Lab4ShowTableStruct({
    required this.databaseName,
    required this.tableName,
  });
}

final class Lab4AlterDatabase extends Lab4Event {
  final String databaseName;
  final ReadOnly? readOnly;

  const Lab4AlterDatabase({required this.databaseName, this.readOnly});
}

final class Lab4CreateDatabase extends Lab4Event {
  final String databaseName;

  const Lab4CreateDatabase({required this.databaseName});
}

final class Lab4DropDatabase extends Lab4Event {
  final String databaseName;

  const Lab4DropDatabase({required this.databaseName});
}

final class Lab4AlterTable extends Lab4Event {
  final String tableName;
  final Iterable<AlterTableOption> options;

  const Lab4AlterTable({required this.tableName, required this.options});
}

final class Lab4CreateTable extends Lab4Event {
  final String tableName;
  final Iterable<CreateTableOption> options;

  const Lab4CreateTable({required this.tableName, required this.options});
}

final class Lab4DropTable extends Lab4Event {
  final String tableName;

  const Lab4DropTable({required this.tableName});
}

final class Lab4RenameTable extends Lab4Event {
  final String oldTableName;
  final String newTableName;

  const Lab4RenameTable({
    required this.oldTableName,
    required this.newTableName,
  });
}

final class Lab4TruncateTable extends Lab4Event {
  final String tableName;

  const Lab4TruncateTable({required this.tableName});
}

final class Lab4Delete extends Lab4Event {
  final String tableName;
  final String? tableAlias;
  final String? whereCondition;
  final OrderBy? orderBy;
  final int? limit;

  const Lab4Delete({
    required this.tableName,
    this.tableAlias,
    this.whereCondition,
    this.orderBy,
    this.limit,
  });
}

final class Lab4Update extends Lab4Event {
  final String tableName;
  final AssignmentList assignmentList;
  final String? whereCondition;
  final OrderBy? orderBy;
  final int? limit;

  const Lab4Update({
    required this.tableName,
    required this.assignmentList,
    this.whereCondition,
    this.orderBy,
    this.limit,
  });
}

final class Lab4Insert extends Lab4Event {
  final String tableName;
  final InsertType insertType;
  final Iterable<String>? columnNames;
  final SelectData? selectData;
  final String? otherTableName;
  final RowConstructorList? rowConstructorList;
  final AssignmentList? onDuplicateKeyUpdate;

  const Lab4Insert({
    required this.tableName,
    required this.insertType,
    this.columnNames,
    this.selectData,
    this.otherTableName,
    this.rowConstructorList,
    this.onDuplicateKeyUpdate,
  });
}

final class Lab4Select extends Lab4Event {
  final SelectData selectData;

  const Lab4Select({required this.selectData});
}

final class Lab4Join extends Lab4Event {
  final Iterable<String> columnNames;
  final String firstTableName;
  final String secondTableName;
  final Join join;
  final String? firstTableAlias;
  final String? secondTableAlias;
  final String? whereCondition;
  final OrderBy? orderBy;

  const Lab4Join({
    required this.columnNames,
    required this.firstTableName,
    required this.secondTableName,
    required this.join,
    this.firstTableAlias,
    this.secondTableAlias,
    this.whereCondition,
    this.orderBy,
  });
}
