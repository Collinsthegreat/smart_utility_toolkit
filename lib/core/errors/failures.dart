import 'package:equatable/equatable.dart';

/// Base failure class.
abstract class Failure extends Equatable {
  /// Creates [Failure].
  const Failure(this.message);

  /// User-readable message.
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

/// Failure for cache layer operations.
class CacheFailure extends Failure {
  /// Creates [CacheFailure].
  const CacheFailure(super.message);
}

/// Failure for network layer operations.
class NetworkFailure extends Failure {
  /// Creates [NetworkFailure].
  const NetworkFailure(super.message);
}

