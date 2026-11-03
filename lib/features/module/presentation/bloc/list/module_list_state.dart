import 'package:puppet/features/module/domain/module_model.dart';

final class ModuleListState {
  const ModuleListState({this.items = const [], this.query = ''});

  final List<ModuleModel> items;
  final String query;

  ModuleListState copyWith({List<ModuleModel>? items, String? query}) =>
      ModuleListState(
        items: items ?? this.items,
        query: query ?? this.query,
      );
}
