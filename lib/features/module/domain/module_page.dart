import 'package:puppet/features/module/domain/module_model.dart';

// Одна страница списка.
final class ModulePage {
  const ModulePage({required this.items, required this.hasMore});

  final List<ModuleModel> items;

  // На сервере есть следующая страница.
  final bool hasMore;
}
