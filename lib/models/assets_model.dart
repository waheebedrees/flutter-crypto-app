class Asset {
  final String symbol;
  final String name;
  final String? logoUrl;
  final double? marketCap;
  final double? currentPrice;

  Asset({
    required this.symbol,
    required this.name,
    this.logoUrl,
    this.marketCap,
    this.currentPrice,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      symbol: json['symbol'],
      name: json['name'],
      logoUrl: json['logoUrl'],
      marketCap: json['marketCap']?.toDouble(),
      currentPrice: json['currentPrice']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'logoUrl': logoUrl,
      'marketCap': marketCap,
      'currentPrice': currentPrice,
    };
  }
}
