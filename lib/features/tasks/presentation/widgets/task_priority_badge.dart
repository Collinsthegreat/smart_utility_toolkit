import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';

/// Displays priority badge.
class TaskPriorityBadge extends StatelessWidget {
  /// Creates [TaskPriorityBadge].
  const TaskPriorityBadge({required this.priority, super.key});

  /// Priority value (0 = Low, 1 = Medium, 2 = High)
  final int priority;

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    String badgeText;

    switch (priority) {
      case 2:
        badgeColor = AppColors.priorityHigh;
        badgeText = AppStrings.priorityHigh;
        break;
      case 1:
        badgeColor = AppColors.priorityMedium;
        badgeText = AppStrings.priorityMedium;
        break;
      case 0:
      default:
        badgeColor = AppColors.priorityLow;
        badgeText = AppStrings.priorityLow;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        badgeText,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
