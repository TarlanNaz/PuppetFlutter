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
  String get searchHint => 'Поиск по названию или автору';

  @override
  String get actionClearSearch => 'Очистить поиск';

  @override
  String get actionToggleTheme => 'Сменить тему';

  @override
  String get actionToggleLanguage => 'Сменить язык';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get pageNotFound => 'Страница не найдена';

  @override
  String moduleNotFound(String slug) {
    return 'Модуль $slug не найден';
  }

  @override
  String moduleOwner(String owner) {
    return 'автор: $owner';
  }

  @override
  String moduleDownloads(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count загрузок',
      few: '$count загрузки',
      one: '$count загрузка',
    );
    return '$_temp0';
  }

  @override
  String get noSummary => 'Описания нет';

  @override
  String get labelOwner => 'Автор';

  @override
  String get labelVersion => 'Версия';

  @override
  String get labelDownloads => 'Загрузки';

  @override
  String get labelLicense => 'Лицензия';

  @override
  String get labelUpdatedAt => 'Обновлён';

  @override
  String get sectionTags => 'Теги';

  @override
  String get sectionOtherModules => 'Другие модули автора';

  @override
  String get errorNoConnection => 'Нет связи с сервером. Проверьте интернет';

  @override
  String get errorTimeout => 'Сервер долго не отвечает';

  @override
  String get errorNotFound => 'Такой записи нет';

  @override
  String errorServer(String code) {
    return 'Ошибка сервера ($code)';
  }

  @override
  String get errorBadResponse => 'Сервер прислал непонятный ответ';

  @override
  String get actionRetry => 'Повторить';
}
