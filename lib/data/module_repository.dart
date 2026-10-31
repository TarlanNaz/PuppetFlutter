import '../models/puppet_module.dart';
import 'mock_modules.dart';

class ModuleRepository {
  List<PuppetModule> search(String query) {
    final text = query.toLowerCase();
    return mockModules.where((module) {
      return module.name.toLowerCase().contains(text) ||
          module.summary.toLowerCase().contains(text);
    }).toList();
  }

  PuppetModule? getBySlug(String slug) {
    for (final module in mockModules) {
      if (module.slug == slug) {
        return module;
      }
    }
    return null;
  }
}
