import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// Settings BLoC.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// Creates [SettingsBloc].
  SettingsBloc()
      : _settingsBox = Hive.box<dynamic>(AppConstants.settingsBox),
        super(
          SettingsState(
            themeMode: _loadThemeMode(Hive.box<dynamic>(AppConstants.settingsBox)),
            currency: _loadCurrency(Hive.box<dynamic>(AppConstants.settingsBox)),
          ),
        ) {
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<CurrencyPreferenceChanged>(_onCurrencyPreferenceChanged);
    on<ClearAllHistoryRequested>(_onClearAllHistoryRequested);
    on<ClearAllNotesRequested>(_onClearAllNotesRequested);
  }

  final Box<dynamic> _settingsBox;

  static AppThemeMode _loadThemeMode(Box<dynamic> box) {
    switch (box.get(AppConstants.themeModeKey) as String?) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }

  static String _loadCurrency(Box<dynamic> box) {
    return box.get(AppConstants.currencyPreferenceKey, defaultValue: 'USD') as String;
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsBox.put(AppConstants.themeModeKey, event.themeMode.name);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onCurrencyPreferenceChanged(
    CurrencyPreferenceChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsBox.put(AppConstants.currencyPreferenceKey, event.currency);
    emit(state.copyWith(currency: event.currency));
  }

  Future<void> _onClearAllHistoryRequested(
    ClearAllHistoryRequested event,
    Emitter<SettingsState> emit,
  ) async {
    await Hive.box<dynamic>(AppConstants.converterHistoryBox).clear();
    await Hive.box<dynamic>(AppConstants.calculatorHistoryBox).clear();
    await Hive.box<dynamic>(AppConstants.bmiHistoryBox).clear();
  }

  Future<void> _onClearAllNotesRequested(
    ClearAllNotesRequested event,
    Emitter<SettingsState> emit,
  ) async {
    await Hive.box<dynamic>(AppConstants.notesBox).clear();
  }
}

