import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_state.dart';

class ModuleListCubit extends Cubit<ModuleListState> {
  ModuleListCubit(this._repository) : super(const ModuleListState());

  final IModuleRepository _repository;

  Future<void> load() async {
    final items = await _repository.getModules();
    if (isClosed) return;
    emit(state.copyWith(items: items));
  }

  Future<void> search(String query) async {
    emit(state.copyWith(query: query));
    final items = await _repository.searchModules(query);
    if (isClosed) return;
    emit(state.copyWith(items: items));
  }
}
