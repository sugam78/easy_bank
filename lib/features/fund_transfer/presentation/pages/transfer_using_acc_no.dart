import 'package:easy_bank/core/common/widgets/custom_text_field.dart';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/features/fund_transfer/presentation/manager/fund_transfer/transfer_fund_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferUsingAccNo extends StatelessWidget {
  const TransferUsingAccNo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController accountNoController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Fund transfer'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.05, vertical: deviceHeight * 0.03),
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
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    CustomTextField(
                      labelText: 'Enter Receiver Account Number',
                      controller: accountNoController,
                      validator: (value) {
                        if (value == null || value.length != 14) {
                          return 'Enter valid account number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    CustomTextField(
                      labelText: 'Enter Amount',
                      controller: amountController,
                      validator: (value) {
                        if (value == null) {
                          return 'Enter Enter Amount';
                        } else if (int.parse(value) < 10) {
                          return 'Amount must be greater than 10';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: deviceHeight * 0.04,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final amount = amountController.text.trim();
                          final accNo = accountNoController.text.trim();
                        }
                      },
                      child: const Text("Login"),
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