import 'package:easy_bank/features/security/change_password/data/data_sources/change_password_data_source.dart';
import 'package:easy_bank/features/security/change_password/domain/repositories/change_password_repository.dart';
import 'package:easy_bank/shared/data/data_sources/local_data_source.dart';

class ChangePasswordRepositoryImpl extends ChangePasswordRepository{
  final ChangePasswordDataSource changePasswordDataSource;
  final AuthLocalDataSource authLocalDataSource;

  ChangePasswordRepositoryImpl(this.changePasswordDataSource, this.authLocalDataSource);
  @override
  Future<String> changePassword(String oldPassword, String newPassword) async{
    await authLocalDataSource.saveCredentials(null, newPassword, null);
    return changePasswordDataSource.changePassword(oldPassword, newPassword);
  }
}