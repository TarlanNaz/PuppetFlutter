import 'package:puppet/features/module/domain/module_model.dart';

sealed class ModuleListState {
  const ModuleListState({required this.query});

  final String query;
}

final class ModuleListLoading extends ModuleListState {
  const ModuleListLoading({super.query = ''});
}

final class ModuleListLoaded extends ModuleListState {
  const ModuleListLoaded({required super.query, required this.items});

  final List<ModuleModel> items;
}
