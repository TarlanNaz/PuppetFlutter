import 'package:dio/dio.dart';
import 'package:puppet/features/module/data/dto/module_dto.dart';
import 'package:puppet/features/module/data/dto/module_page_dto.dart';

// API-клиент Puppet Forge: один метод на один адрес, ответ разбирается в DTO.
// Что делать с ошибками, решает датасорс.
final class ModuleApi {
  const ModuleApi(this._dio);

  final Dio _dio;

  // Readme, changelog и прочие тексты весят сотни килобайт, приложению
  // они не нужны. Сервер их не присылает, если перечислить их здесь.
  static const String _excludeFields =
      'readme changelog license reference tasks plans';

  // [query] ищет по названию, автору и тегам. [owner] оставляет модули
  // одного автора. Сортировка по загрузкам, как было в моках.
  Future<ModulePageDto> getModules({
    required int offset,
    required int limit,
    String? query,
    String? owner,
  }) async {
    final json = await _getJson(
      '/modules',
      queryParameters: {
        'offset': offset,
        'limit': limit,
        'sort_by': 'downloads',
        'exclude_fields': _excludeFields,
        if (query != null && query.isNotEmpty) 'query': query,
        if (owner != null) 'owner': owner,
      },
    );
    return ModulePageDto.fromJson(json);
  }

  Future<ModuleDto> getModule(String slug) async => ModuleDto.fromJson(
    await _getJson(
      '/modules/$slug',
      queryParameters: {'exclude_fields': _excludeFields},
    ),
  );

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data ?? (throw const FormatException('Пустой ответ'));
  }
}
