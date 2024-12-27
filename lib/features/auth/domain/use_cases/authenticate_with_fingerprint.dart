
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class AuthenticateWthFingerprintUseCase{
  final AuthRepository authRepository;

  AuthenticateWthFingerprintUseCase(this.authRepository);

  Future<User> execute()async{
    return await authRepository.loginWithFingerprint();
  }
}