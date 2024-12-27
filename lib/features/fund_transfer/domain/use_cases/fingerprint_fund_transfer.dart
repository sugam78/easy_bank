
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';

class FingerprintFundTransferUseCase{
  final FingerprintFundTransferRepository fundTransferRepository;

  FingerprintFundTransferUseCase(this.fundTransferRepository);

  Future<bool> execute(String? targetAccNo,String? mobileNumber,String amount){
    return fundTransferRepository.transferFundUsingFingerprint(targetAccNo,mobileNumber, amount);
  }
}