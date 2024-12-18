import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/resources/app_colors.dart';

class TransactionSuccess extends StatelessWidget {
  final String amount;
  final String to;
  const TransactionSuccess({super.key, required this.amount, required this.to});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceHeight * 0.05,vertical: deviceHeight * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/transaction_success.json',repeat: false),
            Text('Successfully Transferred $amount to $to',style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.green,
            ),textAlign: TextAlign.center,),
            SizedBox(height: deviceHeight * 0.02,),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (){
                context.go('/home');
              },
              child: Container(
                height: deviceHeight * 0.07,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).textTheme.bodySmall!.color!,spreadRadius: 0.2,offset: Offset(1,1),blurRadius: 2)
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Home'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
