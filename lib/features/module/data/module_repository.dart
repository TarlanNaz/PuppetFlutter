import 'package:puppet/features/module/data/mock_modules.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/domain/module_model.dart';

final class ModuleRepository implements IModuleRepository {
  const ModuleRepository();

  @override
  Future<List<ModuleModel>> getModules() async => mockModules;

  @override
  Future<ModuleModel?> getModule(String slug) async {
    for (final module in mockModules) {
      if (module.slug == slug) return module;
    }
    return null;
  }

  @override
  Future<List<ModuleModel>> searchModules(String query) async {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return mockModules;
    return [
      for (final module in mockModules)
        if (module.name.toLowerCase().contains(text) ||
            module.ownerUsername.toLowerCase().contains(text))
          module,
    ];
  }

  @override
  Future<List<ModuleModel>> getModulesByOwner(String ownerUsername) async {
    return [
      for (final module in mockModules)
        if (module.ownerUsername == ownerUsername) module,
    ];
  }
}
