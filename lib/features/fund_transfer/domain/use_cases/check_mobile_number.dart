
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';

class CheckMobileNumberUseCase {
  final MobileNumberRepository mobileNumberRepository;

  CheckMobileNumberUseCase(this.mobileNumberRepository);

  Future<bool> execute(String mobileNumber){
    return mobileNumberRepository.checkMobileNumber(mobileNumber);
  }
}