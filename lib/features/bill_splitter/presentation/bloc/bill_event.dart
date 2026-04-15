import 'package:equatable/equatable.dart';

/// Bill splitter events.
abstract class BillEvent extends Equatable {
  /// Creates [BillEvent].
  const BillEvent();
  @override
  List<Object?> get props => <Object?>[];
}

/// Recompute bill split event.
class BillInputsChanged extends BillEvent {
  /// Creates [BillInputsChanged].
  const BillInputsChanged({required this.billAmount, required this.tipPercent, required this.people});
  final double billAmount;
  final double tipPercent;
  final int people;
  @override
  List<Object?> get props => <Object?>[billAmount, tipPercent, people];
}
