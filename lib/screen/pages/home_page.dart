import 'package:dailytask/model/task_model.dart';
import 'package:dailytask/screen/bloc/task_bloc.dart';
import 'package:dailytask/screen/pages/view_task.dart';
import 'package:dailytask/widget/custom_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Task")),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskAdded) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(message: "Task Added Successfully"),
              displayDuration: const Duration(seconds: 2),
            );
          }

          if (state is TaskRemoved) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.info(message: "Task Removed Successfully"),
              displayDuration: const Duration(seconds: 2),
            );
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is TaskError) {
            return Center(child: Text(state.errorMessage));
          }

          final itemList = state is TaskLoaded
              ? state.tasks
              : state is TaskAdded
              ? state.taskModel
              : state is TaskRemoved
              ? state.taskModel
              : <Taskmodel>[];

          return Column(
            children: [
              Expanded(
                child: itemList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.task_alt,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No Tasks Yet!",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Add your first task to get started.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewTask(task: itemList[index]),
                                ),
                              );
                            },
                            child: CustomCardView(data: itemList[index]),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showAddTaskSheet(context, itemList);
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Add New Task",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showAddTaskSheet(BuildContext context, List<Taskmodel> taskList) {
  final taskBloc = context.read<TaskBloc>();
  final TextEditingController titleController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (bottomSheetContext) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter task title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: "Please Provide Task title",
                        ),
                        displayDuration: const Duration(seconds: 2),
                      );
                      return;
                    }

                    final task = Taskmodel(
                      id: taskList.isEmpty ? 1 : taskList.last.id + 1,
                      title: titleController.text.trim(),
                      isCompleted: false,
                    );

                    taskBloc.add(AddTask(task));
                    titleController.clear();
                    Navigator.pop(bottomSheetContext);
                  },
                  child: const Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
