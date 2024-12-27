part of 'check_account_number_bloc.dart';

@immutable
sealed class CheckAccountNumberEvent {}

final class CheckAccountNumberValidity extends CheckAccountNumberEvent{
  final String accountNumber;

  CheckAccountNumberValidity(this.accountNumber);
}

final class ResetCheckAccNoBloc extends CheckAccountNumberEvent{}