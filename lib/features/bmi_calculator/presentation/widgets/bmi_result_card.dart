import 'package:flutter/material.dart';
import '../../domain/entities/bmi_result_entity.dart';

/// BMI result card display.
class BmiResultCard extends StatelessWidget {
  /// Creates [BmiResultCard].
  const BmiResultCard({required this.result, super.key});
  final BmiResultEntity result;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(title: Text(result.value.toStringAsFixed(2)), subtitle: Text('${result.category} • ${result.tip}')));
}
