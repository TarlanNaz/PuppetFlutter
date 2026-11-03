import 'package:flutter/material.dart';
import 'package:puppet/features/module/domain/module_model.dart';
import 'package:puppet/features/module/presentation/utils/module_format.dart';

class ModuleAvatar extends StatelessWidget {
  const ModuleAvatar({super.key, required this.module, this.radius = 24});

  final ModuleModel module;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colors.primaryContainer,
      foregroundColor: colors.onPrimaryContainer,
      child: Text(module.initial, style: TextStyle(fontSize: radius * 0.8)),
    );
  }
}
