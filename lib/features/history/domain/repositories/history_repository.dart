import '../entities/transaction_history.dart';

abstract class HistoryRepository {
  Future<List<TransactionHistory>> fetchTransactionHistory(
      {int page = 1, int limit = 10});
}
