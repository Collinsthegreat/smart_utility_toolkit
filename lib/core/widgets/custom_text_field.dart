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
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
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

  /// Maximum number of lines.
  final int? maxLines;

  /// Maximum characters allowed.
  final int? maxLength;

  /// Keyboard action type.
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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

