import 'package:easy_bank/core/common/cubit/show_password/password_visibility_cubit.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceDetails extends StatelessWidget {
  final String availableBalance, totalBalance, accuredInterest;

  const BalanceDetails(
      {super.key,
      required this.availableBalance,
      required this.totalBalance,
      required this.accuredInterest});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: BlocBuilder<PasswordVisibilityCubit, bool>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Actual Balance',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        state ? 'XXX.xx' : 'RS. $totalBalance',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acurred Interest',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        state ? 'XXX.xx' : 'RS. $accuredInterest',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 20),
                      ),
                      Text(state ? 'XXX.xx' : 'RS. $availableBalance',style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 20),),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<PasswordVisibilityCubit>()
                            .toggleVisibility();
                      },
                      icon: state
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility))
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
