import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/data/api/module_api.dart';
import 'package:puppet/features/module/data/data_sources/i_module_data_source.dart';
import 'package:puppet/features/module/data/dto/module_dto.dart';
import 'package:puppet/features/module/data/dto/module_page_dto.dart';

// Данные из сети. Здесь ошибки dio и разбора JSON становятся LoadException,
// выше про dio никто не знает.
final class NetworkModuleDataSource implements IModuleDataSource {
  const NetworkModuleDataSource(this._api);

  final ModuleApi _api;

  @override
  Future<ModulePageDto> getModules({
    required int offset,
    required int limit,
    String? query,
    String? owner,
  }) => _guard(
    () => _api.getModules(
      offset: offset,
      limit: limit,
      query: query,
      owner: owner,
    ),
  );

  @override
  Future<ModuleDto> getModule(String slug) => _guard(() => _api.getModule(slug));

  // await внутри try обязателен: без него ошибка Future пройдёт мимо catch.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      const NotFoundException(),
    DioExceptionType.badResponse => ServerException(error.response?.statusCode),
    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),
    _ => const NoConnectionException(),
  };
}
