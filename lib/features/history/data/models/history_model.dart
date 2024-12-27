class TransactionHistoryModel {
  final String type; // 'Debit' or 'Credit'
  final double amount;
  final SenderReceiver sender;
  final SenderReceiver receiver;

  TransactionHistoryModel({
    required this.type,
    required this.amount,
    required this.sender,
    required this.receiver,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      sender: SenderReceiver.fromJson(json['sender']),
      receiver: SenderReceiver.fromJson(json['receiver']),
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

class SenderReceiver {
  final String name;
  final String accNumber;

  SenderReceiver({
    required this.name,
    required this.accNumber,
  }) {
    if (accNumber.length != 14) {
      throw ArgumentError('Invalid account number length. Must be 14 characters.');
    }
  }

  factory SenderReceiver.fromJson(Map<String, dynamic> json) {
    return SenderReceiver(
      name: json['name'] as String,
      accNumber: json['accNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accNumber': accNumber,
    };
  }
}
