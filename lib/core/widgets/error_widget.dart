import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Generic error display widget.
class ErrorStateWidget extends StatelessWidget {
  /// Creates [ErrorStateWidget].
  const ErrorStateWidget({required this.message, super.key});

  /// Error message.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, size: 72, color: Theme.of(context).colorScheme.error),
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

