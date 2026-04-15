import 'package:equatable/equatable.dart';

/// Theme mode options.
enum AppThemeMode { system, light, dark }

/// Settings state.
class SettingsState extends Equatable {
  /// Creates [SettingsState].
  const SettingsState({required this.themeMode, required this.currency});

  /// Selected theme mode.
  final AppThemeMode themeMode;

  /// Selected currency preference.
  final String currency;

  /// Returns copied state.
  SettingsState copyWith({AppThemeMode? themeMode, String? currency}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => <Object?>[themeMode, currency];
}

