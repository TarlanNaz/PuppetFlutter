import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/module_list_screen.dart';
import '../screens/module_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ModuleListScreen(),
      routes: [
        GoRoute(
          path: 'module/:slug',
          pageBuilder: (context, state) {
            final slug = state.pathParameters['slug']!;
            return CustomTransitionPage(
              key: state.pageKey,
              child: ModuleDetailScreen(slug: slug),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Return transition that looks like a push (slide from right)
                // When popping, it will naturally slide back to right
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOutCubic;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
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
