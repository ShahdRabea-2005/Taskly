import 'package:flutter/foundation.dart';

import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title, String description) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _tasks.add(newTask);
    ();
  }

  void toggleTaskStatus(String id) {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
