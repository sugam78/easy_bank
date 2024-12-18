import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';


class PinField extends StatelessWidget {
  final String accountNumber,amount;
  const PinField({super.key, required this.accountNumber, required this.amount});

  @override
  Widget build(BuildContext context) {
    final OtpFieldController otpFieldController = OtpFieldController();
    String otp = '';
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
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
                    'Enter your PIN',
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
                    length: 4,
                    width: deviceWidth * 0.7,
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
                height: deviceHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () {

                },
                child: const Text("Verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
