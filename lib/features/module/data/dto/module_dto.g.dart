// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleDto _$ModuleDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ModuleDto',
  json,
  ($checkedConvert) {
    final val = ModuleDto(
      slug: $checkedConvert('slug', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      downloads: $checkedConvert('downloads', (v) => (v as num).toInt()),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
      owner: $checkedConvert(
        'owner',
        (v) => OwnerDto.fromJson(v as Map<String, dynamic>),
      ),
      currentRelease: $checkedConvert(
        'current_release',
        (v) =>
            v == null ? null : ReleaseDto.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'updatedAt': 'updated_at',
    'currentRelease': 'current_release',
  },
);

OwnerDto _$OwnerDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OwnerDto', json, ($checkedConvert) {
      final val = OwnerDto(
        username: $checkedConvert('username', (v) => v as String),
      );
      return val;
    });

ReleaseDto _$ReleaseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReleaseDto', json, ($checkedConvert) {
      final val = ReleaseDto(
        version: $checkedConvert('version', (v) => v as String),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        ),
        metadata: $checkedConvert(
          'metadata',
          (v) => ReleaseMetadataDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

ReleaseMetadataDto _$ReleaseMetadataDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReleaseMetadataDto', json, ($checkedConvert) {
      final val = ReleaseMetadataDto(
        summary: $checkedConvert('summary', (v) => v as String?),
        license: $checkedConvert('license', (v) => v as String?),
      );
      return val;
    });
