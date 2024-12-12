import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<void> execute(String phoneNumber) {
    return repository.sendOTP(phoneNumber);
  }
}
