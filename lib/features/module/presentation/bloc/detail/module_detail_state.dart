import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/domain/module_details.dart';

sealed class ModuleDetailState {
  const ModuleDetailState();
}

final class ModuleDetailLoading extends ModuleDetailState {
  const ModuleDetailLoading();
}

final class ModuleDetailLoaded extends ModuleDetailState {
  const ModuleDetailLoaded(this.details);

  final ModuleDetails details;
}

// Сервер ответил 404. Повторять нечего.
final class ModuleDetailNotFound extends ModuleDetailState {
  const ModuleDetailNotFound(this.slug);

  final String slug;
}

// Любая другая ошибка. Можно повторить.
final class ModuleDetailFailure extends ModuleDetailState {
  const ModuleDetailFailure(this.slug, this.error);

  final String slug;
  final LoadException error;
}
