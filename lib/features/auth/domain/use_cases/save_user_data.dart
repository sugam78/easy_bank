import '../repositories/auth_repository.dart';

class SaveUserDataUseCase {
  final AuthRepository repository;

  SaveUserDataUseCase(this.repository);

  Future<void> execute(String name,String phoneNumber, String password, String pin) {
    return repository.saveUserData(name, phoneNumber, password, pin);
  }
}
