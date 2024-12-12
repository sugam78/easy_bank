part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {
  final String phoneNumber;

  AuthSignUpSuccess(this.phoneNumber);
}

class AuthVerificationInProgress extends AuthState {}
class SignUpInProgress extends AuthState {}

class AuthVerificationSuccess extends AuthState {}

class AuthBackendSubmissionSuccess extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final UserModel userModel;

  AuthLoginSuccess(this.userModel);

}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}
