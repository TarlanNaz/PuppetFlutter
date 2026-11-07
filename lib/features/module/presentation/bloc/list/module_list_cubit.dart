import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_state.dart';

class ModuleListCubit extends Cubit<ModuleListState> {
  ModuleListCubit(this._repository) : super(const ModuleListLoading());

  final IModuleRepository _repository;

  int _lastRequest = 0;

  Future<void> load() => _fetch(state.query);

  Future<void> search(String query) => _fetch(query);

  Future<void> _fetch(String query) async {
    final request = ++_lastRequest;
    final items = await _repository.searchModules(query);
    if (isClosed || request != _lastRequest) return;
    emit(ModuleListLoaded(query: query, items: items));
  }
}
