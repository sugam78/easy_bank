import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String phoneNumber, String password) {
    return repository.login(phoneNumber, password);
  }
}
