import 'package:easy_bank/common/cubit/show_password/password_visibility_cubit.dart';
import 'package:easy_bank/features/auth/presentation/manager/auth_bloc.dart';
import 'package:easy_bank/resources/dimensions.dart';
import 'package:easy_bank/resources/theme.dart';
import 'package:easy_bank/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.openBox('SETTINGS');

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
        BlocProvider(create: (context)=>PasswordVisibilityCubit()),
        BlocProvider(create: (context)=>AuthBloc()),
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

