# Puppet Forge (ЛР1)

Приложение на Flutter для просмотра модулей [Puppet Forge](https://forge.puppet.com/).
Пока без сети, данные лежат в моках.

## Что сделано

- 20 моков модулей, поля взяты из ответа `forgeapi.puppet.com/v3/modules`
- Список с поиском по названию и описанию, экран модуля
- Навигация через `go_router`: `/` и `/module/:slug`, кнопка "назад" работает
- Светлая и тёмная тема (`ColorScheme.fromSeed`)
- Два языка (русский и английский), тексты в `lib/l10n/*.arb`
- Состояние через `flutter_bloc` (Cubit)

## Как устроено состояние

- `ModuleRepository` - единственное место, откуда экраны получают модули. Позже сюда добавим запросы в сеть.
- `ModuleListCubit` хранит строку поиска и найденные модули. Экран вызывает `search(...)`, Cubit делает `emit`, `BlocBuilder` перерисовывает список.
- `SettingsCubit` хранит тему и язык. Кнопки в шапке вызывают `toggleTheme()` и `toggleLocale()`.
- Экраны сами ничего не хранят, кроме контроллера текстового поля.

## Структура

```text
lib/
├── cubit/
│   ├── module_list_cubit.dart   # поиск и список
│   └── settings_cubit.dart      # тема и язык
├── data/
│   ├── mock_modules.dart        # моки
│   └── module_repository.dart   # доступ к данным
├── l10n/                        # переводы
├── models/puppet_module.dart    # модель модуля
├── navigation/app_router.dart   # маршруты
├── screens/                     # список и экран модуля
├── theme/app_theme.dart         # светлая и тёмная тема
└── main.dart
```

## Запуск

```bash
flutter pub get
flutter run
```
