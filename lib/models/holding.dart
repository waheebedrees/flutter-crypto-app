class Holdings {
  final String assetSymbol;
  double quantity;
  double averagePrice;

  Holdings({
    required this.assetSymbol,
    required this.quantity,
    required this.averagePrice,
  });

  factory Holdings.fromJson(Map<String, dynamic> json) {
    return Holdings(
      assetSymbol: json['assetSymbol'],
      quantity: json['quantity'].toDouble(),
      averagePrice: json['averagePrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assetSymbol': assetSymbol,
      'quantity': quantity,
      'averagePrice': averagePrice,
    };
  }
}


class Holding {
  final String name;
  final String symbol;
  final double quantity;
  final double value;
  final double percentage;
  final String logoUrl;

  Holding({
    required this.name,
    required this.symbol,
    required this.quantity,
    required this.value,
    required this.percentage,
    required this.logoUrl,
  });
}
