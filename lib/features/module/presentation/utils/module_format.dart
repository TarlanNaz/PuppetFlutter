import 'package:puppet/features/module/domain/module_model.dart';

extension ModuleFormat on ModuleModel {
  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();
}
