# Puppet Forge на Flutter (ЛР2, ЛР3)

Каталог модулей Puppet Forge. С ЛР3 данные приходят из сети, из того же
источника, что в ЛР1: API Puppet Forge `https://forgeapi.puppet.com/v3`.
Моков в `lib/` нет.

## Сеть (ЛР3)

Цепочка: **API-клиент → датасорс → репозиторий → Cubit → экран.**

| Файл | Что делает |
|---|---|
| `common/network/dio_client.dart` | Dio: базовый адрес, таймауты, `LogInterceptor` в debug |
| `common/network/load_exception.dart` | `sealed class LoadException`: нет сети, таймаут, 404, ошибка сервера, непонятный ответ |
| `common/widgets/load_error_view.dart` | Сообщение об ошибке и кнопка «Повторить» |
| `features/module/data/api/module_api.dart` | `ModuleApi`: один метод на один адрес, возвращает DTO |
| `features/module/data/dto/` | DTO на `json_serializable`, рядом сгенерированные `.g.dart` |
| `features/module/data/data_sources/` | `IModuleDataSource` и `NetworkModuleDataSource`: `DioException` → `LoadException` |
| `features/module/data/mappers/module_mapper.dart` | `extension ModuleDtoMapper on ModuleDto { toModel() }` |
| `features/module/data/module_repository.dart` | Репозиторий на датасорсе, модуль и модули автора грузятся параллельно |
| `app.dart` | `ModuleRepository(NetworkModuleDataSource(ModuleApi(DioClient.create())))` |

Какие адреса зовёт приложение:

| Экран | Запросы |
|---|---|
| Список и поиск | `/modules?offset=N&limit=20&sort_by=downloads[&query=...]`, следующая страница при прокрутке |
| Деталь | `/modules/{slug}` и `/modules?owner={автор}&limit=4` параллельно |

Поиск уходит на сервер через 400 мс после последней буквы. Ответ на
устаревший запрос отбрасывается. При подгрузке страниц повторы отсекаются
по `slug`.

После правки DTO код генерируется заново:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Экраны

- Список: значок с первой буквой, название, автор, число загрузок.
  Поиск по названию или автору, «Ничего не найдено» при пустом результате.
- Деталь: название, описание, автор, версия, загрузки, лицензия, дата
  обновления, теги и блок «Другие модули автора». Переход в другой модуль
  через `context.push`, «назад» возвращает по одному экрану.
- Тема и язык переключаются кнопками в шапке на обоих экранах.

## Устройство

- State manager: `flutter_bloc`, Cubit.
  - `ModuleListCubit` (`load()`, `search(query)`, `loadMore()`, `retry()`) создан в корне,
    поэтому запрос и результат поиска сохраняются после возврата из детали.
  - `ModuleDetailCubit` создаёт экран детали, состояние `sealed`:
    `Loading`, `Loaded`, `NotFound`, `Failure`.
  - `ThemeCubit` и `LocaleCubit` в корне через `MultiBlocProvider`.
- Репозиторий: интерфейс `IModuleRepository` в `domain`, реализация
  `ModuleRepository` в `data` берёт данные из `IModuleDataSource`,
  регистрируется через `RepositoryProvider`.
- Навигация: `go_router`, адрес детали `/module/:slug`.
- Тема: `ColorScheme.fromSeed` из `AppColors.seed`, классы `AppTheme`, `AppColors`.
- Подписи: ARB `ru`/`en`, `gen_l10n`.

```text
lib/
  main.dart, app.dart
  common/      locale/, navigation/, network/, theme/, widgets/
  features/module/
    data/          api/, dto/, data_sources/, mappers/, ModuleRepository
    domain/        ModuleModel, ModulePage, ModuleDetails, IModuleRepository
    presentation/  bloc/, view/, view/widgets/, utils/
```

## Запуск

```bash
flutter pub get
dart run tool/check_arb.dart
flutter run -d chrome
flutter run -d windows
```
