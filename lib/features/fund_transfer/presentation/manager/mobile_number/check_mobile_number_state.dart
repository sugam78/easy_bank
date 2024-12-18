part of 'check_mobile_number_bloc.dart';

@immutable
sealed class CheckMobileNumberState {}

final class CheckMobileNumberInitial extends CheckMobileNumberState {}
final class CheckMobileNumberLoading extends CheckMobileNumberState {}
final class CheckMobileNumberLoaded extends CheckMobileNumberState {}
final class CheckMobileNumberError extends CheckMobileNumberState {
  final String message;

  CheckMobileNumberError(this.message);

}
