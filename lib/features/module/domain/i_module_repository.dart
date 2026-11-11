import 'package:puppet/features/module/domain/module_model.dart';

abstract interface class IModuleRepository {
  Future<List<ModuleModel>> getModules();

  Future<ModuleModel?> getModule(String slug);

  Future<List<ModuleModel>> searchModules(String query);

  Future<List<ModuleModel>> getModulesByOwner(String ownerUsername);
}
