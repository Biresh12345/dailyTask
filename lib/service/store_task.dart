import 'dart:convert';

import 'package:dailytask/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreTask {
  static const String taskKey = 'tasks';

  Future<void> saveTask(List<Taskmodel> task) async {
    final prefs = await SharedPreferences.getInstance();

    final taskJson = task.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList(taskKey, taskJson);
  }

  Future<List<Taskmodel>> getTaskList() async {
    final prefs = await SharedPreferences.getInstance();

    final taskJson = prefs.getStringList(taskKey) ?? [];

    return taskJson
        .map((task) => Taskmodel.fromJson(jsonDecode(task)))
        .toList();
  }
}
