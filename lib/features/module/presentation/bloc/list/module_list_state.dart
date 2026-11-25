import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/domain/module_model.dart';

sealed class ModuleListState {
  const ModuleListState({required this.query});

  final String query;
}

final class ModuleListLoading extends ModuleListState {
  const ModuleListLoading({super.query = ''});
}

final class ModuleListLoaded extends ModuleListState {
  const ModuleListLoaded({
    required super.query,
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<ModuleModel> items;

  // На сервере есть ещё страницы.
  final bool hasMore;

  // Догружается следующая страница: внизу списка индикатор.
  final bool isLoadingMore;

  // Следующая страница не загрузилась: загруженное остаётся,
  // внизу кнопка «Повторить».
  final LoadException? loadMoreError;
}

// Первая страница не загрузилась.
final class ModuleListFailure extends ModuleListState {
  const ModuleListFailure({required super.query, required this.error});

  final LoadException error;
}
