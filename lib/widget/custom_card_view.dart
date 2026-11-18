import 'package:dailytask/model/task_model.dart';
import 'package:dailytask/screen/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCardView extends StatelessWidget {
  final Taskmodel data;
  const new({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: data.isCompleted,
          activeColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (val) {
            context.read<TaskBloc>().add(
              UpdateTask(
                Taskmodel(
                  id: data.id,
                  title: data.title,
                  isCompleted: val ?? false,
                ),
              ),
            );
          },
        ),
        title: Text(
          data.title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: data.isCompleted ? Colors.grey : Colors.black87,
            decoration: data.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          "Task ID: ${data.id}",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: IconButton(
          onPressed: () {
            context.read<TaskBloc>().add(RemoveTask(data.id));
          },
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
        ),
      ),
    );
    ;
  }
}
