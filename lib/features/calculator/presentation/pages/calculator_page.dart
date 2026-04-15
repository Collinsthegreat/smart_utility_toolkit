import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/usecases/calculate_expression.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';
import '../widgets/calc_button.dart';
import '../widgets/calc_display.dart';

/// Calculator page.
class CalculatorPage extends StatelessWidget {
  /// Creates [CalculatorPage].
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> keys = <String>['7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '0', '.', '+', '='];
    return BlocProvider<CalculatorBloc>(
      create: (_) => CalculatorBloc(const CalculateExpression()),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.calculator)),
        body: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (BuildContext context, CalculatorState state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  CalcDisplay(expression: state.expression, result: state.result),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.read<CalculatorBloc>().add(const CalculatorCleared()),
                          child: const Text('Clear'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.history.isNotEmpty) ...<Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('History', style: Theme.of(context).textTheme.titleMedium),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.history.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (BuildContext context, int index) {
                          final String entry = state.history[index];
                          return Chip(label: Text(entry));
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Expanded(
                    child: GridView.builder(
                      itemCount: keys.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12),
                      itemBuilder: (_, int index) {
                        final String key = keys[index];
                        return CalcButton(
                          label: key,
                          onPressed: () {
                            if (key == '=') {
                              context.read<CalculatorBloc>().add(const CalculatorEvaluated());
                            } else {
                              context.read<CalculatorBloc>().add(CalculatorInputAdded(key));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
