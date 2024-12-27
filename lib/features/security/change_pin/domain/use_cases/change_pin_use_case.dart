import '../repositories/change_pin_repository.dart';

class ChangePinUseCase{
  final ChangePinRepository changePinRepository;

  ChangePinUseCase(this.changePinRepository);

  Future<String> execute(String oldPassword,String newPin){
    return changePinRepository.changePin(oldPassword, newPin);
  }
}