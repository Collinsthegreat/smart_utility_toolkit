import 'package:flutter/material.dart';
import '../../domain/usecases/split_bill.dart';

/// Result card for bill splitting.
class SplitResultCard extends StatelessWidget {
  /// Creates [SplitResultCard].
  const SplitResultCard({required this.result, required this.currency, super.key});
  final BillSplitResult result;
  final String currency;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(title: Text('Per person: $currency${result.perPerson.toStringAsFixed(2)}'), subtitle: Text('Tip: $currency${result.tipAmount.toStringAsFixed(2)} • Total: $currency${result.totalWithTip.toStringAsFixed(2)}')));
}
