import 'package:json_annotation/json_annotation.dart';
import 'package:puppet/features/module/data/dto/module_dto.dart';

part 'module_page_dto.g.dart';

// Ответ `GET /v3/modules?offset=0&limit=20`: страница списка.
@JsonSerializable()
class ModulePageDto {
  const ModulePageDto({required this.pagination, required this.results});

  factory ModulePageDto.fromJson(Map<String, dynamic> json) =>
      _$ModulePageDtoFromJson(json);

  final PaginationDto pagination;
  final List<ModuleDto> results;
}

@JsonSerializable()
class PaginationDto {
  const PaginationDto({required this.total, required this.next});

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  // Сколько модулей всего подходит под запрос.
  final int total;

  // Адрес следующей страницы, null на последней.
  final String? next;
}
