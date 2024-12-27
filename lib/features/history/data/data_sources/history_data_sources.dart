import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:easy_bank/core/constants/api_constants.dart';
import 'package:easy_bank/features/history/data/models/history_model.dart';

abstract class HistoryDataSource{
  Future<List<TransactionHistoryModel>> fetchTransactionHistory(
      {int page = 1, int limit = 10});
}

class HistoryDataSourceImpl implements HistoryDataSource{
  @override
  Future<List<TransactionHistoryModel>> fetchTransactionHistory({int page = 1, int limit = 10}) async{
    try{
      final response = await apiHandler('${ApiConstants.getHistory}?page=$page&limit=$limit', 'GET');

      if (response is List) {
        return response
            .map((json) => TransactionHistoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Unexpected response format');
      }
    }
    catch(e){
      throw Exception('$e');
    }
  }

}
