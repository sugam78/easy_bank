import 'package:easy_bank/features/security/change_pin/data/data_sources/change_pin_data_source.dart';
import 'package:easy_bank/features/security/change_pin/domain/repositories/change_pin_repository.dart';
import 'package:easy_bank/shared/data/data_sources/local_data_source.dart';

class ChangePinRepositoryImpl extends ChangePinRepository{
  final ChangePinDataSource changePinDataSource;
  final AuthLocalDataSource authLocalDataSource;

  ChangePinRepositoryImpl(this.changePinDataSource, this.authLocalDataSource);
  @override
  Future<String> changePin(String oldPassword, String newPin) async{
     return changePinDataSource.changePin(oldPassword, newPin).then((val)async{
       await authLocalDataSource.saveCredentials(null, null, newPin);
      return val;
    });
  }

}