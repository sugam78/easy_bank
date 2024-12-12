part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String phoneNumber;

  SignUpRequested(this.phoneNumber);
}

class VerifyPhoneNumber extends AuthEvent {
  final String otp;

  VerifyPhoneNumber(this.otp);
}

class SendUserDataToBackend extends AuthEvent {
  final String name;
  final String phoneNumber;
  final String password;
  final String pin;

  SendUserDataToBackend({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.pin,
  });
}

class LoginRequested extends AuthEvent {
  final String phoneNumber;
  final String password;

  LoginRequested(this.phoneNumber, this.password);
}
