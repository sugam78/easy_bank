import 'package:easy_bank/core/common/services/api_handler.dart';
import 'package:easy_bank/core/constants/api_constants.dart';
import 'package:easy_bank/shared/data/models/profile_model.dart';

abstract class ProfileRemoteDatSource {
  Future<ProfileModel> getProfile();

}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDatSource{

  @override
  Future<ProfileModel> getProfile()async{
    try{
      final response = await apiHandler(ApiConstants.getProfile, 'GET');
      return ProfileModel.fromJson(response);
    }
    catch(e){
      print("Error: $e");
      throw Exception("Error: $e");
    }
  }
}