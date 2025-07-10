class Trade {
  final String id;
  final String orderId;
  final String userId;
  final String assetSymbol;
  final String tradeType; // "buy" or "sell"
  final double quantity;
  final double price;
  final DateTime timestamp;

  Trade({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.assetSymbol,
    required this.tradeType,
    required this.quantity,
    required this.price,
    required this.timestamp,
  });

  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      id: json['id'],
      orderId: json['orderId'],
      userId: json['userId'],
      assetSymbol: json['assetSymbol'],
      tradeType: json['tradeType'],
      quantity: json['quantity'].toDouble(),
      price: json['price'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'assetSymbol': assetSymbol,
      'tradeType': tradeType,
      'quantity': quantity,
      'price': price,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
