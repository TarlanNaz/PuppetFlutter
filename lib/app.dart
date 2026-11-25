import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puppet/common/locale/locale_cubit.dart';
import 'package:puppet/common/navigation/app_router.dart';
import 'package:puppet/common/network/dio_client.dart';
import 'package:puppet/common/theme/app_theme.dart';
import 'package:puppet/common/theme/theme_cubit.dart';
import 'package:puppet/features/module/data/api/module_api.dart';
import 'package:puppet/features/module/data/data_sources/network_module_data_source.dart';
import 'package:puppet/features/module/data/module_repository.dart';
import 'package:puppet/features/module/domain/i_module_repository.dart';
import 'package:puppet/features/module/presentation/bloc/list/module_list_cubit.dart';
import 'package:puppet/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IModuleRepository>(
      // Цепочка собирается здесь: Dio → API-клиент → датасорс → репозиторий.
      // Dio один на всё приложение.
      create: (_) => ModuleRepository(
        NetworkModuleDataSource(ModuleApi(DioClient.create())),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LocaleCubit()),
          BlocProvider(
            create: (context) =>
                ModuleListCubit(context.read<IModuleRepository>())..load(),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}
