// lib/models/transaction.dart
class Transaction {
  final String transactionId;
  final String type; // 'deposit', 'withdrawal', 'trade'
  final double amount;
  final DateTime date;
  final String status;

  Transaction({
    required this.transactionId,
    required this.type,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transaction_id'],
      type: json['type'],
      amount: double.parse(json['amount'].toString()),
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'type': type,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
