import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_usecases.dart';

/// Base event for tasks bloc.
sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Load tasks event.
class LoadTasksEvent extends TasksEvent {
  const LoadTasksEvent();
}

/// Create task event.
class CreateTaskEvent extends TasksEvent {
  /// Creates [CreateTaskEvent].
  const CreateTaskEvent({
    required this.title,
    required this.description,
    required this.priority,
  });

  /// Task title.
  final String title;

  /// Task description.
  final String description;

  /// Task priority.
  final int priority;

  @override
  List<Object?> get props => <Object?>[title, description, priority];
}

/// Update task event.
class UpdateTaskEvent extends TasksEvent {
  /// Creates [UpdateTaskEvent].
  const UpdateTaskEvent(this.task);

  /// Updated task.
  final TaskEntity task;

  @override
  List<Object?> get props => <Object?>[task];
}

/// Delete task event.
class DeleteTaskEvent extends TasksEvent {
  /// Creates [DeleteTaskEvent].
  const DeleteTaskEvent(this.taskId);

  /// Target task id.
  final String taskId;

  @override
  List<Object?> get props => <Object?>[taskId];
}

/// Toggle task event.
class ToggleTaskEvent extends TasksEvent {
  /// Creates [ToggleTaskEvent].
  const ToggleTaskEvent(this.taskId);

  /// Target task id.
  final String taskId;

  @override
  List<Object?> get props => <Object?>[taskId];
}

/// Filter tasks event.
class FilterTasksEvent extends TasksEvent {
  /// Creates [FilterTasksEvent].
  const FilterTasksEvent(this.filter);

  /// Target filter.
  final TaskFilterMode filter;

  @override
  List<Object?> get props => <Object?>[filter];
}

/// Search tasks event.
class SearchTasksEvent extends TasksEvent {
  /// Creates [SearchTasksEvent].
  const SearchTasksEvent(this.query);

  /// Search query.
  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}
