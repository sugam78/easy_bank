import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/features/profile/presentation/manager/toggle_transaction_bloc/toggle_transaction_bloc.dart';
import 'package:easy_bank/shared/bloc/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubit/button_cooldown/cooldown_cubit.dart';
import '../../../../core/resources/dimensions.dart';

class TransactionEnableToggle extends StatelessWidget {
  const TransactionEnableToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.07,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Text('Enable Transaction', style: Theme.of(context).textTheme.titleMedium!),
            const Spacer(),
            const TransactionSwitch(),
          ],
        ),
      ),
    );
  }
}
class TransactionSwitch extends StatelessWidget {
  const TransactionSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    bool switchValue = true;

    return BlocListener<ToggleTransactionBloc, ToggleTransactionState>(
      listener: (context, state) {
        if (state is ToggleTransactionLoaded) {
          switchValue = state.enabled;
          if (context.read<ProfileBloc>().state is ProfileLoaded) {
            context.read<ProfileBloc>().add(ResetProfile());
          }
          CustomSnackbar.show(
              context, message: 'Success', type: SnackbarType.success);
        }
        if (state is ToggleTransactionError) {
          CustomSnackbar.show(
              context, message: state.message, type: SnackbarType.error);
          context.read<ToggleTransactionBloc>().add(ResetToggleTransaction());
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoaded) {
            switchValue = profileState.profile.transactionEnabled;
          }

          return BlocBuilder<CooldownCubit, bool>(
            builder: (context, isCooldownActive) {
              return Switch.adaptive(
                value: switchValue,
                onChanged: (value) {
                  if (isCooldownActive) {
                    CustomSnackbar.show(
                      context,
                      message: 'Please wait before toggling again.',
                      type: SnackbarType.error,
                    );
                  } else {
                    context
                        .read<ToggleTransactionBloc>()
                        .add(ToggleTransaction());
                    context.read<CooldownCubit>().startCooldown();
                  }
                },
                activeColor: AppColors.green,
                inactiveThumbColor: AppColors.black,
                inactiveTrackColor: AppColors.white,
              );
            },
          );
        },
      ),
    );
  }
}



