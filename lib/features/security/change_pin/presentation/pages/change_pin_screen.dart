import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:easy_bank/features/security/change_pin/presentation/manager/change_pin_bloc/change_pin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/dimensions.dart';

class ChangePinScreen extends StatelessWidget {
  const ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    final oldPassword = TextEditingController();
    final OtpFieldController otpFieldController = OtpFieldController();
    String otp = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Change PIN'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth *0.05,vertical: deviceHeight * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: deviceHeight * 0.2),
                  BlocConsumer<ChangePinBloc, ChangePinState>(
                    listener: (context, state) {
                      if(state is ChangePinLoaded){
                        context.go('/home');
                        CustomSnackbar.show(context, message: 'Pin Changed Successfully', type: SnackbarType.success);
                      }
                      if(state is ChangePinError){
                        CustomSnackbar.show(context, message: state.message, type: SnackbarType.error);
                        context.read<ChangePinBloc>().add(ResetChangePin());
                      }
                    },
                    builder: (context, state) {
                      if(state is ChangePinLoading){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Enter Current Password',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * 0.01,
                            ),
                            CustomTextField(
                              labelText: "Current Password",
                              isPassword: true,
                              controller: oldPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (value.length < 6) {
                                  return "Password doesn't match";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: deviceHeight * 0.02),

                            Row(
                              children: [
                                Text(
                                  'Enter new PIN',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * 0.01,
                            ),
                            Center(
                                child: OTPTextField(
                                  controller: otpFieldController,
                                  length: 4,
                                  width: deviceWidth * 0.7,
                                  onCompleted: (val) {
                                    otp = val;
                                  },
                                  otpFieldStyle: OtpFieldStyle(
                                      focusBorderColor: AppColors.primary,
                                      disabledBorderColor:
                                      Theme.of(context).textTheme.bodyMedium!.color!,
                                      enabledBorderColor:
                                      Theme.of(context).textTheme.bodyMedium!.color!),
                                  fieldStyle: FieldStyle.box,
                                )),
                            SizedBox(height: deviceHeight * 0.03),

                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    final oldPass = oldPassword.text.trim();
                                    context.read<ChangePinBloc>().add(ChangePin(oldPass, otp));
                                  }
                                },
                                child: const Text("Change PIN"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
