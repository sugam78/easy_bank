
import 'package:easy_bank/features/profile/domain/repository/toggle_transaction_repository.dart';

class ToggleTransactionUseCase{
  final ToggleTransactionRepository toggleTransactionRepository;

  ToggleTransactionUseCase(this.toggleTransactionRepository);

  Future<bool> execute(){
    return toggleTransactionRepository.toggleTransaction();
  }
}