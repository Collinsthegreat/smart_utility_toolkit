import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system for all text.
abstract final class AppTypography {
  /// Base text theme.
  static TextTheme get textTheme => GoogleFonts.interTextTheme();
}

