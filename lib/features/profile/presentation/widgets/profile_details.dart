import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/bloc/profile_bloc/profile_bloc.dart';

class ProfileDetailsContainer extends StatelessWidget {
  const ProfileDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if(state is ProfileInitial){
          context.read<ProfileBloc>().add(GetProfile());
        }
        if(state is ProfileLoading){
          return CircularProgressIndicator();
        }
        if(state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person,size: 40,),
                  ),
                  SizedBox(width: deviceWidth * 0.1,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.profile.name,style: Theme.of(context).textTheme.titleMedium,),
                      Text('Account No: ${state.profile.accNumber}',style: Theme.of(context).textTheme.bodyMedium,),
                      Text('Phone No: ${state.profile.phone}',style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  )
                ],
              ),
              SizedBox(height: deviceHeight * 0.02),
              Text('Account Created date: ${state.profile.accountCreatedDate.year}/${state.profile.accountCreatedDate.month}/${state.profile.accountCreatedDate.day}'),
              Text('Account Expiry date: ${state.profile.accountExpiryDate.year}/${state.profile.accountExpiryDate.month}/${state.profile.accountExpiryDate.day}'),
            ],
          );
        }
        if(state is ProfileError){
          return Center(child: Text(state.message),);
        }
        return SizedBox.shrink();
      },
    );
  }
}
