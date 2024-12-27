abstract class ChangePasswordRepository{
  Future<String> changePassword(String oldPassword,String newPassword);
}