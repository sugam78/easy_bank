abstract class FundTransferRepository{
  Future<bool> transferFund(String? targetAccNo,String? mobileNumber,String pin, String amount);
}


abstract class MobileNumberRepository{
  Future<bool> checkMobileNumber(String mobileNumber);
}

abstract class AccountNumberRepository{
  Future<bool> checkAccountNumber(String accountNumber);
}