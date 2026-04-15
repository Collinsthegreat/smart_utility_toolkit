import 'package:equatable/equatable.dart';
import '../../domain/entities/conversion_entity.dart';

/// Converter state.
class ConverterState extends Equatable {
  /// Creates [ConverterState].
  const ConverterState({
    required this.category,
    required this.from,
    required this.to,
    required this.input,
    required this.output,
    required this.history,
    this.error,
  });

  /// Selected category.
  final String category;

  /// Source unit.
  final String from;

  /// Target unit.
  final String to;

  /// Input text.
  final String input;

  /// Computed output text.
  final String output;

  /// Conversion history.
  final List<ConversionEntity> history;

  /// Optional error message.
  final String? error;

  /// Returns copied state.
  ConverterState copyWith({
    String? category,
    String? from,
    String? to,
    String? input,
    String? output,
    List<ConversionEntity>? history,
    String? error,
  }) {
    return ConverterState(
      category: category ?? this.category,
      from: from ?? this.from,
      to: to ?? this.to,
      input: input ?? this.input,
      output: output ?? this.output,
      history: history ?? this.history,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[category, from, to, input, output, history, error];
}
