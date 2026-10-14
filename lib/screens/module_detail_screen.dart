import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../data/mock_modules.dart';

class ModuleDetailScreen extends StatelessWidget {
  final String slug;

  const ModuleDetailScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    // In a real app with state management, this would be fetched from a provider/repository
    final module = mockModules.firstWhere(
      (m) => m.slug == slug,
      orElse: () => mockModules.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(module.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              module.summary.isNotEmpty ? module.summary : l10n.noSummary,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _buildInfoRow(context, l10n.owner, module.ownerUsername),
            _buildInfoRow(context, l10n.version, module.version),
            _buildInfoRow(context, l10n.downloads, module.downloads.toString()),
            _buildInfoRow(context, l10n.license, module.license),
            _buildInfoRow(context, l10n.updatedAt, module.updatedAt),
            const SizedBox(height: 24),
            Text(
              l10n.tags,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: module.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  labelStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
