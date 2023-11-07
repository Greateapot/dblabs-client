part of 'create_table_dialog_bloc.dart';

@immutable
sealed class CreateTableDialogEvent {
  const CreateTableDialogEvent();
}

final class AddColumnEvent extends CreateTableDialogEvent {
  final api.Column column;

  const AddColumnEvent(this.column);
}

final class RemoveColumnEvent extends CreateTableDialogEvent {
  final api.Column column;

  const RemoveColumnEvent(this.column);
}

final class UpdateColumnEvent extends CreateTableDialogEvent {
  final api.Column column;

  const UpdateColumnEvent(this.column);
}