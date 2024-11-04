// lib/utils/storage_helper.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_task/models/task.dart';

class StorageHelper {
  static const _tasksKey = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString(_tasksKey, tasksJson);
  }

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_tasksKey);
    if (tasksJson == null) return [];
    final List decodedList = jsonDecode(tasksJson);
    return decodedList.map((taskMap) => Task.fromMap(taskMap)).toList();
  }
}
