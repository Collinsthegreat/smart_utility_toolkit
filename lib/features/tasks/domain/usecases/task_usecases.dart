import 'package:injectable/injectable.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

/// Gets all tasks.
@lazySingleton
class GetAllTasks {
  /// Creates [GetAllTasks].
  GetAllTasks(this._repository);

  final TasksRepository _repository;

  /// Executes usecase.
  List<TaskEntity> call() => _repository.getAllTasks();
}

/// Creates a task.
@lazySingleton
class CreateTask {
  /// Creates [CreateTask].
  CreateTask(this._repository);

  final TasksRepository _repository;

  /// Executes usecase.
  void call({
    required String title,
    required String description,
    required int priority,
  }) {
    final now = DateTime.now();
    final task = TaskEntity(
      id: now.millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      priority: priority,
      createdAt: now,
      updatedAt: now,
    );
    _repository.createTask(task);
  }
}

/// Updates a task.
@lazySingleton
class UpdateTask {
  /// Creates [UpdateTask].
  UpdateTask(this._repository);

  final TasksRepository _repository;

  /// Executes usecase.
  void call(TaskEntity task) {
    _repository.updateTask(task);
  }
}

/// Deletes a task.
@lazySingleton
class DeleteTask {
  /// Creates [DeleteTask].
  DeleteTask(this._repository);

  final TasksRepository _repository;

  /// Executes usecase.
  void call(String id) {
    _repository.deleteTask(id);
  }
}

/// Toggles task completion.
@lazySingleton
class ToggleTaskCompletion {
  /// Creates [ToggleTaskCompletion].
  ToggleTaskCompletion(this._repository);

  final TasksRepository _repository;

  /// Executes usecase.
  void call(String id) {
    final tasks = _repository.getAllTasks();
    try {
      final task = tasks.firstWhere((t) => t.id == id);
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        updatedAt: DateTime.now(),
      );
      _repository.updateTask(updatedTask);
    } catch (_) {
      // Task not found
    }
  }
}

/// Task filter modes.
enum TaskFilterMode {
  /// All tasks.
  all,
  /// Active (incomplete) tasks.
  active,
  /// Completed tasks.
  completed,
}

/// Filters tasks.
@lazySingleton
class FilterTasks {
  /// Executes usecase.
  List<TaskEntity> call(List<TaskEntity> tasks, TaskFilterMode filter) {
    switch (filter) {
      case TaskFilterMode.all:
        return tasks;
      case TaskFilterMode.active:
        return tasks.where((t) => !t.isCompleted).toList();
      case TaskFilterMode.completed:
        return tasks.where((t) => t.isCompleted).toList();
    }
  }
}
