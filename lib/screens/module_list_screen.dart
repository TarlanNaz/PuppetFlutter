import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/mock_modules.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_settings.dart';
import '../widgets/module_list_item.dart';

class ModuleListScreen extends StatefulWidget {
  const ModuleListScreen({super.key});

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  final searchController = TextEditingController();
  String search = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // оставляем модули, у которых строка поиска есть в названии или описании
    final text = search.toLowerCase();
    final modules = mockModules.where((module) {
      return module.name.toLowerCase().contains(text) ||
          module.summary.toLowerCase().contains(text);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.modulesListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.languageToggle,
            onPressed: () {
              // read - просто вызываем метод, перерисовка тут не нужна
              context.read<AppSettings>().toggleLocale();
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: l10n.themeToggle,
            onPressed: () {
              context.read<AppSettings>().toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: l10n.searchModules,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                // крестик показываем, только если что-то введено
                suffixIcon: search.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            search = '';
                          });
                        },
                      ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          // Expanded нужен, чтобы список занял оставшееся место в Column
          Expanded(
            child: modules.isEmpty
                ? Center(child: Text(l10n.noResults))
                : ListView.builder(
                    itemCount: modules.length,
                    itemBuilder: (context, index) {
                      return ModuleListItem(module: modules[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
