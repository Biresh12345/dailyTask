part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskAdded extends TaskState {
  final List<Taskmodel> taskModel;
  TaskAdded(this.taskModel);
}

final class TaskLoaded extends TaskState {
  final List<Taskmodel> tasks;

  TaskLoaded(this.tasks);
}

final class TaskRemoved extends TaskState {
  final List<Taskmodel> taskModel;
  TaskRemoved(this.taskModel);
}

final class TaskError extends TaskState {
  final String errorMessage;
  TaskError(this.errorMessage);
}
