part of 'toggle_transaction_bloc.dart';

@immutable
sealed class ToggleTransactionEvent {}

final class ToggleTransaction extends ToggleTransactionEvent{}
final class ResetToggleTransaction extends ToggleTransactionEvent{}