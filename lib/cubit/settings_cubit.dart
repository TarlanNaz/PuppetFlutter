import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  const SettingsState({required this.themeMode, required this.locale});
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          themeMode: ThemeMode.light,
          locale: Locale('en'),
        ));

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(SettingsState(themeMode: newMode, locale: state.locale));
  }

  void toggleLocale() {
    final newLocale =
        state.locale.languageCode == 'en' ? const Locale('ru') : const Locale('en');
    emit(SettingsState(themeMode: state.themeMode, locale: newLocale));
  }
}
