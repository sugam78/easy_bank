import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';

class HomeTop extends StatelessWidget {
  final String name;
  const HomeTop({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome,',style: Theme.of(context).textTheme.titleLarge,),
        Align(
            alignment: Alignment.bottomLeft,
            child: Text(name,style: Theme.of(context).textTheme.bodyLarge)),
      ],
    );
  }
}
