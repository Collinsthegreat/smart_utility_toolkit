import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';

/// Display widget for conversion result.
class ConversionResult extends StatelessWidget {
  /// Creates [ConversionResult].
  const ConversionResult({required this.value, super.key});

  /// Result value text.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Text(
        value,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
