import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/task_usecases.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

/// BLoC for tasks feature.
@injectable
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  /// Creates [TasksBloc].
  TasksBloc({
    required this.getAllTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.toggleTaskCompletion,
    required this.filterTasks,
  }) : super(const TasksInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskEvent>(_onToggleTask);
    on<FilterTasksEvent>(_onFilterTasks);
    on<SearchTasksEvent>(_onSearchTasks);
  }

  /// Gets all tasks.
  final GetAllTasks getAllTasks;

  /// Creates a task.
  final CreateTask createTask;

  /// Updates a task.
  final UpdateTask updateTask;

  /// Deletes a task.
  final DeleteTask deleteTask;

  /// Toggles task completion.
  final ToggleTaskCompletion toggleTaskCompletion;

  /// Filters tasks.
  final FilterTasks filterTasks;

  TaskFilterMode _currentFilter = TaskFilterMode.all;
  String _currentQuery = '';

  void _onLoadTasks(LoadTasksEvent event, Emitter<TasksState> emit) {
    emit(const TasksLoading());
    _emitLoadedState(emit);
  }

  void _onCreateTask(CreateTaskEvent event, Emitter<TasksState> emit) {
    createTask(
      title: event.title,
      description: event.description,
      priority: event.priority,
    );
    _emitLoadedState(emit);
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TasksState> emit) {
    updateTask(event.task);
    _emitLoadedState(emit);
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    deleteTask(event.taskId);
    _emitLoadedState(emit);
  }

  void _onToggleTask(ToggleTaskEvent event, Emitter<TasksState> emit) {
    toggleTaskCompletion(event.taskId);
    _emitLoadedState(emit);
  }

  void _onFilterTasks(FilterTasksEvent event, Emitter<TasksState> emit) {
    _currentFilter = event.filter;
    _emitLoadedState(emit);
  }

  void _onSearchTasks(SearchTasksEvent event, Emitter<TasksState> emit) {
    _currentQuery = event.query;
    _emitLoadedState(emit);
  }

  void _emitLoadedState(Emitter<TasksState> emit) {
    try {
      final allTasks = getAllTasks();
      final activeCount = allTasks.where((t) => !t.isCompleted).length;
      final completedCount = allTasks.where((t) => t.isCompleted).length;

      var displayedTasks = filterTasks(allTasks, _currentFilter);

      if (_currentQuery.isNotEmpty) {
        final q = _currentQuery.toLowerCase();
        displayedTasks = displayedTasks.where((TaskEntity t) {
          return t.title.toLowerCase().contains(q) ||
              t.description.toLowerCase().contains(q);
        }).toList();
      }

      emit(TasksLoaded(
        tasks: displayedTasks,
        filter: _currentFilter,
        activeCount: activeCount,
        completedCount: completedCount,
      ));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}
