import 'package:flutter/material.dart';

/// App color palette.
abstract final class AppColors {
  /// Primary color.
  static const Color primary = Color(0xFF3D5AFE);

  /// Secondary accent color.
  static const Color secondary = Color(0xFF00BCD4);
  
  /// Task Priority Colors.
  static const Color priorityLow = Color(0xFF43A047); // Colors.green.shade600
  static const Color priorityMedium = Color(0xFFFB8C00); // Colors.orange.shade600
  static const Color priorityHigh = Color(0xFFE53935); // Colors.red.shade600
}

