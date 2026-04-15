/// Bill split result model.
class BillSplitResult {
  /// Creates [BillSplitResult].
  const BillSplitResult({required this.tipAmount, required this.totalWithTip, required this.perPerson});
  final double tipAmount;
  final double totalWithTip;
  final double perPerson;
}

/// Bill splitting use case.
class SplitBill {
  /// Creates [SplitBill].
  const SplitBill();
  BillSplitResult call({required double billAmount, required double tipPercent, required int people}) {
    if (people <= 0) return const BillSplitResult(tipAmount: 0, totalWithTip: 0, perPerson: 0);
    final double tipAmount = billAmount * (tipPercent / 100);
    final double totalWithTip = billAmount + tipAmount;
    return BillSplitResult(tipAmount: tipAmount, totalWithTip: totalWithTip, perPerson: totalWithTip / people);
  }
}
