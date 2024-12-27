import 'package:easy_bank/features/history/data/data_sources/history_data_sources.dart';
import 'package:easy_bank/features/history/domain/entities/transaction_history.dart';
import 'package:easy_bank/features/history/domain/repositories/history_repository.dart';

class HistoryRepoImpl implements HistoryRepository {
  final HistoryDataSource historyDataSource;


  HistoryRepoImpl(this.historyDataSource);

  @override
  Future<List<TransactionHistory>> fetchTransactionHistory({
    int page = 1,
    int limit = 10,
  }) async {
    final historyModels = await historyDataSource.fetchTransactionHistory(
      page: page,
      limit: limit,
    );

    final List<TransactionHistory> currentPageHistory = historyModels.map((model) {
      return TransactionHistory(
        type: model.type,
        amount: model.amount,
        sender: SenderReceiver(
          name: model.sender.name,
          accNumber: model.sender.accNumber,
        ),
        receiver: SenderReceiver(
          name: model.receiver.name,
          accNumber: model.receiver.accNumber,
        ),
      );
    }).toList();

   return currentPageHistory;
  }
}
