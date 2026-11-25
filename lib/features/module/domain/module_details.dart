import 'package:puppet/features/module/domain/module_model.dart';

// Всё, что показывает экран детали.
final class ModuleDetails {
  const ModuleDetails({required this.module, required this.related});

  final ModuleModel module;

  // Другие модули того же автора, без самого модуля.
  final List<ModuleModel> related;
}
