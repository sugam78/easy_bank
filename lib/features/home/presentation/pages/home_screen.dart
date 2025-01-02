import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/features/home/presentation/widgets/account_details.dart';
import 'package:easy_bank/features/home/presentation/widgets/balance_details.dart';
import 'package:easy_bank/features/home/presentation/widgets/home_top.dart';
import 'package:easy_bank/features/home/presentation/widgets/transfer_balance_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/bloc/profile_bloc/profile_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              context.read<ProfileBloc>().add(GetProfile());
            }
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.05,
                    vertical: deviceHeight * 0.03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeTop(name: state.profile.name),
                      SizedBox(height: deviceHeight * 0.02,),
                      AccountDetails(accountNumber: state.profile.accNumber),
                      SizedBox(height: deviceHeight * 0.02,),
                      BalanceDetails(
                          availableBalance: state.profile.currentBalance.toStringAsFixed(2),
                          totalBalance: state.profile.currentBalance.toStringAsFixed(2),
                          accuredInterest: state.profile.acurredInterest.toStringAsFixed(2)),
                      SizedBox(height: deviceHeight * 0.03,),
                      TransferBalanceButton(),
                      SizedBox(height: deviceHeight * 0.02,),
                    ],
                  ),
                ),
              );
            }
            if (state is ProfileError) {
              return Center(
                child: Text(state.message),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
