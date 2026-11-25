import 'package:puppet/features/module/data/dto/module_dto.dart';
import 'package:puppet/features/module/data/dto/module_page_dto.dart';

// Откуда репозиторий берёт данные. При ошибке методы бросают LoadException.
abstract interface class IModuleDataSource {
  Future<ModulePageDto> getModules({
    required int offset,
    required int limit,
    String? query,
    String? owner,
  });

  Future<ModuleDto> getModule(String slug);
}
