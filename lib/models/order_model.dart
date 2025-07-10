class Order {
  final String id;
  final String userId;
  final String assetSymbol;
  final String orderType; // "buy" or "sell"
  final double quantity;
  final double price;
  final DateTime timestamp;
  final String status; // e.g., "pending", "executed", "canceled"

  Order({
    required this.id,
    required this.userId,
    required this.assetSymbol,
    required this.orderType,
    required this.quantity,
    required this.price,
    required this.timestamp,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      assetSymbol: json['assetSymbol'],
      orderType: json['orderType'],
      quantity: json['quantity'].toDouble(),
      price: json['price'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'assetSymbol': assetSymbol,
      'orderType': orderType,
      'quantity': quantity,
      'price': price,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }
}
