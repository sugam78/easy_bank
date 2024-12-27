import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_snackbar.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/resources/dimensions.dart';
import '../../../../shared/bloc/profile_bloc/profile_bloc.dart';
import '../manager/mobile_number/check_mobile_number_bloc.dart';

class TransferUsingMobile extends StatelessWidget {
  const TransferUsingMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mobileNoController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Fund transfer'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05,vertical: deviceHeight * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter Details: '),
                    SizedBox(height: deviceHeight * 0.02,),
                    CustomTextField(labelText: 'Enter Receiver Mobile Number',controller: mobileNoController,validator: (value){
                      if(value==null||value.length!=10){
                        return 'Enter valid mobile number';
                      }
                      return null;
                    },),
                    SizedBox(height: deviceHeight * 0.02,),
                    CustomTextField(labelText: 'Enter Amount',controller: amountController,validator: (value){
                      final state = context.read<ProfileBloc>().state as ProfileLoaded;
                      if(value==null){
                        return 'Enter Enter Amount';
                      }
                      else if(int.parse(value)<10){
                        return 'Amount must be greater than 10';
                      }
                      else if(double.parse(value) > state.profile.currentBalance){
                        return 'Insufficient Balance';
                      }
                      return null;
                    },),
                    SizedBox(height: deviceHeight * 0.04,),
                    Center(
                      child: BlocConsumer<CheckMobileNumberBloc, CheckMobileNumberState>(
                        listener: (context, state) {
                          final amount = amountController.text.trim();
                          final mobileNo = mobileNoController.text.trim();
                          if(state is CheckMobileNumberError){
                            CustomSnackbar.show(context, message: state.message, type: SnackbarType.error);
                          }
                          if(state is CheckMobileNumberLoaded){
                            context.pushNamed('pinField',extra: {
                              'amount': amount,
                              'accountNumber': null,
                              'mobileNumber': mobileNo
                            });
                          }
                        },
                        builder: (context, state) {
                          if(state is CheckMobileNumberLoading){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final mobileNo = mobileNoController.text.trim();
                                context.read<CheckMobileNumberBloc>().add(CheckMobileNumberValidity(mobileNo));
                              }
                            },
                            child: const Text("Transfer"),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
