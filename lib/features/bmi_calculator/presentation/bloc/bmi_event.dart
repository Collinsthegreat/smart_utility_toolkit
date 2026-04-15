import 'package:equatable/equatable.dart';

/// BMI events.
abstract class BmiEvent extends Equatable {
  /// Creates [BmiEvent].
  const BmiEvent();
  @override
  List<Object?> get props => <Object?>[];
}

/// BMI calculation request event.
class BmiCalculated extends BmiEvent {
  /// Creates [BmiCalculated].
  const BmiCalculated({required this.height, required this.weight, this.isImperial = false});
  final double height;
  final double weight;
  final bool isImperial;
  @override
  List<Object?> get props => <Object?>[height, weight, isImperial];
}

/// Reload saved BMI history.
class BmiHistoryRequested extends BmiEvent {
  /// Creates [BmiHistoryRequested].
  const BmiHistoryRequested();
}
