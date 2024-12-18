import 'package:flutter/material.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/resources/dimensions.dart';

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
                      if(value==null||value.length!=14){
                        return 'Enter valid account number';
                      }
                      return null;
                    },),
                    SizedBox(height: deviceHeight * 0.02,),
                    CustomTextField(labelText: 'Enter Amount',controller: amountController,validator: (value){
                      if(value==null){
                        return 'Enter Enter Amount';
                      }
                      else if(int.parse(value)<10){
                        return 'Amount must be greater than 10';
                      }
                      return null;
                    },),
                    SizedBox(height: deviceHeight * 0.04,),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final amount = amountController.text.trim();
                          final accNo = mobileNoController.text.trim();
                        }
                      },
                      child: const Text("Login"),
                    ),
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
