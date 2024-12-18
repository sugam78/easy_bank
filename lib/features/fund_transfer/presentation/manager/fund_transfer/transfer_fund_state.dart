part of 'transfer_fund_bloc.dart';

@immutable
sealed class TransferFundState {}

final class TransferFundInitial extends TransferFundState {}
final class TransferFundLoading extends TransferFundState {}
final class TransferFundLoaded extends TransferFundState {}
final class TransferFundError extends TransferFundState {
  final String message;

  TransferFundError(this.message);
}
