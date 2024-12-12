import 'package:easy_bank/features/auth/presentation/pages/login_screen.dart';
import 'package:easy_bank/features/auth/presentation/pages/otp_screen.dart';
import 'package:easy_bank/features/auth/presentation/pages/signup_screen.dart';
import 'package:easy_bank/features/history/presentation/widgets/history_screen.dart';
import 'package:easy_bank/features/home/presentation/pages/home_screen.dart';
import 'package:easy_bank/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/widgets/bottom_nav_bar.dart';
import '../features/splash/presentation/pages/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final rootNavigatorHomeKey = GlobalKey<NavigatorState>();
final rootNavigatorHistoryKey = GlobalKey<NavigatorState>();
final rootNavigatorProfileKey = GlobalKey<NavigatorState>();

final route = GoRouter(
    initialLocation: '/splash',
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavBar(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: rootNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                pageBuilder: (context, state) => customAnimatedSwitcher(
                  key: state.pageKey,
                  child: const HomeScreen(),
                ),
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: rootNavigatorHistoryKey,
            routes: [
              GoRoute(
                path: '/history',
                name: 'history',
                pageBuilder: (context, state) => customAnimatedSwitcher(
                  key: state.pageKey,
                  child: const HistoryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: rootNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                pageBuilder: (context, state) => customAnimatedSwitcher(
                  key: state.pageKey,
                  child: const Profile(),
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          print('Extra $extra\n' *5);
          return OtpScreen(
            name: extra['name'] as String,
            password: extra['password'] as String,
            phone: extra['phone'] as String,
            pin: extra['pin'] as String,
          );}
      ),

    ]);
customAnimatedSwitcher({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        ),
      );

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
