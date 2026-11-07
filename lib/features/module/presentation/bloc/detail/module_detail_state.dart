import 'package:puppet/features/module/domain/module_model.dart';

sealed class ModuleDetailState {
  const ModuleDetailState();
}

final class ModuleDetailLoading extends ModuleDetailState {
  const ModuleDetailLoading();
}

final class ModuleDetailLoaded extends ModuleDetailState {
  const ModuleDetailLoaded(this.module, {required this.related});

  final ModuleModel module;
  final List<ModuleModel> related;
}

final class ModuleDetailNotFound extends ModuleDetailState {
  const ModuleDetailNotFound(this.slug);

  final String slug;
}
