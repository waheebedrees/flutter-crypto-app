import 'api.dart';
import 'strategies_interface.dart';

class ScalpingStrategy implements TradingStrategy {
  @override
  Future<Map<String, dynamic>> execute(String symbol) async {
    Map<String, dynamic> marketData =
        await MarketDataFetcher.fetchBinancePrice(symbol);
    double currentPrice = marketData["price"];

    double spread = 5.0; // Define a small spread for scalping
    double entryPrice = currentPrice - spread;
    double exitPrice = currentPrice + spread;

    if (currentPrice <= entryPrice) {
      return {"action": "buy", "amount": 0.5, "price": currentPrice};
    } else if (currentPrice >= exitPrice) {
      return {"action": "sell", "amount": 0.5, "price": currentPrice};
    } else {
      return {"action": "hold", "amount": 0.0, "price": currentPrice};
    }
  }
}
