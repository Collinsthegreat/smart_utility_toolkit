import 'package:equatable/equatable.dart';

/// State for onboarding flow.
class OnboardingState extends Equatable {
  /// Creates [OnboardingState].
  const OnboardingState({required this.pageIndex});

  /// Current onboarding page.
  final int pageIndex;

  /// Returns a copied state.
  OnboardingState copyWith({int? pageIndex}) {
    return OnboardingState(pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  List<Object?> get props => <Object?>[pageIndex];
}

