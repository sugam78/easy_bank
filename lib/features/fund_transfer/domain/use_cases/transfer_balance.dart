
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';

class TransferBalanceUseCase{
  final FundTransferRepository fundTransferRepository;

  TransferBalanceUseCase(this.fundTransferRepository);

  Future<bool> execute(String? targetAccNo,String? mobileNumber,String pin,String amount){
    return fundTransferRepository.transferFund(targetAccNo,mobileNumber,pin, amount);
  }
}