import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/usecases/split_bill.dart';
import '../bloc/bill_bloc.dart';
import '../bloc/bill_event.dart';
import '../bloc/bill_state.dart';
import '../widgets/split_result_card.dart';

/// Bill splitter page.
class BillSplitterPage extends StatelessWidget {
  /// Creates [BillSplitterPage].
  const BillSplitterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController(text: '0');
    return BlocProvider<BillBloc>(
      create: (_) => BillBloc(const SplitBill())
        ..add(
          const BillInputsChanged(
            billAmount: 0,
            tipPercent: 10,
            people: 2,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.billSplitter)),
        body: BlocBuilder<BillBloc, BillState>(
          builder: (BuildContext context, BillState state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppStrings.totalAmount, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    onChanged: (String value) {
                      context.read<BillBloc>().add(
                            BillInputsChanged(
                              billAmount: double.tryParse(value) ?? 0,
                              tipPercent: state.tipPercent,
                              people: state.people,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('${AppStrings.tip}: ${state.tipPercent.toStringAsFixed(0)}%', style: Theme.of(context).textTheme.bodyLarge),
                  Slider(
                    value: state.tipPercent,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label: '${state.tipPercent.toStringAsFixed(0)}%',
                    onChanged: (double value) {
                      context.read<BillBloc>().add(
                            BillInputsChanged(
                              billAmount: double.tryParse(amountController.text) ?? 0,
                              tipPercent: value,
                              people: state.people,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          final int nextPeople = state.people > 1 ? state.people - 1 : state.people;
                          context.read<BillBloc>().add(
                                BillInputsChanged(
                                  billAmount: double.tryParse(amountController.text) ?? 0,
                                  tipPercent: state.tipPercent,
                                  people: nextPeople,
                                ),
                              );
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Expanded(child: Text('${AppStrings.people}: ${state.people}', style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center)),
                      IconButton(
                        onPressed: () {
                          context.read<BillBloc>().add(
                                BillInputsChanged(
                                  billAmount: double.tryParse(amountController.text) ?? 0,
                                  tipPercent: state.tipPercent,
                                  people: state.people + 1,
                                ),
                              );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SplitResultCard(result: state.result, currency: '\$'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
