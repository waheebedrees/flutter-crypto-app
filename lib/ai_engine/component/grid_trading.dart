import 'api.dart';
import 'strategies_interface.dart';

class GridTradingStrategy implements TradingStrategy {
  @override
  Future<Map<String, dynamic>> execute(String symbol) async {
    Map<String, dynamic> marketData =
        await MarketDataFetcher.fetchBinancePrice(symbol);
    double currentPrice = marketData["price"];

    double gridSize = 100.0; // Define your grid size
    double entryPrice = currentPrice - (gridSize / 2);
    double exitPrice = currentPrice + (gridSize / 2);

    if (currentPrice <= entryPrice) {
      return {"action": "buy", "amount": 1.0, "price": currentPrice};
    } else if (currentPrice >= exitPrice) {
      return {"action": "sell", "amount": 1.0, "price": currentPrice};
    } else {
      return {"action": "hold", "amount": 0.0, "price": currentPrice};
    }
  }
}
