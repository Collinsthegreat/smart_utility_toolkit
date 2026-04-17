import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';

/// Tool card used in dashboard grid.
class ToolCard extends StatelessWidget {
  /// Creates [ToolCard].
  const ToolCard({
    required this.name,
    required this.description,
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// Tool name.
  final String name;

  /// Tool description.
  final String description;

  /// Tool icon.
  final IconData icon;

  /// Tap callback.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.9),
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 32, color: Colors.white),
              const SizedBox(height: AppSizes.lg),
              Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
              const SizedBox(height: AppSizes.sm),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.9)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

