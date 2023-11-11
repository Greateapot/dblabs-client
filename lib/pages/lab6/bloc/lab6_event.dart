part of 'lab6_bloc.dart';

@immutable
sealed class Lab6Event {
  const Lab6Event();
}

final class Lab6DropTrigger extends Lab6Event {
  final String triggerName;

  const Lab6DropTrigger({required this.triggerName});
}

final class Lab6CreateTrigger extends Lab6Event {
  final String triggerName;
  final String tableName;
  final String triggerBody;
  final TriggerTimeType triggerTime;
  final TriggerEventType triggerEvent;
  final TriggerOrder? triggerOrder;

  const Lab6CreateTrigger({
    required this.triggerName,
    required this.triggerBody,
    required this.tableName,
    required this.triggerEvent,
    required this.triggerTime,
    this.triggerOrder,
  });
}
