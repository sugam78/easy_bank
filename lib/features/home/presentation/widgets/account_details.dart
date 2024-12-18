import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatelessWidget {
  final String accountNumber;
  const AccountDetails({super.key, required this.accountNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(accountNumber,style: Theme.of(context).textTheme.titleMedium,),
            Text('Normal Account',style: Theme.of(context).textTheme.bodyLarge,)
          ],
        ),
        Column(
          children: [
            Text('3%',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.green
            ),),
            Text('Interest',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.green
            ),),
          ],
        ),
      ],
    );
  }
}
