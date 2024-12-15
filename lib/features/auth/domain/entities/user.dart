class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String accountNumber;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.accountNumber,
    this.token = ''
  });
}
