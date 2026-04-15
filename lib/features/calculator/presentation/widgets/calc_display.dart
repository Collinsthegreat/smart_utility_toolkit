import 'package:flutter/material.dart';

/// Calculator display widget.
class CalcDisplay extends StatelessWidget {
  /// Creates [CalcDisplay].
  const CalcDisplay({required this.expression, required this.result, super.key});
  final String expression;
  final String result;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[Text(expression), Text(result, style: Theme.of(context).textTheme.headlineMedium)]);
}
