import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/common/widgets/app_scaffold.dart';
import 'package:puppet/common/widgets/load_error_view.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_cubit.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_state.dart';
import 'package:puppet/features/module/presentation/view/widgets/module_card.dart';
import 'package:puppet/features/module/presentation/view/widgets/search_field.dart';
import 'package:puppet/l10n/app_localizations.dart';

class ModuleListScreen extends StatelessWidget {
  const ModuleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ModuleListCubit>();
    return AppScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(onChanged: cubit.search),
          ),
          Expanded(
            child: BlocBuilder<ModuleListCubit, ModuleListState>(
              builder: (context, state) => switch (state) {
                ModuleListLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ModuleListFailure(:final error) => Center(
                    child: LoadErrorView(error: error, onRetry: cubit.retry),
                  ),
                ModuleListLoaded(:final items) when items.isEmpty => Center(
                    child: Text(AppLocalizations.of(context).nothingFound),
                  ),
                ModuleListLoaded() => _ModuleList(state: state),
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Список с подгрузкой страниц. ScrollController показывает, что список
// докручен почти до конца.
class _ModuleList extends StatefulWidget {
  const _ModuleList({required this.state});

  final ModuleListLoaded state;

  @override
  State<_ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<_ModuleList> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.extentAfter < 300) {
      context.read<ModuleListCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final showFooter = state.isLoadingMore || state.loadMoreError != null;
    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + (showFooter ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => index < state.items.length
          ? ModuleCard(module: state.items[index])
          : _Footer(state: state),
    );
  }
}

// Под списком: индикатор догрузки или ошибка с «Повторить».
class _Footer extends StatelessWidget {
  const _Footer({required this.state});

  final ModuleListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;
    return Center(
      child: error == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          : LoadErrorView(
              error: error,
              onRetry: context.read<ModuleListCubit>().loadMore,
            ),
    );
  }
}
