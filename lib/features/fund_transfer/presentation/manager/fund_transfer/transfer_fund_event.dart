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
final class FingerprintTransferFund extends TransferFundEvent{
  final String? accountNumber;
  final String? mobileNumber;
  final String amount;

  FingerprintTransferFund(this.accountNumber, this.amount, this.mobileNumber);
}

final class ResetTransferFund extends TransferFundEvent{

}