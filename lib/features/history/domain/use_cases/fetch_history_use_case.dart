import 'package:easy_bank/features/history/domain/entities/transaction_history.dart';
import 'package:easy_bank/features/history/domain/repositories/history_repository.dart';

class FetchHistoryUseCase {
  final HistoryRepository historyRepository;

  FetchHistoryUseCase(this.historyRepository);

  Future<List<TransactionHistory>> execute({
    int page = 1,
    int limit = 10,
  }) {
    return historyRepository.fetchTransactionHistory(page: page, limit: limit);
  }
}
