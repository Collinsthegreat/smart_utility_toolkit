/// Base exception type.
class AppException implements Exception {
  /// Creates [AppException].
  const AppException(this.message);

  /// Message content.
  final String message;
}

