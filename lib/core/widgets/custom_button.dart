import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

/// Shared elevated button.
class CustomButton extends StatelessWidget {
  /// Creates [CustomButton].
  const CustomButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    super.key,
  });

  /// Button text.
  final String label;

  /// Press callback.
  final VoidCallback? onPressed;

  /// Whether the button uses primary style.
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        ),
      ),
      child: Text(label),
    );
  }
}

