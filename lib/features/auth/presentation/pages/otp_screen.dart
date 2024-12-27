
import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/common/widgets/custom_snackbar.dart';
import '../manager/auth_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String name,phone,password,pin;
  const OtpScreen({super.key, required this.name, required this.phone, required this.password, required this.pin});

  @override
  Widget build(BuildContext context) {
    final OtpFieldController otpFieldController = OtpFieldController();
    String otp = '';
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
   if(state is AuthVerificationSuccess){
     context.read<AuthBloc>().add(SendUserDataToBackend(name: name,phoneNumber: phone,password: password,pin: pin));

   }
   if(state is AuthBackendSubmissionSuccess){
     context.go('/login');
   }
   if(state is AuthFailure){
     CustomSnackbar.show(context, message: state.errorMessage, type: SnackbarType.error);
     context.read<AuthBloc>().add(ResetAuthBloc());
   }
  },
  builder: (context, state) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.18,
              ),
              Row(
                children: [
                  Text(
                    'Enter OTP',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.1,
              ),
              Center(
                  child: OTPTextField(
                controller: otpFieldController,
                length: 6,
                width: deviceWidth * 0.6,
                onCompleted: (val){
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
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(VerifyPhoneNumber(otp));
                },
                child: const Text("Verify"),
              ),
            ],
          ),
        ),
      );
  },
),
    );
  }
}
