import 'package:bloc/bloc.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:meta/meta.dart';

part 'lab6_event.dart';

class Lab6Bloc extends Bloc<Lab6Event, LabsState> {
  Lab6Bloc(this._apiRepository) : super(LabsInitial()) {
    on<Lab6DropTrigger>(_onLab6DropTrigger);
    on<Lab6CreateTrigger>(_onLab6CreateTrigger);
  }

  final ApiRepository _apiRepository;

  void _onLab6DropTrigger(
    Lab6DropTrigger event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.dropTrigger(
        triggerName: event.triggerName,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }

  void _onLab6CreateTrigger(
    Lab6CreateTrigger event,
    Emitter<LabsState> emit,
  ) async {
    emit(LabsLoading());
    try {
      await _apiRepository.createTrigger(
        triggerName: event.triggerName,
        triggerTime: event.triggerTime,
        triggerEvent: event.triggerEvent,
        tableName: event.tableName,
        triggerBody: event.triggerBody,
        triggerOrder: event.triggerOrder,
      );
      emit(LabsOk());
    } on ApiException catch (exception) {
      emit(LabsApiError(exception));
    } on Exception catch (exception) {
      emit(LabsError(exception));
    }
  }
}
