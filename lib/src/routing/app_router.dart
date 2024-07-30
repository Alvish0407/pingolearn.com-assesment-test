import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/signin_screen.dart';
import '../features/authentication/presentation/signup_screen.dart';
import '../features/home/presentation/home_screen.dart';
import 'go_router_refresh_stream.dart';

enum AppRoute { signUp, signIn, home }

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
  initialLocation: '/signIn',
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final path = state.uri.path;
    if (isLoggedIn) {
      if (path.startsWith('/signUp') || path.startsWith('/signIn')) {
        return '/home';
      }
    } else {
      if (!path.startsWith('/signIn') && !path.startsWith('/signUp')) {
        return '/signIn';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/signIn',
      name: AppRoute.signIn.name,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/signUp',
      name: AppRoute.signUp.name,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
