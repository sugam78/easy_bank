import 'package:easy_bank/core/common/cubit/button_cooldown/cooldown_cubit.dart';
import 'package:easy_bank/core/services/service_locator.dart';
import 'package:easy_bank/features/auth/domain/use_cases/authenticate_with_fingerprint.dart';
import 'package:easy_bank/features/auth/domain/use_cases/login.dart';
import 'package:easy_bank/features/auth/domain/use_cases/save_user_data.dart';
import 'package:easy_bank/features/auth/domain/use_cases/send_otp.dart';
import 'package:easy_bank/features/auth/domain/use_cases/verify_otp.dart';
import 'package:easy_bank/features/auth/presentation/manager/auth_bloc.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/core/resources/theme.dart';
import 'package:easy_bank/core/routes/routes.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_account_number.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/check_mobile_number.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/fingerprint_fund_transfer.dart';
import 'package:easy_bank/features/fund_transfer/domain/use_cases/transfer_balance.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/account_number/check_account_number_bloc.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/fund_transfer/transfer_fund_bloc.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/mobile_number/check_mobile_number_bloc.dart';
import 'package:easy_bank/features/history/presentation/manager/history_bloc/fetch_history_bloc.dart';
import 'package:easy_bank/features/profile/domain/use_cases/toggle_transaction_use_case.dart';
import 'package:easy_bank/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:easy_bank/features/profile/presentation/manager/toggle_transaction_bloc/toggle_transaction_bloc.dart';
import 'package:easy_bank/features/security/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:easy_bank/features/security/change_password/presentation/manager/change_password_bloc/change_password_bloc.dart';
import 'package:easy_bank/shared/bloc/profile_bloc/profile_bloc.dart';
import 'package:easy_bank/shared/domain/use_cases/get_profile_use_case.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/common/cubit/show_password/password_visibility_cubit.dart';
import 'features/history/domain/use_cases/fetch_history_use_case.dart';
import 'features/security/change_pin/domain/use_cases/change_pin_use_case.dart';
import 'features/security/change_pin/presentation/manager/change_pin_bloc/change_pin_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
 await  Hive.openBox('SETTINGS');
 await  Hive.openBox('Biometrics');
  final settingsBox = await Hive.openBox('SettingBox');

  setupServiceLocator();

  runApp( MyApp(settingsBox: settingsBox,));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  final Box settingsBox;
  const MyApp({super.key, required this.settingsBox});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(create: (context) => CooldownCubit()),
        BlocProvider(
            create: (context) =>
                ProfileBloc(profileLocator<GetProfileUseCase>())),
        BlocProvider(
            create: (context) =>
                TransferFundBloc(fundTransferLocator<TransferBalanceUseCase>(),fundTransferLocator<FingerprintFundTransferUseCase>(),)),
        BlocProvider(
            create: (context) =>
                CheckMobileNumberBloc(mobileNumberLocator<CheckMobileNumberUseCase>())),
        BlocProvider(
            create: (context) =>
                FetchHistoryBloc(historyLocator<FetchHistoryUseCase>())),
        BlocProvider(
            create: (context) =>
                ToggleTransactionBloc(transactionLocator<ToggleTransactionUseCase>())),
        BlocProvider(
            create: (context) =>
                CheckAccountNumberBloc(accountNumberLocator<CheckAccountNumberUseCase>())),
        BlocProvider(
            create: (context) =>
                ChangePasswordBloc(changePasswordLocator<ChangePasswordUseCase>())),
        BlocProvider(
            create: (context) =>
                ChangePinBloc(changePinLocator<ChangePinUseCase>())),
        BlocProvider(
            create: (context) => AuthBloc(
                  authLocator<LoginUseCase>(),
                  authLocator<SaveUserDataUseCase>(),
                  authLocator<SendOtpUseCase>(),
                  authLocator<VerifyOtpUseCase>(),
                  authLocator<AuthenticateWthFingerprintUseCase>(),
                )),
        BlocProvider(
            create: (context) => ThemeCubit(settingsBox)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
  builder: (context, state) {
    return MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: state,
        routerConfig: route,
      );
  },
),
    );
  }
}
