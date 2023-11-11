import 'package:bloc/bloc.dart';
import 'package:dblabs/shared/bloc/bloc.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:meta/meta.dart';

part 'lab4_event.dart';

class Lab4Bloc extends Bloc<Lab4Event, LabsState> {
  Lab4Bloc(this._apiRepository) : super(LabsInitial()) {
    on<Lab4ShowDatabases>(_onLab4ShowDatabases);
    on<Lab4ShowTables>(_onLab4ShowTables);
    on<Lab4ShowTableStruct>(_onLab4ShowTableStruct);
    on<Lab4AlterDatabase>(_onLab4AlterDatabase);
    on<Lab4CreateDatabase>(_onLab4CreateDatabase);
    on<Lab4DropDatabase>(_onLab4DropDatabase);
    on<Lab4AlterTable>(_onLab4AlterTable);
    on<Lab4CreateTable>(_onLab4CreateTable);
    on<Lab4DropTable>(_onLab4DropTable);
    on<Lab4RenameTable>(_onLab4RenameTable);
    on<Lab4TruncateTable>(_onLab4TruncateTable);
    on<Lab4Delete>(_onLab4Delete);
    on<Lab4Update>(_onLab4Update);
    on<Lab4Insert>(_onLab4Insert);
    on<Lab4Select>(_onLab4Select);
    on<Lab4Join>(_onLab4Join);
  }

  final ApiRepository _apiRepository;

  void _onLab4ShowDatabases(
    Lab4ShowDatabases event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await _apiRepository.showDatabases(
        showSys: event.showSys,
      );
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4ShowTables(
    Lab4ShowTables event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await _apiRepository.showTables(
        databaseName: event.databaseName,
      );
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4ShowTableStruct(
    Lab4ShowTableStruct event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await _apiRepository.showTableStruct(
        databaseName: event.databaseName,
        tableName: event.tableName,
      );
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4AlterDatabase(
    Lab4AlterDatabase event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.alterDatabase(
        databaseName: event.databaseName,
        readOnly: event.readOnly,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4CreateDatabase(
    Lab4CreateDatabase event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.createDatabase(
        databaseName: event.databaseName,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4DropDatabase(
    Lab4DropDatabase event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.dropDatabase(
        databaseName: event.databaseName,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4AlterTable(
    Lab4AlterTable event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.alterTable(
        tableName: event.tableName,
        options: event.options,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4CreateTable(
    Lab4CreateTable event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.createTable(
        tableName: event.tableName,
        options: event.options,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4DropTable(
    Lab4DropTable event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.dropTable(
        tableName: event.tableName,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4RenameTable(
    Lab4RenameTable event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.renameTable(
        oldTableName: event.oldTableName,
        newTableName: event.newTableName,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4TruncateTable(
    Lab4TruncateTable event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.truncateTable(
        tableName: event.tableName,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4Delete(
    Lab4Delete event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.delete(
        tableName: event.tableName,
        whereCondition: event.whereCondition,
        limit: event.limit,
        tableAlias: event.tableAlias,
        orderBy: event.orderBy,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4Update(
    Lab4Update event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.update(
        tableName: event.tableName,
        assignmentList: event.assignmentList,
        limit: event.limit,
        whereCondition: event.whereCondition,
        orderBy: event.orderBy,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4Insert(
    Lab4Insert event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.insert(
        tableName: event.tableName,
        insertType: event.insertType,
        columnNames: event.columnNames,
        rowConstructorList: event.rowConstructorList,
        otherTableName: event.otherTableName,
        selectData: event.selectData,
        onDuplicateKeyUpdate: event.onDuplicateKeyUpdate,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4Select(
    Lab4Select event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await _apiRepository.select(
        selectData: event.selectData,
      );
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab4Join(
    Lab4Join event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      Table table = await _apiRepository.join(
        columnNames: event.columnNames,
        firstTableName: event.firstTableName,
        secondTableName: event.secondTableName,
        join: event.join,
        firstTableAlias: event.firstTableAlias,
        secondTableAlias: event.secondTableAlias,
        whereCondition: event.whereCondition,
        orderBy: event.orderBy,
      );
      emit(LabsTable(table));
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }
}
