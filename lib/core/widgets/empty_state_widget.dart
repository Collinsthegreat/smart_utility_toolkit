import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Generic empty state widget.
class EmptyStateWidget extends StatelessWidget {
  /// Creates [EmptyStateWidget].
  const EmptyStateWidget({required this.message, super.key});

  /// Empty state message.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.inbox, size: 74, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: AppSizes.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

