import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:easy_bank/core/constants/api_constants.dart';

abstract class ToggleTransactionDataSource{
  Future<bool> toggleTransaction();
}

class ToggleTransactionDataSourceImpl extends ToggleTransactionDataSource{
  @override
  Future<bool> toggleTransaction() async{
    try{
      return await apiHandler(ApiConstants.toggleTransaction, 'POST',body: {});
    }
    catch(e){
      throw Exception('$e');
    }
  }

}