import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

/// Settings page.
class SettingsPage extends StatelessWidget {
  /// Creates [SettingsPage].
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.settingsTitle),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return ListView(
            padding: const EdgeInsets.all(AppSizes.md),
            children: <Widget>[
              Text(AppStrings.themeMode, style: Theme.of(context).textTheme.titleMedium),
              RadioListTile<AppThemeMode>(
                value: AppThemeMode.system,
                groupValue: state.themeMode,
                onChanged: (AppThemeMode? mode) {
                  if (mode != null) {
                    context.read<SettingsBloc>().add(ThemeModeChanged(mode));
                  }
                },
                title: Text(AppStrings.system),
              ),
              RadioListTile<AppThemeMode>(
                value: AppThemeMode.light,
                groupValue: state.themeMode,
                onChanged: (AppThemeMode? mode) {
                  if (mode != null) {
                    context.read<SettingsBloc>().add(ThemeModeChanged(mode));
                  }
                },
                title: Text(AppStrings.light),
              ),
              RadioListTile<AppThemeMode>(
                value: AppThemeMode.dark,
                groupValue: state.themeMode,
                onChanged: (AppThemeMode? mode) {
                  if (mode != null) {
                    context.read<SettingsBloc>().add(ThemeModeChanged(mode));
                  }
                },
                title: Text(AppStrings.dark),
              ),
              const SizedBox(height: AppSizes.lg),
              Text(AppStrings.currencyPreference, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSizes.sm),
              DropdownButtonFormField<String>(
                value: state.currency,
                items: const <String>['USD', 'EUR', 'GBP', 'NGN']
                    .map((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
                    .toList(),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (String? value) {
                  if (value != null) {
                    context.read<SettingsBloc>().add(CurrencyPreferenceChanged(value));
                  }
                },
              ),
              const SizedBox(height: AppSizes.lg),
              ListTile(
                title: Text(AppStrings.clearAllHistory),
                trailing: const Icon(Icons.delete_outline),
                onTap: () {
                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text('Clear all calculator, BMI, and converter history?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<SettingsBloc>().add(const ClearAllHistoryRequested());
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(AppStrings.clearAllNotes),
                trailing: const Icon(Icons.delete_forever_outlined),
                onTap: () {
                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text('Delete all saved notes permanently?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<SettingsBloc>().add(const ClearAllNotesRequested());
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSizes.lg),
              ListTile(
                title: Text(AppStrings.rateThisApp),
                trailing: const Icon(Icons.star_border),
                onTap: () {},
              ),
              const SizedBox(height: AppSizes.lg),
              Text('${AppStrings.appVersion}: ${AppConstants.appVersion}', style: Theme.of(context).textTheme.bodyMedium),
            ],
          );
        },
      ),
    );
  }
}
