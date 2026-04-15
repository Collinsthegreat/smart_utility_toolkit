import 'package:flutter/material.dart';

/// Generic loading indicator widget.
class LoadingWidget extends StatelessWidget {
  /// Creates [LoadingWidget].
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
