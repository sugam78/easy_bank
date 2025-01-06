import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyQrButton extends StatelessWidget {
  final String qrCode;
  final String accNo;
  const MyQrButton({super.key, required this.qrCode, required this.accNo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.pushNamed('myQrCode',extra: {
          'qrUrl': qrCode,
          'accNo': accNo
        });
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
            Text('Show My QR'),
            SizedBox(
              width: deviceWidth * 0.05,
            ),
            Icon(Icons.qr_code),
          ],
        ),
      ),
    );
  }
}
