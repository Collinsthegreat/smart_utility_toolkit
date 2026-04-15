import 'package:flutter/material.dart';

/// Calculator button widget.
class CalcButton extends StatelessWidget {
  /// Creates [CalcButton].
  const CalcButton({required this.label, required this.onPressed, super.key});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => ElevatedButton(onPressed: onPressed, child: Text(label));
}
