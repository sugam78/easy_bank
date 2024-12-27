part of 'fetch_history_bloc.dart';

@immutable
sealed class FetchHistoryState {}

final class FetchHistoryInitial extends FetchHistoryState {}
final class FetchHistoryLoading extends FetchHistoryState {}
final class FetchHistoryLoaded extends FetchHistoryState {
  final List<TransactionHistory> transactionHistory;

  FetchHistoryLoaded(this.transactionHistory);
}
final class FetchHistoryError extends FetchHistoryState {
  final String message;

  FetchHistoryError(this.message);
}

class FetchHistoryNoMoreData extends FetchHistoryState {
  final List<TransactionHistory> history;

  FetchHistoryNoMoreData(this.history);
}
