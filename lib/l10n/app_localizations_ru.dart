// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Puppet Forge';

  @override
  String get modulesListTitle => 'Модули';

  @override
  String get moduleDetailsTitle => 'Детали модуля';

  @override
  String get downloads => 'Скачиваний';

  @override
  String get version => 'Версия';

  @override
  String get owner => 'Владелец';

  @override
  String get license => 'Лицензия';

  @override
  String get updatedAt => 'Обновлено';

  @override
  String get tags => 'Теги';

  @override
  String get themeToggle => 'Сменить тему';

  @override
  String get languageToggle => 'Сменить язык';

  @override
  String get noSummary => 'Описание отсутствует.';

  @override
  String get searchModules => 'Поиск модулей...';

  @override
  String get noResults => 'Модули не найдены.';
}
