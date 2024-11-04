// lib/providers/task_provider.dart
import 'package:flutter/material.dart';
import 'package:to_do_list_task/models/task.dart';
import 'package:to_do_list_task/utils/storage_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks = await StorageHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(newTask);
    await StorageHelper.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    await StorageHelper.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await StorageHelper.saveTasks(_tasks);
    notifyListeners();
  }
}
