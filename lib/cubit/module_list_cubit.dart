import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/module_repository.dart';
import '../models/puppet_module.dart';

class ModuleListState {
  final String query;
  final List<PuppetModule> modules;

  const ModuleListState({required this.query, required this.modules});
}

class ModuleListCubit extends Cubit<ModuleListState> {
  final ModuleRepository repository;

  ModuleListCubit(this.repository)
      : super(ModuleListState(query: '', modules: repository.search('')));

  void search(String query) {
    emit(ModuleListState(query: query, modules: repository.search(query)));
  }
}
