import 'package:easy_bank/core/common/widgets/bottom_nav_bar.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FundBottomSheet extends StatelessWidget {
  const FundBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).textTheme.bodySmall!.color!,
                blurRadius: 1,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transfer Using: ',
                    style: Theme.of(context).textTheme.titleMedium!),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TransferContainer(
                    title: 'Mobile Number',
                    icon: Icon(
                      Icons.phone_android,
                      size: 35,
                    ),
                    onTap: () {
                      context.pushNamed('transferMobile');
                    }),
                TransferContainer(
                    title: 'Account Number',
                    icon: Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 35,
                    ),
                    onTap: () {
                      context.pushNamed('transferAccountNo');
                    }),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

class TransferContainer extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  const TransferContainer(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120,
        width: deviceWidth * 0.35,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: 10,
            ),
            Text(title, style: Theme.of(context).textTheme.bodyMedium!)
          ],
        ),
      ),
    );
  }
}
