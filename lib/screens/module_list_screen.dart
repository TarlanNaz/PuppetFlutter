import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/module_list_cubit.dart';
import '../cubit/settings_cubit.dart';
import '../l10n/app_localizations.dart';

class ModuleListScreen extends StatefulWidget {
  const ModuleListScreen({super.key});

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.modulesListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.languageToggle,
            onPressed: () => context.read<SettingsCubit>().toggleLocale(),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: l10n.themeToggle,
            onPressed: () => context.read<SettingsCubit>().toggleTheme(),
          ),
        ],
      ),
      body: BlocBuilder<ModuleListCubit, ModuleListState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: l10n.searchModules,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    suffixIcon: state.query.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              context.read<ModuleListCubit>().search('');
                            },
                          ),
                  ),
                  onChanged: (text) =>
                      context.read<ModuleListCubit>().search(text),
                ),
              ),
              Expanded(
                child: state.modules.isEmpty
                    ? Center(child: Text(l10n.noResults))
                    : ListView.builder(
                        itemCount: state.modules.length,
                        itemBuilder: (context, index) {
                          final module = state.modules[index];
                          return ListTile(
                            title: Text(module.name),
                            subtitle: Text(
                              '${l10n.downloads}: ${module.downloads} | ${l10n.owner}: ${module.ownerUsername}',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push('/module/${module.slug}'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
