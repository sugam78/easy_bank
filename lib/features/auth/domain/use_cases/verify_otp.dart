import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<bool> execute( String otp) {
    return repository.verifyOTP( otp);
  }
}
