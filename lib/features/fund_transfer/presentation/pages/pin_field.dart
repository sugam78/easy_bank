import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/fund_transfer/transfer_fund_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PinField extends StatelessWidget {
  final String amount;
  final String? accountNumber, mobileNumber;
  const PinField(
      {super.key,
      required this.accountNumber,
      required this.amount,
      this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    final OtpFieldController otpFieldController = OtpFieldController();
    String otp = '';
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              BlocConsumer<TransferFundBloc, TransferFundState>(
                listener: (context, state) {
                  if(state is TransferFundError){
                    CustomSnackbar.show(context, message: state.message, type: SnackbarType.error);
                  }
                  if(state is TransferFundLoaded){
                    context.go('/transactionSuccess',extra: {
                      'amount': amount,
                      'to': mobileNumber?? accountNumber??''
                    });
                  }
                },
                builder: (context, state) {
                  if(state is TransferFundLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: deviceHeight * 0.055,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<TransferFundBloc>().add(TransferFund(accountNumber, amount, mobileNumber, otp));
                            },
                            child: const Text("Verify"),
                          ),
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.02,),
                      SizedBox(
                        height: deviceHeight * 0.055,
                        width: deviceWidth * 0.17,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<TransferFundBloc>().add(FingerprintTransferFund(accountNumber, amount, mobileNumber));
                          },
                          child: Icon(Icons.fingerprint_rounded),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
