class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String accountNumber;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.accountNumber,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      phoneNumber: json['phone'],
      accountNumber: json['accNumber'],
      token: json['token']??'abcdefghijklmnopqrstuvwxyz',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'phone': phoneNumber,
      'accNumber': accountNumber,
      'token': token
    };
  }
}
