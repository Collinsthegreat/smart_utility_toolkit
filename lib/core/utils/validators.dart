/// Common validators for form input.
abstract final class Validators {
  /// Validates required text.
  static String? requiredText(String value) {
    if (value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }
}

