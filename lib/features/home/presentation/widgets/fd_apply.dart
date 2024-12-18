import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';

class ApplyForFDButton extends StatelessWidget {
  const ApplyForFDButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){

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
            Text('Apply for Fixed deposit'),
          ],
        ),
      ),
    );
  }
}
