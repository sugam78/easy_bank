

import 'package:easy_bank/features/fund_transfer/data/data_sources/fund_transfer_data_sources.dart';
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';
import 'package:easy_bank/shared/data/data_sources/local_data_source.dart';

class FundTransferRepoImpl implements FundTransferRepository{
  final FundTransferDataSource fundTransferDataSource;
  final AuthLocalDataSource authLocalDataSource;

  FundTransferRepoImpl(this.fundTransferDataSource, this.authLocalDataSource);
  @override
  Future<bool> transferFund(String? targetAccNo,String? mobileNumber,String pin, String amount) async{
    await authLocalDataSource.saveCredentials(null, null, pin);
    return fundTransferDataSource.balanceTransfer(targetAccNo,mobileNumber,pin, amount);
  }
}
class FingerprintFundTransferRepoImpl implements FingerprintFundTransferRepository{
  final FundTransferDataSource fundTransferDataSource;
  final AuthLocalDataSource authLocalDataSource;

  FingerprintFundTransferRepoImpl(this.fundTransferDataSource, this.authLocalDataSource);
  @override
  Future<bool> transferFundUsingFingerprint(String? targetAccNo,String? mobileNumber, String amount) async{
    final credentials = await authLocalDataSource.getCredentials();
    if(credentials['pin']==null){
      throw Exception('Verify your pin first');
    }
    else {
      return fundTransferDataSource.balanceTransfer(
          targetAccNo, mobileNumber, credentials['pin']!, amount);
    }
  }
}

class MobileNumberRepoImpl implements MobileNumberRepository{
  final MobileNumberDataSource mobileNumberDataSource;

  MobileNumberRepoImpl(this.mobileNumberDataSource);
  @override
  Future<bool> checkMobileNumber(String mobileNumber) {
    return mobileNumberDataSource.checkMobileNumber(mobileNumber);
  }

}

class AccountNumberRepoImpl implements AccountNumberRepository{
  final AccountNumberDataSource accountNumberDataSource;

  AccountNumberRepoImpl(this.accountNumberDataSource);
  @override
  Future<bool> checkAccountNumber(String accountNumber) {
    return accountNumberDataSource.checkAccountNumber(accountNumber);
  }

}