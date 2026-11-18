import 'package:bloc/bloc.dart';
import 'package:dailytask/model/task_model.dart';
import 'package:dailytask/service/store_task.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final List<Taskmodel> taskList = [];
  final StoreTask storeTask = StoreTask();

  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await storeTask.getTaskList();

        taskList
          ..clear()
          ..addAll(tasks);

        emit(TaskLoaded(List.from(taskList)));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading());
      try {
        final taskalreadyExist = taskList.any(
          (task) => task.id == event.taskModel.id,
        );

        if (taskalreadyExist) {
          return;
        }

        taskList.add(event.taskModel);

        await storeTask.saveTask(taskList);

        emit(TaskAdded(List.from(taskList)));
        emit(TaskLoaded(List.from(taskList)));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<RemoveTask>((event, emit) async {
      emit(TaskLoading());
      try {
        taskList.removeWhere((task) => task.id == event.id);

        await storeTask.saveTask(taskList);

        emit(TaskRemoved(List.from(taskList)));
        emit(TaskLoaded(List.from(taskList)));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        final index = taskList.indexWhere(
          (task) => task.id == event.updateTask.id,
        );

        if (index != -1) {
          taskList[index] = event.updateTask;

          await storeTask.saveTask(taskList);

          emit(TaskLoaded(List.from(taskList)));
        }
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
