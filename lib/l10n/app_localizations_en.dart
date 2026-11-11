// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Puppet Forge';

  @override
  String get searchHint => 'Search by name or author';

  @override
  String get actionClearSearch => 'Clear search';

  @override
  String get actionToggleTheme => 'Toggle theme';

  @override
  String get actionToggleLanguage => 'Change language';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String moduleNotFound(String slug) {
    return 'Module $slug not found';
  }

  @override
  String moduleOwner(String owner) {
    return 'by $owner';
  }

  @override
  String moduleDownloads(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count downloads',
      one: '$count download',
    );
    return '$_temp0';
  }

  @override
  String get noSummary => 'No description';

  @override
  String get labelOwner => 'Author';

  @override
  String get labelVersion => 'Version';

  @override
  String get labelDownloads => 'Downloads';

  @override
  String get labelLicense => 'License';

  @override
  String get labelUpdatedAt => 'Updated';

  @override
  String get sectionTags => 'Tags';

  @override
  String get sectionOtherModules => 'Other modules by this author';

  @override
  String get errorNoConnection =>
      'No connection to the server. Check your internet';

  @override
  String get errorTimeout => 'The server is taking too long to respond';

  @override
  String get errorNotFound => 'No such record';

  @override
  String errorServer(String code) {
    return 'Server error ($code)';
  }

  @override
  String get errorBadResponse => 'The server sent an unexpected response';

  @override
  String get actionRetry => 'Retry';
}
