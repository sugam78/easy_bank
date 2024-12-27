abstract class ChangePinRepository{
  Future<String> changePin(String oldPassword,String newPin);
}