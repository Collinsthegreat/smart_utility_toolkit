import 'package:equatable/equatable.dart';

/// Events for onboarding flow.
abstract class OnboardingEvent extends Equatable {
  /// Creates [OnboardingEvent].
  const OnboardingEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Event for page change.
class OnboardingPageChanged extends OnboardingEvent {
  /// Creates [OnboardingPageChanged].
  const OnboardingPageChanged(this.pageIndex);

  /// Current page index.
  final int pageIndex;

  @override
  List<Object?> get props => <Object?>[pageIndex];
}

