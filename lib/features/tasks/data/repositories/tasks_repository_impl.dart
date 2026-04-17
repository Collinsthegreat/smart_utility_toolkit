import 'package:injectable/injectable.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_local_datasource.dart';
import '../models/task_model.dart';

/// Implementation of [TasksRepository].
@LazySingleton(as: TasksRepository)
class TasksRepositoryImpl implements TasksRepository {
  /// Creates [TasksRepositoryImpl].
  TasksRepositoryImpl(this._localDataSource);

  final TasksLocalDataSource _localDataSource;

  @override
  List<TaskEntity> getAllTasks() {
    return _localDataSource.getAllTasks().map((m) => m.toEntity()).toList();
  }

  @override
  void createTask(TaskEntity task) {
    final model = TaskModel.fromEntity(task);
    _localDataSource.putTask(model);
  }

  @override
  void updateTask(TaskEntity task) {
    final model = TaskModel.fromEntity(task);
    _localDataSource.putTask(model);
  }

  @override
  void deleteTask(String id) {
    _localDataSource.deleteTask(id);
  }
}
