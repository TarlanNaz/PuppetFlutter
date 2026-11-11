import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:puppet/common/widgets/app_scaffold.dart';
import 'package:puppet/features/module/presentation/view/module_detail_screen.dart';
import 'package:puppet/features/module/presentation/view/module_list_screen.dart';
import 'package:puppet/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const String list = '/';
  static String detail(String slug) => '/module/$slug';
}

abstract final class AppRouter {
  static final GoRouter router = _create();

  static GoRouter _create() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          pageBuilder: (context, state) =>
              _page(state, const ModuleListScreen()),
          routes: [
            GoRoute(
              path: 'module/:slug',
              pageBuilder: (context, state) => _page(
                state,
                ModuleDetailScreen(slug: state.pathParameters['slug']!),
              ),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }

  static Page<void> _page(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Text(AppLocalizations.of(context).pageNotFound)),
    );
  }
}
