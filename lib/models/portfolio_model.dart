class PortfolioItem {
  final String symbol;
  final int quantity;
  final double averagePrice;

  PortfolioItem({
    required this.symbol,
    required this.quantity,
    required this.averagePrice,
  });

  factory PortfolioItem.fromJson(Map<String, dynamic> json) {
    return PortfolioItem(
      symbol: json['symbol'],
      quantity: json['quantity'],
      averagePrice: double.parse(json['average_price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'quantity': quantity,
      'average_price': averagePrice,
    };
  }
}

class Portfolio {
  final List<PortfolioItem> items;
  final double totalValue;

  Portfolio({
    required this.items,
    required this.totalValue,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List;
    List<PortfolioItem> itemsList =
        itemsJson.map((itemJson) => PortfolioItem.fromJson(itemJson)).toList();
    return Portfolio(
      items: itemsList,
      totalValue: double.parse(json['total_value'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total_value': totalValue,
    };
  }
}

class PortfolioAllocation {
  final String asset;
  final double value;

  PortfolioAllocation(this.asset, this.value);
}




