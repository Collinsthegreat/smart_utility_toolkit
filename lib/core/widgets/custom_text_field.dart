import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Shared text field with standardized styling.
class CustomTextField extends StatelessWidget {
  /// Creates [CustomTextField].
  const CustomTextField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.onChanged,
    this.errorText,
    super.key,
  });

  /// Field controller.
  final TextEditingController controller;

  /// Field hint text.
  final String hint;

  /// Field keyboard type.
  final TextInputType? keyboardType;

  /// Change callback.
  final ValueChanged<String>? onChanged;

  /// Optional error text.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

