import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/task_entity.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import 'task_priority_badge.dart';

/// Card displaying a task.
class TaskCard extends StatelessWidget {
  /// Creates [TaskCard].
  const TaskCard({
    required this.task,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  /// The task to display.
  final TaskEntity task;

  /// Callback when tapped.
  final VoidCallback onTap;

  /// Callback when checkbox toggled.
  final VoidCallback onToggle;

  /// Callback when delete icon tapped.
  final VoidCallback onDelete;

  /// Callback when edit icon tapped.
  final VoidCallback onEdit;

  Color _getPriorityColor() {
    switch (task.priority) {
      case 2:
        return AppColors.priorityHigh;
      case 1:
        return AppColors.priorityMedium;
      case 0:
      default:
        return AppColors.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d');
    final pColor = _getPriorityColor();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: 6),
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: task.isCompleted ? 0.6 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkResponse(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    onToggle();
                  },
                  radius: 24,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(top: 2, right: AppSizes.md),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: task.isCompleted ? pColor : Theme.of(context).hintColor,
                        width: 2,
                      ),
                      color: task.isCompleted ? pColor : Colors.transparent,
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            ),
                      ),
                      if (task.description.isNotEmpty) ...<Widget>[
                        const SizedBox(height: 4),
                        Text(
                          task.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                      ],
                      const SizedBox(height: AppSizes.sm),
                      Row(
                        children: <Widget>[
                          TaskPriorityBadge(priority: task.priority),
                          const Spacer(),
                          Text(
                            dateFormat.format(task.createdAt),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: onEdit,
                      visualDensity: VisualDensity.compact,
                      color: Theme.of(context).hintColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
