
import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:easy_bank/core/constants/api_constants.dart';

abstract class ChangePinDataSource{
  Future<String> changePin(String oldPassword,String newPin);
}

class ChangePinDataSourceImpl implements ChangePinDataSource{
  @override
  Future<String> changePin(String oldPassword, String newPin) async{
    try{
      final response = await apiHandler(ApiConstants.changePin, 'POST',body: {
        'oldPassword': oldPassword,
        'newPin': newPin,
      });
      return response;
    }
    catch(e){
      throw Exception('$e');
    }
  }

}