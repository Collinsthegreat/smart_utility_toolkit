import 'package:equatable/equatable.dart';

/// Calculator state.
class CalculatorState extends Equatable {
  /// Creates [CalculatorState].
  const CalculatorState({
    required this.expression,
    required this.result,
    required this.history,
  });

  /// Current expression.
  final String expression;

  /// Current result preview.
  final String result;

  /// Calculator history entries.
  final List<String> history;

  /// Returns copied state.
  CalculatorState copyWith({String? expression, String? result, List<String>? history}) =>
      CalculatorState(
        expression: expression ?? this.expression,
        result: result ?? this.result,
        history: history ?? this.history,
      );

  @override
  List<Object?> get props => <Object?>[expression, result, history];
}
