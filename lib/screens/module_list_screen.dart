import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../data/mock_modules.dart';
import '../models/puppet_module.dart';
import '../theme/app_settings.dart';

class ModuleListScreen extends StatefulWidget {
  const ModuleListScreen({super.key});

  @override
  State<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends State<ModuleListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    final filteredModules = mockModules.where((module) {
      return module.name.toLowerCase().contains(_searchQuery) ||
             module.summary.toLowerCase().contains(_searchQuery) ||
             module.slug.toLowerCase().contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.modulesListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.languageToggle,
            onPressed: () {
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
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: l10n.searchModules,
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
              ],
              elevation: const WidgetStatePropertyAll(1.0),
            ),
          ),
          Expanded(
            child: filteredModules.isEmpty
                ? Center(
                    child: Text(
                      l10n.noResults,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredModules.length,
                    itemBuilder: (context, index) {
                      final module = filteredModules[index];
                      return _ModuleListItem(
                        module: module,
                        onTap: () {
                          context.push('/module/${module.slug}');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ModuleListItem extends StatelessWidget {
  final PuppetModule module;
  final VoidCallback onTap;

  const _ModuleListItem({
    required this.module,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListTile(
      title: Text(module.name, style: theme.textTheme.titleMedium),
      subtitle: Text(
        '${l10n.downloads}: ${module.downloads} | ${l10n.owner}: ${module.ownerUsername}',
        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
