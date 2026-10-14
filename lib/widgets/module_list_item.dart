import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../models/puppet_module.dart';

// Одна строка в списке модулей
class ModuleListItem extends StatelessWidget {
  final PuppetModule module;

  const ModuleListItem({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      title: Text(module.name),
      subtitle: Text(
        '${l10n.downloads}: ${module.downloads} | ${l10n.owner}: ${module.ownerUsername}',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // push кладёт экран поверх списка, поэтому кнопка "назад" работает
        context.push('/module/${module.slug}');
      },
    );
  }
}
