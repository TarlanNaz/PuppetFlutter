import 'dart:async';

import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/data/data_sources/i_module_data_source.dart';
import 'package:puppet/features/module/data/dto/module_dto.dart';
import 'package:puppet/features/module/data/dto/module_page_dto.dart';
import 'package:puppet/features/module/data/mappers/module_mapper.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/domain/module_details.dart';
import 'package:puppet/features/module/domain/module_page.dart';

// Репозиторий на сети. Берёт DTO у датасорса и отдаёт наверх только модели.
// Ошибки датасорса уже переведены в LoadException и идут наверх как есть.
final class ModuleRepository implements IModuleRepository {
  const ModuleRepository(this._dataSource);

  final IModuleDataSource _dataSource;

  static const int _relatedCount = 3;

  @override
  Future<ModulePage> searchModules(
    String query, {
    required int offset,
    required int limit,
  }) async {
    final page = await _dataSource.getModules(
      offset: offset,
      limit: limit,
      query: query.trim(),
    );
    return ModulePage(
      items: [for (final dto in page.results) dto.toModel()],
      hasMore: page.pagination.next != null,
    );
  }

  @override
  Future<ModuleDetails> getDetails(String slug) async {
    // Slug вида `автор-название`, поэтому автора видно сразу и модули автора
    // можно запросить параллельно с самим модулем.
    final dash = slug.indexOf('-');
    if (dash <= 0) throw const NotFoundException();
    final owner = slug.substring(0, dash);

    final ModuleDto module;
    final ModulePageDto sameOwner;
    try {
      (module, sameOwner) = await (
        _dataSource.getModule(slug),
        // На один больше: сам модуль тоже придёт в ответе.
        _dataSource.getModules(
          offset: 0,
          limit: _relatedCount + 1,
          owner: owner,
        ),
      ).wait;
    } on ParallelWaitError<(ModuleDto?, ModulePageDto?), (AsyncError?, AsyncError?)>
    catch (error) {
      // .wait у пары бросает ParallelWaitError с ошибками обоих запросов.
      // Наверх отдаём первую, это LoadException. Если модуля нет, это
      // ошибка первого запроса, и экран покажет «не найден».
      final first = (error.errors.$1 ?? error.errors.$2)!;
      Error.throwWithStackTrace(first.error, first.stackTrace);
    }

    return ModuleDetails(
      module: module.toModel(),
      related: [
        for (final dto in sameOwner.results)
          if (dto.slug != module.slug) dto.toModel(),
      ].take(_relatedCount).toList(),
    );
  }
}
