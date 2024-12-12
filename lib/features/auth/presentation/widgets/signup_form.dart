import 'package:easy_bank/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../resources/dimensions.dart';
import '../manager/auth_bloc.dart';


class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    // Controllers for capturing input
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final pinController = TextEditingController();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is SignUpInProgress){
          print(nameController.text);
          print(passwordController.text);
          print(pinController.text);
          print(phoneController.text);
          context.pushNamed('otp',extra: {
            'name': nameController.text,
            'password': passwordController.text,
            'phone': phoneController.text,
            'pin': pinController.text,
          });
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name Field
              CustomTextField(
                labelText: "Name",
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  if (value.length < 3) {
                    return "Name must be at least 3 characters long";
                  }
                  return null;
                },
              ),
              SizedBox(height: deviceHeight * 0.02),

              // Phone Number Field
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

              CustomTextField(
                labelText: "Create 4 digit pin for transaction",
                isPassword: true,
                controller: pinController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Pin";
                  }
                  if (value.length != 4) {
                    return "Pin must be 4 characters long";
                  }
                  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                    return "Pin must contain only numbers";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: deviceHeight * 0.03),

              // Verify Phone Number Button
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final name = nameController.text.trim();
                    final phone = phoneController.text.trim();
                    final password = passwordController.text.trim();
                    context.read<AuthBloc>().add(SignUpRequested(phone));
                  }
                },
                child: const Text("Verify Phone Number"),
              ),
            ],
          ),
        );
      },
    );
  }
}
