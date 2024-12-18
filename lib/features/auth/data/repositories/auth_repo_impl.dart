
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_sources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendOTP(String phoneNumber) {
    return remoteDataSource.sendOTP(phoneNumber);
  }

  @override
  Future<bool> verifyOTP(String otp) {
    return remoteDataSource.verifyOTP(otp);
  }

  @override
  Future<void> saveUserData(String name,String phoneNumber, String password, String pin) {
    return remoteDataSource.saveUserData(name, phoneNumber, password, pin);
  }

  @override
  Future<User> login(String phoneNumber, String password) async {
    final userModel = await remoteDataSource.login(phoneNumber, password);
    return User(
      id: userModel.id,
      name: userModel.name,
      phoneNumber: userModel.phoneNumber,
      accountNumber: userModel.accountNumber,
      token: userModel.token
    );
  }
}
