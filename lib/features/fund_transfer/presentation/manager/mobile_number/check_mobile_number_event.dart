part of 'check_mobile_number_bloc.dart';

@immutable
sealed class CheckMobileNumberEvent {}

final class ResetCheckMobileNumber extends CheckMobileNumberEvent{}
final class CheckMobileNumberValidity extends CheckMobileNumberEvent{
  final String mobileNumber;

  CheckMobileNumberValidity(this.mobileNumber);
}