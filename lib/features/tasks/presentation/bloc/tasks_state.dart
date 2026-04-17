import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_usecases.dart';

/// Base state for tasks bloc.
sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => <Object?>[];
}

/// Initial tasks state.
class TasksInitial extends TasksState {
  const TasksInitial();
}

/// Loading tasks state.
class TasksLoading extends TasksState {
  const TasksLoading();
}

/// Loaded tasks state.
class TasksLoaded extends TasksState {
  /// Creates [TasksLoaded].
  const TasksLoaded({
    required this.tasks,
    required this.filter,
    required this.activeCount,
    required this.completedCount,
  });

  /// List of tasks.
  final List<TaskEntity> tasks;

  /// Current filter applied.
  final TaskFilterMode filter;

  /// Active tasks count.
  final int activeCount;

  /// Completed tasks count.
  final int completedCount;

  @override
  List<Object?> get props => <Object?>[tasks, filter, activeCount, completedCount];
}

/// Error tasks state.
class TasksError extends TasksState {
  /// Creates [TasksError].
  const TasksError(this.message);

  /// Error message.
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
