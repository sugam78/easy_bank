part of 'transfer_fund_bloc.dart';

@immutable
sealed class TransferFundEvent {}

final class TransferFund extends TransferFundEvent{
  final String? accountNumber;
  final String? mobileNumber;
  final String amount;
  final String pin;

  TransferFund(this.accountNumber, this.amount, this.mobileNumber, this.pin);
}