import 'package:dailytask/model/task_model.dart';
import 'package:flutter/material.dart';

class ViewTask extends StatelessWidget {
  final Taskmodel task;

  const ViewTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.isCompleted;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                isCompleted ? Icons.task_alt : Icons.pending_actions,
                size: 90,
                color: isCompleted ? Colors.green : Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "TASK TITLE",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              task.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.numbers, color: Colors.deepPurple),
                title: const Text("Task ID"),
                subtitle: Text(task.id.toString()),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(
                  isCompleted ? Icons.check_circle : Icons.access_time,
                  color: isCompleted ? Colors.green : Colors.orange,
                ),
                title: const Text("Task Status"),
                subtitle: Text(isCompleted ? "Completed" : "Pending"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
