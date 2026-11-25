import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puppet/common/network/load_exception.dart';
import 'package:puppet/features/module/data/data_sources/i_module_data_source.dart';
import 'package:puppet/features/module/data/dto/module_dto.dart';
import 'package:puppet/features/module/data/dto/module_page_dto.dart';
import 'package:puppet/features/module/data/module_repository.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/view/module_detail_screen.dart';
import 'package:puppet/l10n/app_localizations.dart';

const _module = ModuleDto(
  slug: 'puppetlabs-archive',
  name: 'archive',
  downloads: 93840196,
  updatedAt: '2026-10-16 08:15:42 -0800',
  owner: OwnerDto(username: 'puppetlabs'),
  currentRelease: ReleaseDto(
    version: '1.0.0',
    tags: [],
    metadata: ReleaseMetadataDto(
      summary: 'Archive module',
      license: 'Apache-2.0',
    ),
  ),
);

class _DataSource implements IModuleDataSource {
  _DataSource({this.moduleError, this.relatedError});

  final LoadException? moduleError;
  final LoadException? relatedError;

  @override
  Future<ModuleDto> getModule(String slug) async {
    if (moduleError case final error?) throw error;
    return _module;
  }

  @override
  Future<ModulePageDto> getModules({
    required int offset,
    required int limit,
    String? query,
    String? owner,
  }) async {
    if (relatedError case final error?) throw error;
    return const ModulePageDto(
      pagination: PaginationDto(total: 1, next: null),
      results: [_module],
    );
  }
}

void main() {
  test(
    'Related request failure preserves the loaded module and timestamp',
    () async {
      final repository = ModuleRepository(
        _DataSource(relatedError: const NoConnectionException()),
      );
      final details = await repository.getDetails(_module.slug);
      expect(details.module.slug, _module.slug);
      expect(details.related, isEmpty);
      expect(details.module.updatedAt, DateTime.utc(2026, 10, 16, 16, 15, 42));
    },
  );

  for (final relatedFails in [false, true]) {
    test(
      'Primary request error is preserved (related fails: $relatedFails)',
      () async {
        const error = NotFoundException();
        final repository = ModuleRepository(
          _DataSource(
            moduleError: error,
            relatedError: relatedFails ? const NoConnectionException() : null,
          ),
        );
        await expectLater(
          repository.getDetails(_module.slug),
          throwsA(same(error)),
        );
      },
    );
  }

  for (final language in ['ru', 'en']) {
    testWidgets('Detail formats values for $language and hides empty tags', (
      tester,
    ) async {
      await tester.pumpWidget(
        RepositoryProvider<IModuleRepository>(
          create: (_) => ModuleRepository(_DataSource()),
          child: MaterialApp(
            locale: Locale(language),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ModuleDetailScreen(slug: 'puppetlabs-archive'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(
        find.text(language == 'ru' ? '93\u00a0840\u00a0196' : '93,840,196'),
        findsOneWidget,
      );
      expect(
        find.text(language == 'ru' ? '16 окт. 2026\u202fг.' : 'Oct 16, 2026'),
        findsOneWidget,
      );
      expect(find.text(language == 'ru' ? 'Теги' : 'Tags'), findsNothing);
      expect(find.byType(Chip), findsNothing);
    });
  }
}
