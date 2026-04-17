import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/task_entity.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart' as custom_error;
import '../../../../injection.dart';
import '../bloc/tasks_bloc.dart';
import '../bloc/tasks_event.dart';
import '../bloc/tasks_state.dart';
import '../widgets/task_card.dart';
import '../widgets/task_filter_chips.dart';
import 'task_form_page.dart';

/// Main tasks list page.
class TasksListPage extends StatefulWidget {
  /// Creates [TasksListPage].
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final TasksBloc _bloc = sl<TasksBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(const LoadTasksEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _navigateToForm([TaskEntity? task]) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: _bloc,
          child: TaskFormPage(task: task),
        ),
      ),
    );
  }

  void _onToggleTask(String id) {
    _bloc.add(ToggleTaskEvent(id));
  }

  void _onDeleteTask(TaskEntity task) {
    _bloc.add(DeleteTaskEvent(task.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(AppStrings.taskDeleted),
        action: SnackBarAction(
          label: AppStrings.undo,
          onPressed: () {
            _bloc.add(CreateTaskEvent(
              title: task.title,
              description: task.description,
              priority: task.priority,
            ));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.myTasks,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search bar dropdown logic, or keep simple
              },
            ),
          ],
        ),
        body: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const LoadingWidget();
            } else if (state is TasksError) {
              return custom_error.ErrorStateWidget(message: state.message);
            } else if (state is TasksLoaded) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${state.tasks.length} tasks · ${state.completedCount} completed',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                  TaskFilterChips(
                    currentFilter: state.filter,
                    onFilterChanged: (filter) {
                      _bloc.add(FilterTasksEvent(filter));
                    },
                    totalCount: state.activeCount + state.completedCount,
                    activeCount: state.activeCount,
                    completedCount: state.completedCount,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Expanded(
                    child: state.tasks.isEmpty
                        ? const EmptyStateWidget(message: AppStrings.noTasksFound)
                            .animate()
                            .fade(duration: 400.ms)
                        : ListView.builder(
                            key: ValueKey(state.filter),
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              final task = state.tasks[index];
                              return Dismissible(
                                key: Key(task.id),
                                background: Container(
                                  color: Colors.green,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: AppSizes.lg),
                                  child: const Icon(Icons.check, color: Colors.white),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: AppSizes.lg),
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (direction) {
                                  if (direction == DismissDirection.endToStart) {
                                    _onDeleteTask(task);
                                  } else {
                                    _onToggleTask(task.id);
                                  }
                                },
                                child: TaskCard(
                                  task: task,
                                  onTap: () => _navigateToForm(task),
                                  onToggle: () => _onToggleTask(task.id),
                                  onDelete: () => _onDeleteTask(task),
                                  onEdit: () => _navigateToForm(task),
                                ).animate().slideX(
                                      duration: 300.ms,
                                      delay: (index * 50).ms,
                                      begin: 0.2,
                                    ),
                              );
                            },
                          ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToForm(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
