abstract class TradingStrategy {
  Future<Map<String, dynamic>> execute(String symbol);
}
