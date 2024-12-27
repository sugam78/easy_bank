import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:easy_bank/core/constants/api_constants.dart';

abstract class ChangePasswordDataSource{
  Future<String> changePassword(String oldPassword,String newPassword);
}

class ChangePasswordDataSourceImpl implements ChangePasswordDataSource{
  @override
  Future<String> changePassword(String oldPassword, String newPassword) async{
    try{
      final response = await apiHandler(ApiConstants.changePassword, 'POST',body: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
      return response;
    }
    catch(e){
      throw Exception('$e');
    }
  }

}