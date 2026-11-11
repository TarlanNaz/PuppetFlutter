import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/bloc/detail/module_detail_state.dart';

class ModuleDetailCubit extends Cubit<ModuleDetailState> {
  ModuleDetailCubit(this._repository) : super(const ModuleDetailLoading());

  final IModuleRepository _repository;

  // Открытие экрана и «Повторить» делают одно и то же.
  Future<void> load(String slug) async {
    emit(const ModuleDetailLoading());
    try {
      final details = await _repository.getDetails(slug);
      // Пока ждали ответ, экран могли закрыть. emit после close — ошибка.
      if (isClosed) return;
      emit(ModuleDetailLoaded(details));
    } on NotFoundException {
      if (isClosed) return;
      emit(ModuleDetailNotFound(slug));
    } on LoadException catch (error) {
      if (isClosed) return;
      emit(ModuleDetailFailure(slug, error));
    }
  }
}
