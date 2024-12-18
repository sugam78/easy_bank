class Profile {
  final String name;
  final String phone;
  final String accNumber;
  final double currentBalance;
  final DateTime accountCreatedDate;
  final DateTime accountExpiryDate;

  Profile({
    required this.name,
    required this.phone,
    required this.accNumber,
    required this.currentBalance,
    required this.accountCreatedDate,
    required this.accountExpiryDate,
  });
}