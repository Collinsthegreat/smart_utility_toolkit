import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/task_model.dart';
import '../../../../core/constants/app_constants.dart';

/// Local data source for tasks.
@lazySingleton
class TasksLocalDataSource {
  /// Creates [TasksLocalDataSource].
  TasksLocalDataSource(@Named(AppConstants.tasksBox) this._box);

  final Box<dynamic> _box;

  /// Gets all tasks.
  List<TaskModel> getAllTasks() {
    try {
      final tasks = _box.values.cast<TaskModel>().toList();
      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tasks;
    } catch (_) {
      return <TaskModel>[];
    }
  }

  /// Saves or updates a task.
  void putTask(TaskModel task) {
    _box.put(task.id, task);
  }

  /// Deletes a task.
  void deleteTask(String id) {
    _box.delete(id);
  }
}
