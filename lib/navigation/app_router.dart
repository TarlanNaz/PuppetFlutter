import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/module_detail_screen.dart';
import '../screens/module_list_screen.dart';

final router = GoRouter(
  routes: [
    // главный экран со списком
    GoRoute(
      path: '/',
      builder: (context, state) => const ModuleListScreen(),
      routes: [
        // экран модуля, например /module/puppetlabs-apache
        GoRoute(
          path: 'module/:slug',
          pageBuilder: (context, state) {
            final slug = state.pathParameters['slug']!;

            return CustomTransitionPage(
              key: state.pageKey,
              child: ModuleDetailScreen(slug: slug),
              // новый экран выезжает справа
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
          },
        ),
      ],
    ),
  ],
);
