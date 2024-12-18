

import 'package:easy_bank/features/fund_transfer/data/data_sources/fund_transfer_data_sources.dart';
import 'package:easy_bank/features/fund_transfer/domain/repositories/fund_transfer_repo.dart';

class FundTransferRepoImpl implements FundTransferRepository{
  final FundTransferDataSource fundTransferDataSource;

  FundTransferRepoImpl(this.fundTransferDataSource);
  @override
  Future<bool> transferFund(String? targetAccNo,String? mobileNumber,String pin, String amount) {
    return fundTransferDataSource.balanceTransfer(targetAccNo,mobileNumber,pin, amount);
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