
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';

class CheckAccountNumberUseCase {
  final AccountNumberRepository accountNumberRepository;

  CheckAccountNumberUseCase(this.accountNumberRepository);

  Future<bool> execute(String accountNumber){
    return accountNumberRepository.checkAccountNumber(accountNumber);
  }
}