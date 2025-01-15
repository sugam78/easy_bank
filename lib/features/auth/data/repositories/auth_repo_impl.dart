import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_sources.dart';
import '../../../../shared/data/data_sources/fingerprint_data_source.dart';
import '../../../../shared/data/data_sources/local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final FingerprintDataSource fingerprintDataSource;

  AuthRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.fingerprintDataSource);

  @override
  Future<void> sendOTP(String phoneNumber) {
    return remoteDataSource.sendOTP(phoneNumber);
  }

  @override
  Future<bool> verifyOTP(String otp) {
    return remoteDataSource.verifyOTP(otp);
  }

  @override
  Future<void> saveUserData(
      String name, String phoneNumber, String password, String pin,String fcmToken) async {
    await remoteDataSource.saveUserData(name, phoneNumber, password, pin,fcmToken);
  }

  @override
  Future<User> login(String phoneNumber, String password) async {
    final userModel = await remoteDataSource.login(phoneNumber, password);
    await localDataSource.saveCredentials(phoneNumber, password, null);

    return User(
        id: userModel.id,
        name: userModel.name,
        phoneNumber: userModel.phoneNumber,
        accountNumber: userModel.accountNumber,
        token: userModel.token);
  }

  @override
  Future<User> loginWithFingerprint() async {
    final isAuthenticated =
        await fingerprintDataSource.authenticateWithFingerprint();
    if (!isAuthenticated) {
      throw Exception('Fingerprint authentication failed');
    }

    final credentials = await localDataSource.getCredentials();
    final phoneNumber = credentials['phoneNumber'];
    final password = credentials['password'];
    if (phoneNumber == null || password == null) {
      throw Exception('Use credentials this time');
    }
    final userModel = await remoteDataSource.login(phoneNumber, password);
    return User(
        id: userModel.id,
        name: userModel.name,
        phoneNumber: userModel.phoneNumber,
        accountNumber: userModel.accountNumber,
        token: userModel.token);
  }
}
