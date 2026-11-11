import 'package:json_annotation/json_annotation.dart';

part 'module_dto.g.dart';

// Модуль из ответа `GET /v3/modules/{slug}` и из `results` страницы списка.
// В ответе много полей, описаны только нужные, остальные пропускаются.
@JsonSerializable()
class ModuleDto {
  const ModuleDto({
    required this.slug,
    required this.name,
    required this.downloads,
    required this.updatedAt,
    required this.owner,
    required this.currentRelease,
  });

  factory ModuleDto.fromJson(Map<String, dynamic> json) =>
      _$ModuleDtoFromJson(json);

  // Вида `puppetlabs-apache`: автор и название через дефис.
  final String slug;
  final String name;
  final int downloads;

  // Вида `2024-01-10 08:15:42 -0800`.
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  final OwnerDto owner;

  // У удалённых модулей релиза нет.
  @JsonKey(name: 'current_release')
  final ReleaseDto? currentRelease;
}

@JsonSerializable()
class OwnerDto {
  const OwnerDto({required this.username});

  factory OwnerDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerDtoFromJson(json);

  final String username;
}

@JsonSerializable()
class ReleaseDto {
  const ReleaseDto({
    required this.version,
    required this.tags,
    required this.metadata,
  });

  factory ReleaseDto.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDtoFromJson(json);

  final String version;

  @JsonKey(defaultValue: <String>[])
  final List<String> tags;

  final ReleaseMetadataDto metadata;
}

// Содержимое metadata.json модуля. Автор может не указать описание и лицензию.
@JsonSerializable()
class ReleaseMetadataDto {
  const ReleaseMetadataDto({required this.summary, required this.license});

  factory ReleaseMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$ReleaseMetadataDtoFromJson(json);

  final String? summary;
  final String? license;
}
