import 'package:easy_bank/core/common/widgets/bottom_nav_bar.dart';
import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/features/profile/presentation/widgets/fingerprint_toggle.dart';
import 'package:easy_bank/features/profile/presentation/widgets/toggle_theme.dart';
import 'package:easy_bank/features/profile/presentation/widgets/transaction_enable_toggle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/dimensions.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferences',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500
        ),),
        SizedBox(height: deviceHeight * 0.02,),
        TransactionEnableToggle(),
        SizedBox(height: deviceHeight * 0.02,),
        ThemeToggleButton(),
        SizedBox(height: deviceHeight * 0.02,),
        FingerprintToggle(),
        SizedBox(height: deviceHeight * 0.03,),
        Text('Security',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500
        ),),
        SizedBox(height: deviceHeight * 0.02,),
        ProfileSettingsContainer(title: 'Change Password', onTap: (){
          context.pushNamed('changePassword');
        }),
        SizedBox(height: deviceHeight * 0.02,),
        ProfileSettingsContainer(title: 'Change Transaction Pin', onTap: (){
          context.pushNamed('changePin');
        }),
        SizedBox(height: deviceHeight * 0.02,),
        ProfileSettingsContainer(title: 'Logout', onTap: (){
          context.go('/login');
        },icon: Icon(Icons.logout),color: AppColors.error.withOpacity(0.5),),
      ],
    );
  }
}

class ProfileSettingsContainer extends StatelessWidget {
  final String title;
  final Widget? icon;
  final VoidCallback onTap;
  final Color? color;
  const ProfileSettingsContainer({super.key, required this.title, this.icon, required this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: deviceHeight * 0.07,
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Theme.of(context).textTheme.bodySmall!.color!,spreadRadius: 0.2,offset: Offset(1,1),blurRadius: 2)
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium!),
            SizedBox(width: deviceWidth * 0.05,),
            icon??SizedBox(),
          ],
        ),
      ),
    );
  }
}
