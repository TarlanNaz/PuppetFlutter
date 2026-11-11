import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/common/widgets/app_scaffold.dart';
import 'package:puppet/common/widgets/load_error_view.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/domain/module_model.dart';
import 'package:puppet/features/module/presentation/bloc/detail/module_detail_cubit.dart';
import 'package:puppet/features/module/presentation/bloc/detail/module_detail_state.dart';
import 'package:puppet/features/module/presentation/view/widgets/info_row.dart';
import 'package:puppet/features/module/presentation/view/widgets/module_avatar.dart';
import 'package:puppet/features/module/presentation/view/widgets/module_card.dart';
import 'package:puppet/l10n/app_localizations.dart';

class ModuleDetailScreen extends StatelessWidget {
  const ModuleDetailScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ModuleDetailCubit(context.read<IModuleRepository>())..load(slug),
      child: AppScaffold(
        body: BlocBuilder<ModuleDetailCubit, ModuleDetailState>(
          builder: (context, state) => switch (state) {
            ModuleDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ModuleDetailNotFound(:final slug) => Center(
                child: Text(AppLocalizations.of(context).moduleNotFound(slug)),
              ),
            ModuleDetailFailure(:final slug, :final error) => Center(
                child: LoadErrorView(
                  error: error,
                  onRetry: () => context.read<ModuleDetailCubit>().load(slug),
                ),
              ),
            ModuleDetailLoaded(:final details) => _DetailContent(
                module: details.module,
                related: details.related,
              ),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.module, required this.related});

  final ModuleModel module;
  final List<ModuleModel> related;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(
                children: [
                  ModuleAvatar(module: module, radius: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(module.name, style: theme.textTheme.headlineMedium),
                        Text(
                          module.slug,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                module.summary.isEmpty ? l10n.noSummary : module.summary,
                style: theme.textTheme.bodyLarge,
              ),
              InfoRow(label: l10n.labelOwner, value: module.ownerUsername),
              InfoRow(label: l10n.labelVersion, value: module.version),
              InfoRow(
                label: l10n.labelDownloads,
                value: module.downloads.toString(),
              ),
              InfoRow(label: l10n.labelLicense, value: module.license),
              InfoRow(label: l10n.labelUpdatedAt, value: module.updatedAt),
              Text(l10n.sectionTags, style: theme.textTheme.titleMedium),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in module.tags) Chip(label: Text(tag)),
                ],
              ),
              if (related.isNotEmpty) ...[
                Text(l10n.sectionOtherModules, style: theme.textTheme.titleMedium),
                for (final other in related) ModuleCard(module: other),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
