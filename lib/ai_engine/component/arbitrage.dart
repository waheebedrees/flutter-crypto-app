import 'api.dart';
import 'strategies_interface.dart';

class ArbitrageStrategy implements TradingStrategy {
  @override
  Future<Map<String, dynamic>> execute(String symbol) async {
    Map<String, dynamic> binanceData =
        await MarketDataFetcher.fetchBinancePrice(symbol);
    Map<String, dynamic> coinbaseData =
        await MarketDataFetcher.fetchCoinbasePrice(symbol);

    double binancePrice = binanceData["price"];
    double coinbasePrice = coinbaseData["price"];

    double threshold = 1.0; // Minimum price difference for arbitrage

    if (binancePrice < coinbasePrice - threshold) {
      return {
        "action": "buy_binance_sell_coinbase",
        "amount": 1.0,
        "binancePrice": binancePrice,
        "coinbasePrice": coinbasePrice
      };
    } else if (coinbasePrice < binancePrice - threshold) {
      return {
        "action": "buy_coinbase_sell_binance",
        "amount": 1.0,
        "binancePrice": binancePrice,
        "coinbasePrice": coinbasePrice
      };
    } else {
      return {
        "action": "hold",
        "amount": 0.0,
        "binancePrice": binancePrice,
        "coinbasePrice": coinbasePrice
      };
    }
  }
}
