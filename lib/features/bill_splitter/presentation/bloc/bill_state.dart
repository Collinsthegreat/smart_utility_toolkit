import 'package:equatable/equatable.dart';
import '../../domain/usecases/split_bill.dart';

/// Bill splitter state.
class BillState extends Equatable {
  /// Creates [BillState].
  const BillState({
    required this.result,
    required this.billAmount,
    required this.tipPercent,
    required this.people,
  });
  final BillSplitResult result;
  final double billAmount;
  final double tipPercent;
  final int people;

  BillState copyWith({
    BillSplitResult? result,
    double? billAmount,
    double? tipPercent,
    int? people,
  }) =>
      BillState(
        result: result ?? this.result,
        billAmount: billAmount ?? this.billAmount,
        tipPercent: tipPercent ?? this.tipPercent,
        people: people ?? this.people,
      );
  @override
  List<Object?> get props =>
      <Object?>[result.tipAmount, result.totalWithTip, result.perPerson, billAmount, tipPercent, people];
}
