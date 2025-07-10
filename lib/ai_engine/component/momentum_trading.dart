import 'api.dart';
import 'strategies_interface.dart';
class MomentumStrategy implements TradingStrategy {
  @override
  Future<Map<String, dynamic>> execute(String symbol) async {
    Map<String, dynamic> marketData =
        await MarketDataFetcher.fetchBinancePrice(symbol);
    double currentPrice = marketData["price"];

    double previousPrice = currentPrice - 100; // Mock previous price

    if (currentPrice > previousPrice) {
      return {"action": "buy", "amount": 1.0, "price": currentPrice};
    } else if (currentPrice < previousPrice) {
      return {"action": "sell", "amount": 1.0, "price": currentPrice};
    } else {
      return {"action": "hold", "amount": 0.0, "price": currentPrice};
    }
  }
}
