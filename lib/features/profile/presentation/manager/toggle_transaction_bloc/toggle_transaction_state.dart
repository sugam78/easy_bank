part of 'toggle_transaction_bloc.dart';

@immutable
sealed class ToggleTransactionState {}

final class ToggleTransactionInitial extends ToggleTransactionState {}
final class ToggleTransactionLoading extends ToggleTransactionState {}
final class ToggleTransactionLoaded extends ToggleTransactionState {
  final bool enabled;

  ToggleTransactionLoaded(this.enabled);
}
final class ToggleTransactionError extends ToggleTransactionState {
  final String message;

  ToggleTransactionError(this.message);
}
