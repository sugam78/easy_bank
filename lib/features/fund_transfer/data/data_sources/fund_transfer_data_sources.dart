
import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:easy_bank/core/constants/api_constants.dart';

abstract class MobileNumberDataSource {
  Future<bool> checkMobileNumber(String mobileNumber);
}

abstract class AccountNumberDataSource {
  Future<bool> checkAccountNumber(String accountNumber);
}

abstract class FundTransferDataSource {
  Future<bool> balanceTransfer( String? targetAccount,String? mobileNumber,String pin, String amount);
}

class MobileNumberDataSourceImpl implements MobileNumberDataSource{
  @override
  Future<bool> checkMobileNumber(String mobileNumber)async {
    try{
      final response = await apiHandler(ApiConstants.checkMobileNo, 'POST',body: {
        'mobileNumber': mobileNumber
      });
      if(response['message']!=null){
        return true;
      }
      return false;
    }
    catch(e){
      throw Exception('$e');
    }

  }

}

class AccountNumberDataSourceImpl implements AccountNumberDataSource{
  @override
  Future<bool> checkAccountNumber(String accountNumber)async {
    try{
      final response = await apiHandler(ApiConstants.checkAccNo, 'POST',body: {
        'accountNo': accountNumber
      });
      if(response['message']!=null){
        return true;
      }
      return false;
    }
    catch(e){
      throw Exception('Error: $e');
    }
  }

}

class FundTransferDataSourceImpl implements FundTransferDataSource{
  @override
  Future<bool> balanceTransfer( String? targetAccount,String? mobileNumber,String pin, String amount) async{
    try{
      final response = await apiHandler(
        ApiConstants.transferFund,
        'POST',
        body: {
          if (targetAccount != null) 'accountNumber': targetAccount,
          if (mobileNumber != null) 'mobileNumber': mobileNumber,
          'pin': pin,
          'amount': amount,
        },
      );

      if(response['message']!=null){
        return true;
      }
      return false;
    }
    catch(e){
      throw Exception('Error: $e');
    }
  }

}