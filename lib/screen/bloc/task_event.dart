part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class LoadTasks extends TaskEvent {}

final class AddTask extends TaskEvent {
  final Taskmodel taskModel;
  AddTask(this.taskModel);
}

final class RemoveTask extends TaskEvent {
  final int id;
  RemoveTask(this.id);
}

final class UpdateTask extends TaskEvent {
  final Taskmodel updateTask;
  UpdateTask(this.updateTask);
}
