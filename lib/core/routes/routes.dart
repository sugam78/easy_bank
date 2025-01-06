import 'package:easy_bank/features/auth/presentation/pages/login_screen.dart';
import 'package:easy_bank/features/auth/presentation/pages/otp_screen.dart';
import 'package:easy_bank/features/auth/presentation/pages/signup_screen.dart';
import 'package:easy_bank/features/fund_transfer/presentation/pages/pin_field.dart';
import 'package:easy_bank/features/fund_transfer/presentation/pages/qr_scanner.dart';
import 'package:easy_bank/features/fund_transfer/presentation/pages/transaction_success.dart';
import 'package:easy_bank/features/fund_transfer/presentation/pages/transfer_using_acc_no.dart';
import 'package:easy_bank/features/fund_transfer/presentation/pages/transfer_using_mobile.dart';
import 'package:easy_bank/features/history/presentation/pages/history_screen.dart';
import 'package:easy_bank/features/home/presentation/pages/home_screen.dart';
import 'package:easy_bank/features/my_qr_code/presentation/pages/my_qr_code.dart';
import 'package:easy_bank/features/profile/presentation/pages/profile.dart';
import 'package:easy_bank/features/security/change_password/presentation/pages/change_password_screen.dart';
import 'package:easy_bank/features/security/change_pin/presentation/pages/change_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/pages/splash_screen.dart';
import '../common/widgets/bottom_nav_bar.dart';

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
        path: '/transferMobile',
        name: 'transferMobile',
        builder: (context, state) => const TransferUsingMobile(),
      ),
      GoRoute(
        path: '/transactionSuccess',
        name: 'transactionSuccess',
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          return TransactionSuccess(amount: extra['amount'] as String, to: extra['to'] as String);
        },
      ),
      GoRoute(
        path: '/pinField',
        name: 'pinField',
        builder: (context, state) {
          final extra = state.extra as Map<String, String?>;
          return PinField(amount: extra['amount'] as String, accountNumber: extra['accountNumber'],mobileNumber: extra['mobileNumber'],);
        },
      ),
      GoRoute(
        path: '/transferAccountNo',
        name: 'transferAccountNo',
        builder: (context, state) {
          String? accNumber;
          if(state.extra == null){
            accNumber =null;
          }
          else {
            accNumber = state.extra as String?;
          }
          return TransferUsingAccNo(accountNumber: accNumber);
        },
      ),
      GoRoute(
        path: '/changePassword',
        name: 'changePassword',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/changePin',
        name: 'changePin',
        builder: (context, state) => const ChangePinScreen(),
      ),
      GoRoute(
        path: '/scanQr',
        name: 'scanQr',
        builder: (context, state) => const QRScannerScreen(),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          return OtpScreen(
            name: extra['name'] as String,
            password: extra['password'] as String,
            phone: extra['phone'] as String,
            pin: extra['pin'] as String,
          );}
      ),
      GoRoute(
        path: '/myQrCode',
        name: 'myQrCode',
        builder: (context, state) {
          final extra = state.extra as Map<String, String>;
          return MyQrCode(
            qrUrl: extra['qrUrl'] as String,
            accNo: extra['accNo'] as String,
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
