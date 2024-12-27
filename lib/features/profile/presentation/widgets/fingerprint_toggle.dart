import 'package:easy_bank/core/common/cubit/show_password/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/resources/app_colors.dart';

class FingerprintToggle extends StatelessWidget {
  const FingerprintToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).textTheme.bodySmall!.color!,
            spreadRadius: 0.2,
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text('Biometrics', style: Theme.of(context).textTheme.titleMedium!),
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                 Text('Fingerprint for password', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                     fontWeight: FontWeight.w500
                 )),
                const Spacer(),
                const PasswordSwitch(),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                 Text('Fingerprint for transaction pin', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                   fontWeight: FontWeight.w500
                 )),
                const Spacer(),
                const PinSwitch(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PinSwitch extends StatelessWidget {
  const PinSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    bool val = Hive.box('Biometrics').get('fingerprintPin',defaultValue: false);
    return  BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: BlocBuilder<PasswordVisibilityCubit, bool>(
        builder: (context, state) {
          return Switch.adaptive(
            value: val,
            onChanged: (value) {
              context.read<PasswordVisibilityCubit>().toggleVisibility();
              val = value;
              Hive.box('Biometrics').put('fingerprintPin', value);
            },
            activeColor: AppColors.green,
            inactiveThumbColor: AppColors.black,
            inactiveTrackColor: AppColors.white,
          );
        },
      ),
    );
  }
}
class PasswordSwitch extends StatelessWidget {
  const PasswordSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    bool val = Hive.box('Biometrics').get('fingerprint',defaultValue: false);
    return  BlocProvider(
  create: (context) => PasswordVisibilityCubit(),
  child: BlocBuilder<PasswordVisibilityCubit, bool>(
  builder: (context, state) {
    return Switch.adaptive(
      value: val,
      onChanged: (value) {
        context.read<PasswordVisibilityCubit>().toggleVisibility();
        val = value;
        Hive.box('Biometrics').put('fingerprint', value);
      },
      activeColor: AppColors.green,
      inactiveThumbColor: AppColors.black,
      inactiveTrackColor: AppColors.white,
    );
  },
),
);
  }
}