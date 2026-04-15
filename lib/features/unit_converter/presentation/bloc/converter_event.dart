import 'package:equatable/equatable.dart';

/// Converter events.
abstract class ConverterEvent extends Equatable {
  /// Creates [ConverterEvent].
  const ConverterEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Input changed event.
class ConversionInputChanged extends ConverterEvent {
  /// Creates [ConversionInputChanged].
  const ConversionInputChanged(this.value);

  /// Input value string.
  final String value;

  @override
  List<Object?> get props => <Object?>[value];
}

/// Category changed event.
class ConversionCategoryChanged extends ConverterEvent {
  /// Creates [ConversionCategoryChanged].
  const ConversionCategoryChanged(this.category);

  /// Selected category.
  final String category;

  @override
  List<Object?> get props => <Object?>[category];
}

/// Unit changed event.
class ConversionUnitChanged extends ConverterEvent {
  /// Creates [ConversionUnitChanged].
  const ConversionUnitChanged({required this.from, required this.to});

  /// From unit.
  final String from;

  /// To unit.
  final String to;

  @override
  List<Object?> get props => <Object?>[from, to];
}

/// Request history reload event.
class ConversionHistoryRequested extends ConverterEvent {
  /// Creates [ConversionHistoryRequested].
  const ConversionHistoryRequested();
}
