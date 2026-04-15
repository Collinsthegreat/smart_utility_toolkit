import 'package:equatable/equatable.dart';

/// Calculator events.
abstract class CalculatorEvent extends Equatable {
  /// Creates [CalculatorEvent].
  const CalculatorEvent();
  @override
  List<Object?> get props => <Object?>[];
}

/// Append symbol event.
class CalculatorInputAdded extends CalculatorEvent {
  /// Creates [CalculatorInputAdded].
  const CalculatorInputAdded(this.symbol);
  final String symbol;
  @override
  List<Object?> get props => <Object?>[symbol];
}

/// Clear input event.
class CalculatorCleared extends CalculatorEvent {
  /// Creates [CalculatorCleared].
  const CalculatorCleared();
}

/// Backspace event.
class CalculatorBackspace extends CalculatorEvent {
  /// Creates [CalculatorBackspace].
  const CalculatorBackspace();
}

/// Toggle percent event.
class CalculatorPercentPressed extends CalculatorEvent {
  /// Creates [CalculatorPercentPressed].
  const CalculatorPercentPressed();
}

/// Toggle sign event.
class CalculatorSignToggled extends CalculatorEvent {
  /// Creates [CalculatorSignToggled].
  const CalculatorSignToggled();
}

/// Calculate event.
class CalculatorEvaluated extends CalculatorEvent {
  /// Creates [CalculatorEvaluated].
  const CalculatorEvaluated();
}

/// Reload history event.
class CalculatorHistoryRequested extends CalculatorEvent {
  /// Creates [CalculatorHistoryRequested].
  const CalculatorHistoryRequested();
}
