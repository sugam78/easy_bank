part of 'check_account_number_bloc.dart';

@immutable
sealed class CheckAccountNumberState {}

final class CheckAccountNumberInitial extends CheckAccountNumberState {}
final class CheckAccountNumberLoading extends CheckAccountNumberState {}
final class CheckAccountNumberLoaded extends CheckAccountNumberState {}
final class CheckAccountNumberError extends CheckAccountNumberState {
  final String message;

  CheckAccountNumberError(this.message);
}
