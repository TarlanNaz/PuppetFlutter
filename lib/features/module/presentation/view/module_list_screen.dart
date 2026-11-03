import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/common/widgets/app_scaffold.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_cubit.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_state.dart';
import 'package:puppet/features/module/presentation/view/widgets/module_card.dart';
import 'package:puppet/features/module/presentation/view/widgets/search_field.dart';
import 'package:puppet/l10n/app_localizations.dart';

class ModuleListScreen extends StatelessWidget {
  const ModuleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(
              onChanged: context.read<ModuleListCubit>().search,
            ),
          ),
          Expanded(
            child: BlocBuilder<ModuleListCubit, ModuleListState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context).nothingFound),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) =>
                      ModuleCard(module: state.items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
