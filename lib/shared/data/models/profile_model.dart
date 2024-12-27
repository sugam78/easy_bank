class ProfileModel {
  final String name;
  final String phone;
  final String accNumber;
  final double currentBalance;
  final DateTime accountCreatedDate;
  final DateTime accountExpiryDate;
  final bool transactionEnabled;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.accNumber,
    required this.currentBalance,
    required this.accountCreatedDate,
    required this.accountExpiryDate,
    required this.transactionEnabled,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      phone: json['phone'],
      accNumber: json['accNumber'],
      currentBalance: (json['currentBalance'] as num).toDouble(),
      accountCreatedDate: DateTime.parse(json['accountCreatedDate']),
      accountExpiryDate: DateTime.parse(json['accountExpiryDate']),
      transactionEnabled: json['transactionEnabled']?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'accNumber': accNumber,
      'currentBalance': currentBalance,
      'accountCreatedDate': accountCreatedDate.toIso8601String(),
      'accountExpiryDate': accountExpiryDate.toIso8601String(),
      'transactionEnabled': transactionEnabled
    };
  }
}

