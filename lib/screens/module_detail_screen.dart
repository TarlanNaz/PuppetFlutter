import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/module_repository.dart';
import '../l10n/app_localizations.dart';

class ModuleDetailScreen extends StatelessWidget {
  final String slug;

  const ModuleDetailScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final module = context.read<ModuleRepository>().getBySlug(slug);

    if (module == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.noResults)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(module.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(module.summary.isEmpty ? l10n.noSummary : module.summary),
            const SizedBox(height: 24),
            infoRow(l10n.owner, module.ownerUsername),
            infoRow(l10n.version, module.version),
            infoRow(l10n.downloads, module.downloads.toString()),
            infoRow(l10n.license, module.license),
            infoRow(l10n.updatedAt, module.updatedAt),
            const SizedBox(height: 24),
            Text(l10n.tags, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final tag in module.tags) Chip(label: Text(tag)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
