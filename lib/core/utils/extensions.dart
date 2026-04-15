/// DateTime extensions used in UI formatting.
extension DateFormatting on DateTime {
  /// Returns ISO-like short date string.
  String toShortDate() => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}

