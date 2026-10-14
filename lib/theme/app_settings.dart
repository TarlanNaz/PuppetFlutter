import 'package:flutter/material.dart';

// Настройки приложения: тема и язык.
// После изменения вызываем notifyListeners(), чтобы экран перерисовался
class AppSettings extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('en');

  void toggleTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void toggleLocale() {
    if (locale.languageCode == 'en') {
      locale = const Locale('ru');
    } else {
      locale = const Locale('en');
    }
    notifyListeners();
  }
}
