import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/bloc/detail/module_detail_state.dart';

class ModuleDetailCubit extends Cubit<ModuleDetailState> {
  ModuleDetailCubit(this._repository) : super(const ModuleDetailLoading());

  final IModuleRepository _repository;

  Future<void> load(String slug) async {
    final module = await _repository.getModule(slug);
    if (isClosed) return;
    if (module == null) {
      emit(ModuleDetailNotFound(slug));
      return;
    }
    final sameOwner = await _repository.getModulesByOwner(module.ownerUsername);
    if (isClosed) return;
    final related = sameOwner.where((m) => m.slug != slug).take(3).toList();
    emit(ModuleDetailLoaded(module, related: related));
  }
}
