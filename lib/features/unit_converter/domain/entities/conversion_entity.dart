import 'package:equatable/equatable.dart';

/// Conversion entity in domain layer.
class ConversionEntity extends Equatable {
  /// Creates [ConversionEntity].
  const ConversionEntity({
    required this.category,
    required this.fromUnit,
    required this.toUnit,
    required this.input,
    required this.output,
    required this.timestamp,
  });

  /// Conversion category.
  final String category;

  /// Source unit.
  final String fromUnit;

  /// Target unit.
  final String toUnit;

  /// Input value.
  final double input;

  /// Output value.
  final double output;

  /// When the conversion was saved.
  final DateTime timestamp;

  @override
  List<Object?> get props => <Object?>[category, fromUnit, toUnit, input, output, timestamp];
}
