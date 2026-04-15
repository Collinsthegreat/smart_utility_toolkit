import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/bmi_result_entity.dart';
import '../../domain/usecases/calculate_bmi.dart';
import '../bloc/bmi_bloc.dart';
import '../bloc/bmi_event.dart';
import '../bloc/bmi_state.dart';
import '../widgets/bmi_gauge.dart';
import '../widgets/bmi_result_card.dart';

/// BMI calculator page.
class BmiPage extends StatefulWidget {
  /// Creates [BmiPage].
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  bool isImperial = false;

  @override
  void dispose() {
    height.dispose();
    weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BmiBloc>(
      create: (_) => BmiBloc(const CalculateBmi()),
      child: Builder(
        builder: (BuildContext innerContext) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.bmiCalculator)),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(isImperial ? 'Imperial (in, lbs)' : 'Metric (cm, kg)', style: Theme.of(context).textTheme.titleMedium),
                      Switch(
                        value: isImperial,
                        onChanged: (bool val) {
                          setState(() {
                            isImperial = val;
                            height.clear();
                            weight.clear();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: height,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: isImperial ? 'Height (in)' : 'Height (cm)',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: weight,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: isImperial ? 'Weight (lbs)' : 'Weight (kg)',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      innerContext.read<BmiBloc>().add(
                            BmiCalculated(
                              height: double.tryParse(height.text) ?? 0,
                              weight: double.tryParse(weight.text) ?? 0,
                              isImperial: isImperial,
                            ),
                          );
                    },
                    child: const Text(AppStrings.calculate),
                  ),
                  const SizedBox(height: 24),
              BlocBuilder<BmiBloc, BmiState>(
                builder: (_, BmiState state) {
                  if (state.result == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      BmiGauge(value: state.result!.value),
                      const SizedBox(height: 16),
                      BmiResultCard(result: state.result!),
                      const SizedBox(height: 24),
                      if (state.history.isNotEmpty) ...<Widget>[
                        Text('Recent BMI Results', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        ...state.history.map(
                          (BmiResultEntity item) => Card(
                            child: ListTile(
                              title: Text('${item.category} • ${item.value.toStringAsFixed(1)}'),
                              subtitle: Text(item.tip),
                            ),
                          ),
                        )
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
    ),
    );
  }
}
