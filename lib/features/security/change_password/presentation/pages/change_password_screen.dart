import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:easy_bank/features/security/change_password/presentation/manager/change_password_bloc/change_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/custom_text_field.dart';
import '../../../../../core/resources/dimensions.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    final oldPassword = TextEditingController();
    final newPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth *0.05,vertical: deviceHeight * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: deviceHeight * 0.3),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if(state is ChangePasswordLoaded){
                    context.go('/home');
                    CustomSnackbar.show(context, message: 'Password Changed Successfully', type: SnackbarType.success);
                  }
                  if(state is ChangePasswordError){
                    CustomSnackbar.show(context, message: state.message, type: SnackbarType.error);
                    context.read<ChangePasswordBloc>().add(ResetChangePassword());
                  }
                },
                builder: (context, state) {
                  if(state is ChangePasswordLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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

                        CustomTextField(
                          labelText: "New Password",
                          isPassword: true,
                          controller: newPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter new password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: deviceHeight * 0.03),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final oldPass = oldPassword.text.trim();
                                final newPass = newPassword.text.trim();
                                context.read<ChangePasswordBloc>().add(ChangePassword(oldPass, newPass));
                              }
                            },
                            child: const Text("Change Password"),
                          ),
                        ),
                      ],
                    ),
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
