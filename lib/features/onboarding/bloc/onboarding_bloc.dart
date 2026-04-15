import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

/// BLoC for onboarding interactions.
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  /// Creates [OnboardingBloc].
  OnboardingBloc() : super(const OnboardingState(pageIndex: 0)) {
    on<OnboardingPageChanged>(
      (OnboardingPageChanged event, Emitter<OnboardingState> emit) =>
          emit(state.copyWith(pageIndex: event.pageIndex)),
    );
  }
}

