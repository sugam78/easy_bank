import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> sendOTP(String phoneNumber);
  Future<bool> verifyOTP( String otp);
  Future<void> saveUserData(String name,String phoneNumber, String password, String pin);
  Future<User> login(String phoneNumber, String password);
}