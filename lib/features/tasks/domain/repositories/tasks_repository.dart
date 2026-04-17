import '../entities/task_entity.dart';

/// Abstract tasks repository.
abstract class TasksRepository {
  /// Gets all tasks.
  List<TaskEntity> getAllTasks();

  /// Saves a new task.
  void createTask(TaskEntity task);

  /// Updates an existing task.
  void updateTask(TaskEntity task);

  /// Deletes a task by id.
  void deleteTask(String id);
}
