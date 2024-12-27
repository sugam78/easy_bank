import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/features/home/presentation/widgets/fund_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/bloc/profile_bloc/profile_bloc.dart';

class TransferBalanceButton extends StatelessWidget {
  const TransferBalanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    if(state is ProfileInitial){
      context.read<ProfileBloc>().add(GetProfile());
    }
    if(state is ProfileLoaded) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if(state.profile.transactionEnabled) {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return FundBottomSheet();
                    });
              }
              else{
                CustomSnackbar.show(context, message: 'Transaction is not enabled. Enable it from profile.', type: SnackbarType.error);
              }
            },
            child: Container(
              height: deviceHeight * 0.07,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).textTheme.bodySmall!.color!,
                        spreadRadius: 0.2,
                        offset: Offset(1, 1),
                        blurRadius: 2)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Fund Transfer'),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  Icon(Icons.send_outlined),
                ],
              ),
            ),
          );
        }
    return SizedBox.shrink();
      },
);
  }
}
