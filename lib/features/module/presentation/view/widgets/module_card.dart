import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puppet/common/navigation/app_router.dart';
import 'package:puppet/features/module/domain/module_model.dart';
import 'package:puppet/features/module/presentation/view/widgets/module_avatar.dart';
import 'package:puppet/l10n/app_localizations.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({super.key, required this.module});

  final ModuleModel module;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: ModuleAvatar(module: module),
        title: Text(module.name),
        subtitle: Text(l10n.moduleOwner(module.ownerUsername)),
        trailing: Text(l10n.moduleDownloads(module.downloads)),
        onTap: () => context.push(AppRoutes.detail(module.slug)),
      ),
    );
  }
}
