// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModulePageDto _$ModulePageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ModulePageDto', json, ($checkedConvert) {
      final val = ModulePageDto(
        pagination: $checkedConvert(
          'pagination',
          (v) => PaginationDto.fromJson(v as Map<String, dynamic>),
        ),
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => ModuleDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaginationDto', json, ($checkedConvert) {
      final val = PaginationDto(
        total: $checkedConvert('total', (v) => (v as num).toInt()),
        next: $checkedConvert('next', (v) => v as String?),
      );
      return val;
    });
