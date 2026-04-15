import 'package:equatable/equatable.dart';

/// Home events.
abstract class HomeEvent extends Equatable {
  /// Creates [HomeEvent].
  const HomeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Search query changed event.
class HomeSearchChanged extends HomeEvent {
  /// Creates [HomeSearchChanged].
  const HomeSearchChanged(this.query);

  /// Search query.
  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}

