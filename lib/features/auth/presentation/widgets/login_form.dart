import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_text_field.dart';
import '../manager/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthLoginSuccess){
          context.go('/home');
        }

      },
      builder: (context, state) {
        if(state is AuthLoading){
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
                labelText: "Phone Number",
                keyboardType: TextInputType.phone,
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return "Enter a valid 10-digit phone number";
                  }
                  return null;
                },
              ),
              SizedBox(height: deviceHeight * 0.02),

              CustomTextField(
                labelText: "Password",
                isPassword: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  }
                  return null;
                },
              ),
              SizedBox(height: deviceHeight * 0.03),


              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final phone = phoneController.text.trim();
                    final password = passwordController.text.trim();
                    context.read<AuthBloc>().add(LoginRequested(phone, password));
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        );
      },
    );
  }
}
