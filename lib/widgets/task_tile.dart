// lib/widgets/task_tile.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_task/models/task.dart';
import 'package:to_do_list_task/providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => taskProvider.deleteTask(task.id),
      ),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (_) => taskProvider.toggleTask(task.id),
      ),
    );
  }
}
