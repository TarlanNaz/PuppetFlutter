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
  String get modulesListTitle => 'Modules';

  @override
  String get moduleDetailsTitle => 'Module Details';

  @override
  String get downloads => 'Downloads';

  @override
  String get version => 'Version';

  @override
  String get owner => 'Owner';

  @override
  String get license => 'License';

  @override
  String get updatedAt => 'Updated at';

  @override
  String get tags => 'Tags';

  @override
  String get themeToggle => 'Toggle Theme';

  @override
  String get languageToggle => 'Toggle Language';

  @override
  String get noSummary => 'No summary provided.';

  @override
  String get searchModules => 'Search modules...';

  @override
  String get noResults => 'No modules found.';
}
