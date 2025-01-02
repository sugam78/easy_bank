class Profile {
  final String name;
  final String phone;
  final String accNumber;
  final double currentBalance;
  final double acurredInterest;
  final DateTime accountCreatedDate;
  final DateTime accountExpiryDate;
  final bool transactionEnabled;

  Profile({
    required this.name,
    required this.phone,
    required this.accNumber,
    required this.currentBalance,
    required this.acurredInterest,
    required this.accountCreatedDate,
    required this.accountExpiryDate,
    required this.transactionEnabled,
  });
}