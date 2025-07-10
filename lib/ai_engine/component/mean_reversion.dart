import 'api.dart';
import 'strategies_interface.dart';

class MeanReversionStrategy implements TradingStrategy {
  @override
  Future<Map<String, dynamic>> execute(String symbol) async {
    Map<String, dynamic> marketData =
        await MarketDataFetcher.fetchBinancePrice(symbol);
    double currentPrice = marketData["price"];

    double movingAverage = currentPrice - 50.0; // Mock moving average

    if (currentPrice < movingAverage) {
      return {"action": "buy", "amount": 1.0, "price": currentPrice};
    } else if (currentPrice > movingAverage) {
      return {"action": "sell", "amount": 1.0, "price": currentPrice};
    } else {
      return {"action": "hold", "amount": 0.0, "price": currentPrice};
    }
  }
}
