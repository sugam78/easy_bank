class Profile {
  final String name;
  final String phone;
  final String accNumber;
  final double currentBalance;
  final DateTime accountCreatedDate;
  final DateTime accountExpiryDate;
  final List<History> history;

  Profile({
    required this.name,
    required this.phone,
    required this.accNumber,
    required this.currentBalance,
    required this.accountCreatedDate,
    required this.accountExpiryDate,
    required this.history,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      phone: json['phone'],
      accNumber: json['accNumber'],
      currentBalance: (json['currentBalance'] as num).toDouble(),
      accountCreatedDate: DateTime.parse(json['accountCreatedDate']),
      accountExpiryDate: DateTime.parse(json['accountExpiryDate']),
      history: (json['history'] as List)
          .map((item) => History.fromJson(item))
          .toList(),
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
      'history': history.map((item) => item.toJson()).toList(),
    };
  }
}

class History {
  final String type;
  final double amount;
  final Sender sender;
  final Receiver receiver;

  History({
    required this.type,
    required this.amount,
    required this.sender,
    required this.receiver,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      sender: Sender.fromJson(json['sender']),
      receiver: Receiver.fromJson(json['receiver']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
    };
  }
}

class Sender {
  final String name;
  final String accNumber;

  Sender({
    required this.name,
    required this.accNumber,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      name: json['name'],
      accNumber: json['accNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accNumber': accNumber,
    };
  }
}

class Receiver {
  final String name;
  final String accNumber;

  Receiver({
    required this.name,
    required this.accNumber,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      name: json['name'],
      accNumber: json['accNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accNumber': accNumber,
    };
  }
}
