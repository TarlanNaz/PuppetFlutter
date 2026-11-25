import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_state.dart';

class ModuleListCubit extends Cubit<ModuleListState> {
  ModuleListCubit(this._repository) : super(const ModuleListLoading());

  final IModuleRepository _repository;

  static const int _pageSize = 20;
  static const Duration _searchDelay = Duration(milliseconds: 400);

  // Номер последнего запроса первой страницы. Ответ на старый запрос
  // (пользователь уже ввёл новый текст) выбрасывается.
  int _lastRequest = 0;
  Timer? _searchTimer;

  Future<void> load() => _fetch(state.query);

  Future<void> retry() => _fetch(state.query);

  // Запрос уходит не на каждую букву, а через паузу после последней.
  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(_searchDelay, () => _fetch(query.trim()));
  }

  // Экран зовёт метод, когда список докручен почти до конца, и может
  // позвать его много раз подряд. Лишние вызовы отсекаются здесь.
  Future<void> loadMore() async {
    final current = state;
    if (current is! ModuleListLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    final request = _lastRequest;
    emit(
      ModuleListLoaded(
        query: current.query,
        items: current.items,
        hasMore: true,
        isLoadingMore: true,
      ),
    );
    try {
      final page = await _repository.searchModules(
        current.query,
        // Смещение по тому, что уже показано.
        offset: current.items.length,
        limit: _pageSize,
      );
      if (isClosed || request != _lastRequest) return;
      // Пока листали, порядок на сервере мог сдвинуться: один модуль
      // пришёл бы второй раз. Такие отбрасываем.
      final shown = {for (final module in current.items) module.slug};
      emit(
        ModuleListLoaded(
          query: current.query,
          items: [
            ...current.items,
            ...page.items.where((module) => !shown.contains(module.slug)),
          ],
          hasMore: page.hasMore,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || request != _lastRequest) return;
      emit(
        ModuleListLoaded(
          query: current.query,
          items: current.items,
          hasMore: true,
          loadMoreError: error,
        ),
      );
    }
  }

  Future<void> _fetch(String query) async {
    final request = ++_lastRequest;
    emit(ModuleListLoading(query: query));
    try {
      final page = await _repository.searchModules(
        query,
        offset: 0,
        limit: _pageSize,
      );
      if (isClosed || request != _lastRequest) return;
      emit(
        ModuleListLoaded(query: query, items: page.items, hasMore: page.hasMore),
      );
    } on LoadException catch (error) {
      if (isClosed || request != _lastRequest) return;
      emit(ModuleListFailure(query: query, error: error));
    }
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
