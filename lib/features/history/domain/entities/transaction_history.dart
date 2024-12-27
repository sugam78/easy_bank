class TransactionHistory {
  final String type;
  final double amount;
  final SenderReceiver sender;
  final SenderReceiver receiver;

  TransactionHistory({
    required this.type,
    required this.amount,
    required this.sender,
    required this.receiver,
  });
  }

class SenderReceiver {
  final String name;
  final String accNumber;

  SenderReceiver({
    required this.name,
    required this.accNumber,
  });
}