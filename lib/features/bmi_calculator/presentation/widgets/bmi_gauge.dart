import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Simple BMI gauge chart.
class BmiGauge extends StatelessWidget {
  /// Creates [BmiGauge].
  const BmiGauge({required this.value, super.key});
  final double value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200, child: PieChart(PieChartData(sections: <PieChartSectionData>[PieChartSectionData(value: value.clamp(0, 40), radius: 36), PieChartSectionData(value: (40 - value).clamp(0, 40), radius: 24)])));
  }
}
