import 'package:puppet/features/module/data/dto/module_dto.dart';
import 'package:puppet/features/module/domain/module_model.dart';

// DTO → модель приложения. Имена полей API знают только DTO и этот файл.
extension ModuleDtoMapper on ModuleDto {
  ModuleModel toModel() => ModuleModel(
    slug: slug,
    name: name,
    downloads: downloads,
    ownerUsername: owner.username,
    version: currentRelease?.version ?? '',
    summary: currentRelease?.metadata.summary ?? '',
    license: currentRelease?.metadata.license ?? '',
    tags: currentRelease?.tags ?? const [],
    // Из `2024-01-10 08:15:42 -0800` берём только дату.
    updatedAt: updatedAt.length >= 10 ? updatedAt.substring(0, 10) : updatedAt,
  );
}
