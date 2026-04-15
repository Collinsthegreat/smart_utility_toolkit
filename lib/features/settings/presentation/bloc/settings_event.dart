import 'package:equatable/equatable.dart';
import 'settings_state.dart';

/// Events for settings state.
abstract class SettingsEvent extends Equatable {
  /// Creates [SettingsEvent].
  const SettingsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Theme mode changed event.
class ThemeModeChanged extends SettingsEvent {
  /// Creates [ThemeModeChanged].
  const ThemeModeChanged(this.themeMode);

  /// Selected theme mode.
  final AppThemeMode themeMode;

  @override
  List<Object?> get props => <Object?>[themeMode];
}

/// Currency preference changed event.
class CurrencyPreferenceChanged extends SettingsEvent {
  /// Creates [CurrencyPreferenceChanged].
  const CurrencyPreferenceChanged(this.currency);

  /// Selected currency code.
  final String currency;

  @override
  List<Object?> get props => <Object?>[currency];
}

/// Clear all history event.
class ClearAllHistoryRequested extends SettingsEvent {
  /// Creates [ClearAllHistoryRequested].
  const ClearAllHistoryRequested();
}

/// Clear all notes event.
class ClearAllNotesRequested extends SettingsEvent {
  /// Creates [ClearAllNotesRequested].
  const ClearAllNotesRequested();
}

