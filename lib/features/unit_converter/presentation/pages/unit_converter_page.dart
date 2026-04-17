import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/datasources/converter_local_datasource.dart';
import '../bloc/converter_bloc.dart';
import '../bloc/converter_event.dart';
import '../bloc/converter_state.dart';
import '../widgets/category_selector.dart';
import '../widgets/conversion_input.dart';
import '../widgets/conversion_result.dart';

/// Unit converter page.
class UnitConverterPage extends StatelessWidget {
  /// Creates [UnitConverterPage].
  const UnitConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<dynamic> box = Hive.box<dynamic>(AppConstants.converterHistoryBox);
    return BlocProvider<ConverterBloc>(
      create: (_) => ConverterBloc(ConverterLocalDataSource(box))
        ..add(const ConversionHistoryRequested()),
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.unitConverter),
        body: BlocBuilder<ConverterBloc, ConverterState>(
          builder: (BuildContext context, ConverterState state) {
            final List<String> currentUnits = ConverterBloc.units[state.category] ?? <String>[];
            return ListView(
              padding: const EdgeInsets.all(AppSizes.md),
              children: <Widget>[
                CategorySelector(
                  categories: ConverterBloc.units.keys.toList(),
                  selected: state.category,
                  onSelected: (String value) => context.read<ConverterBloc>().add(ConversionCategoryChanged(value)),
                ),
                const SizedBox(height: AppSizes.lg),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: state.from,
                        decoration: const InputDecoration(labelText: AppStrings.from),
                        items: currentUnits
                            .map((String e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            context.read<ConverterBloc>().add(ConversionUnitChanged(from: value, to: state.to));
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz),
                      onPressed: () {
                        context.read<ConverterBloc>().add(ConversionUnitChanged(from: state.to, to: state.from));
                      },
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: state.to,
                        decoration: const InputDecoration(labelText: AppStrings.to),
                        items: currentUnits
                            .map((String e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            context.read<ConverterBloc>().add(ConversionUnitChanged(from: state.from, to: value));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                ConversionInput(onChanged: (String value) => context.read<ConverterBloc>().add(ConversionInputChanged(value))),
                const SizedBox(height: AppSizes.lg),
                ConversionResult(value: state.output),
                const SizedBox(height: AppSizes.md),
                Text(AppStrings.lastUpdated, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: AppSizes.lg),
                Text(AppStrings.results, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSizes.sm),
                if (state.history.isEmpty)
                  const Center(child: Text(AppStrings.noHistory))
                else
                  ...state.history.map(
                    (conversion) => Card(
                      margin: const EdgeInsets.only(bottom: AppSizes.sm),
                      child: ListTile(
                        title: Text('${conversion.input} ${conversion.fromUnit} → ${conversion.output} ${conversion.toUnit}'),
                        subtitle: Text('${conversion.category} • ${conversion.timestamp.toLocal().toString().split(' ').first}'),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
