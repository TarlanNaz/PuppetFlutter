# Puppet Forge (ЛР1)

Приложение на Flutter для просмотра модулей [Puppet Forge](https://forge.puppet.com/).
Пока без сети, данные лежат в моках.

## Что сделано

- 20 моков модулей, поля взяты из ответа `forgeapi.puppet.com/v3/modules`
- Список модулей с поиском по названию и описанию
- Экран модуля, переход через `go_router` (`/` и `/module/:slug`), кнопка "назад" работает
- Светлая и тёмная тема (`ColorScheme.fromSeed`)
- Два языка: русский и английский, тексты в `lib/l10n/*.arb`
- Тема и язык хранятся в `AppSettings` (пакет `provider`), строка поиска - в `StatefulWidget`

## Структура

```text
lib/
├── data/mock_modules.dart          # моки
├── l10n/                           # переводы
├── models/puppet_module.dart       # модель модуля
├── navigation/app_router.dart      # маршруты
├── screens/
│   ├── module_list_screen.dart     # список + поиск
│   └── module_detail_screen.dart   # экран модуля
├── theme/
│   ├── app_settings.dart           # тема и язык
│   └── app_theme.dart              # светлая и тёмная тема
├── widgets/module_list_item.dart   # строка списка
└── main.dart
```

## Запуск

```bash
flutter pub get
flutter run
```
