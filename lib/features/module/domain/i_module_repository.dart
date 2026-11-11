import 'package:puppet/features/module/domain/module_details.dart';
import 'package:puppet/features/module/domain/module_page.dart';

// Cubit знают только этот интерфейс. При ошибке методы бросают
// LoadException из common/network.
abstract interface class IModuleRepository {
  // Страница списка: [limit] модулей начиная с [offset]. Пустой [query]
  // значит «все модули».
  Future<ModulePage> searchModules(
    String query, {
    required int offset,
    required int limit,
  });

  // Модуль и другие модули автора. Нет такого модуля: NotFoundException.
  Future<ModuleDetails> getDetails(String slug);
}
