import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataFetcher {
  static Future<Map<String, dynamic>> fetchBinancePrice(String symbol) async {
    String url =
        "https://api.binance.com/api/v3/ticker/price?symbol=${symbol.toUpperCase()}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return {"price": double.parse(data["price"])};
      } else {
        throw Exception("Failed to fetch Binance price");
      }
    } catch (e) {
      print("Error fetching Binance price: $e");
      return {"price": 0.0};
    }
  }

  // Fetch price from Coinbase API
  static Future<Map<String, dynamic>> fetchCoinbasePrice(String symbol) async {
    String coinbaseSymbol = symbol.substring(0, 3)+
        "-" +
        symbol.substring(3); // BTCUSDT -> BTC-USD
    String url = "https://api.coinbase.com/v2/prices/${coinbaseSymbol}/spot";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return {"price": double.parse(data["data"]["amount"])};
      } else {
        throw Exception("Failed to fetch Coinbase price");
      }
    } catch (e) {
      print("Error fetching Coinbase price: $e");
      return {"price": 0.0};
    }
  }
}
