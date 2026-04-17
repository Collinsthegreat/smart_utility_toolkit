import 'package:flutter/material.dart';
import '../../domain/usecases/task_usecases.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';

/// Filter chips row for tasks.
class TaskFilterChips extends StatelessWidget {
  /// Creates [TaskFilterChips].
  const TaskFilterChips({
    required this.currentFilter,
    required this.onFilterChanged,
    required this.totalCount,
    required this.activeCount,
    required this.completedCount,
    super.key,
  });

  /// The currently selected filter.
  final TaskFilterMode currentFilter;

  /// Callback when a filter is tapped.
  final ValueChanged<TaskFilterMode> onFilterChanged;

  /// Total number of tasks.
  final int totalCount;

  /// Number of active tasks.
  final int activeCount;

  /// Number of completed tasks.
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Row(
        children: <Widget>[
          _buildChip(
            context,
            label: AppStrings.filterAll,
            count: totalCount,
            mode: TaskFilterMode.all,
          ),
          const SizedBox(width: AppSizes.sm),
          _buildChip(
            context,
            label: AppStrings.filterActive,
            count: activeCount,
            mode: TaskFilterMode.active,
          ),
          const SizedBox(width: AppSizes.sm),
          _buildChip(
            context,
            label: AppStrings.filterCompleted,
            count: completedCount,
            mode: TaskFilterMode.completed,
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required int count,
    required TaskFilterMode mode,
  }) {
    final bool isSelected = currentFilter == mode;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2)
                  : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onFilterChanged(mode),
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
      ),
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
    );
  }
}
