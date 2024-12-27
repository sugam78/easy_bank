import 'package:easy_bank/features/security/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordUseCase{
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordUseCase(this.changePasswordRepository);

  Future<String> execute(String oldPassword,String newPassword){
    return changePasswordRepository.changePassword(oldPassword, newPassword);
  }
}