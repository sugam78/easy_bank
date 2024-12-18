import 'package:easy_bank/core/services/service_locator.dart';
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
import 'package:easy_bank/features/fund_transfer/domain/use_cases/transfer_balance.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/account_number/check_account_number_bloc.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/fund_transfer/transfer_fund_bloc.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/mobile_number/check_mobile_number_bloc.dart';
import 'package:easy_bank/shared/bloc/profile_bloc/profile_bloc.dart';
import 'package:easy_bank/shared/domain/use_cases/get_profile_use_case.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/common/cubit/show_password/password_visibility_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.openBox('SETTINGS');

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(
            create: (context) =>
                ProfileBloc(profileLocator<GetProfileUseCase>())),
        BlocProvider(
            create: (context) =>
                TransferFundBloc(fundTransferLocator<TransferBalanceUseCase>())),
        BlocProvider(
            create: (context) =>
                CheckMobileNumberBloc(mobileNumberLocator<CheckMobileNumberUseCase>())),
        BlocProvider(
            create: (context) =>
                CheckAccountNumberBloc(accountNumberLocator<CheckAccountNumberUseCase>())),
        BlocProvider(
            create: (context) => AuthBloc(
                  authLocator<LoginUseCase>(),
                  authLocator<SaveUserDataUseCase>(),
                  authLocator<SendOtpUseCase>(),
                  authLocator<VerifyOtpUseCase>(),
                )),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        routerConfig: route,
      ),
    );
  }
}
