# Puppet Forge — каркас на Flutter (ЛР2)

Каталог модулей Puppet Forge. Сети пока нет: 20 модулей лежат в моках
(`lib/features/module/data/mock_modules.dart`), поля взяты из ответа
`/v3/modules` API Puppet Forge.

## Экраны

- Список: значок с первой буквой, название, автор, число загрузок.
  Поиск по названию или автору, «Ничего не найдено» при пустом результате.
- Деталь: название, описание, автор, версия, загрузки, лицензия, дата
  обновления, теги и блок «Другие модули автора». Переход в другой модуль
  через `context.push`, «назад» возвращает по одному экрану.
- Тема и язык переключаются кнопками в шапке на обоих экранах.

## Устройство

- State manager: `flutter_bloc`, Cubit.
  - `ModuleListCubit` (`load()`, `search(query)`) создан в корне,
    поэтому запрос и результат поиска сохраняются после возврата из детали.
  - `ModuleDetailCubit` создаёт экран детали, состояние `sealed`:
    `Loading`, `Loaded`, `NotFound`.
  - `ThemeCubit` и `LocaleCubit` в корне через `MultiBlocProvider`.
- Репозиторий: интерфейс `IModuleRepository` в `domain`, реализация на моках
  `ModuleRepository` в `data`, регистрируется через `RepositoryProvider`.
- Навигация: `go_router`, адрес детали `/module/:slug`.
- Тема: `ColorScheme.fromSeed` из `AppColors.seed`, классы `AppTheme`, `AppColors`.
- Подписи: ARB `ru`/`en`, `gen_l10n`.

```text
lib/
  main.dart, app.dart
  common/      locale/, navigation/, theme/, widgets/
  features/module/
    data/          моки и ModuleRepository
    domain/        ModuleModel и IModuleRepository
    presentation/  bloc/, view/, view/widgets/, utils/
```

## Запуск

```bash
flutter pub get
dart run tool/check_arb.dart
flutter run -d chrome
flutter run -d windows
```
