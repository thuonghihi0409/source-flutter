import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();

// Expose the navigator key for global navigation
GlobalKey<NavigatorState> get rootNavigatorKey => _rootKey;

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (_, __) => const LoginScreen(),
    ),
  ],
);

// Helper function to navigate to login screen
void navigateToLogin({String? message, bool showToast = true}) {
  final context = rootNavigatorKey.currentContext;
  if (context != null && context.mounted) {
    context.go('/login');
  }
}
