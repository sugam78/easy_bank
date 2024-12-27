import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/features/profile/presentation/widgets/profile_details.dart';
import 'package:easy_bank/features/profile/presentation/widgets/profile_settings.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth* 0.05,vertical: deviceHeight*0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileDetailsContainer(),
              SizedBox(height: deviceHeight * 0.04,),
              ProfileSettings(),
            ],
          ),
        ),
      )
    );
  }
}
