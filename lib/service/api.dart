import 'dart:io';

import 'package:app/models/price_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class BinanceApi {
  static const String baseUrl = 'https://api.binance.com/api/v3';
  static Future<List<BitcoinPrice>> fetchBitcoinPriceHistory({
    required String symbol,
    required String interval,
    int limit = 30,
  }) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/klines?symbol=$symbol&interval=$interval&limit=$limit',
    ));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // await saveBinanceData(data);  is just temporary for debug
      return data.map((item) {
        final timestamp = int.parse(item[0].toString());
        final closePrice = double.parse(item[4].toString());
        return BitcoinPrice(
          timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
          price: closePrice,
        );
      }).toList();
    } else {
      throw Exception('Failed to load data from Binance');
    }
  }

  static Future<List<BitcoinPrice>> fetchBitcoinPrice({
    required String symbol,
    required String interval,
    int limit = 30,
  }) async {
    try {
      final List<dynamic>? data = await readBinanceData();
      if (data != null) {
        return data.map((item) {
          final timestamp = int.parse(item[0].toString());
          final closePrice = double.parse(item[4].toString());
          return BitcoinPrice(
            timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
            price: closePrice,
          );
        }).toList();
      } else {
        throw Exception('Failed to load data from ');
      }
    } catch (e) {
      throw Exception('Failed to load data from ');
    }
  }

  static Future<List<PriceData>> fetchHistoricalData(String symbol) async {
    String _historicalUrl =
        'https://api.binance.com/api/v3/klines?symbol=${symbol}USDT&interval=1m&limit=50';
    try {
      final response = await http.get(Uri.parse(_historicalUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return List<PriceData>.from(data.map((item) {
          final timestamp = int.parse(item[0].toString());
          final closePrice = double.parse(item[4].toString());
          return PriceData(
              DateTime.fromMillisecondsSinceEpoch(timestamp), closePrice);
        }));
      } else {
        throw Exception('Failed to load historical data');
      }
    } catch (e) {
      print('Error fetching historical data: $e');
      return [];
    }
  }

  static Future<PriceData?> fetchMarketData(String symbol) async {
    String _marketUrl =
        'https://api.binance.com/api/v3/ticker/price?symbol=${symbol}';
    try {
      final response = await http.get(Uri.parse(_marketUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        double price = double.parse(data['price']);
        return PriceData(DateTime.now(), price);
      } else {
        throw Exception('Failed to load live data');
      }
    } catch (e) {
      // print('Error fetching live data: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>> fetchMarketShareData() async {
    final response =
        await http.get(Uri.parse('https://api.coingecko.com/api/v3/global'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final marketCaps = data['data']['market_cap_percentage'];
      return marketCaps;
    } else {
      throw Exception("Failed to load market share data");
    }
  }
}

class TradeApiService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<List<num>>> fetchHistoricalPrices(String cryptoId) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/coins/$cryptoId/market_chart?vs_currency=usd&days=7&interval=daily'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prices = List<List<num>>.from(data['prices']);
      return prices;
    } else {
      throw Exception('Failed to load historical prices');
    }
  }
}


class BitcoinPrice {
  final DateTime timestamp;
  final double price;

  BitcoinPrice({required this.timestamp, required this.price});

  toList(BitcoinPrice map) {
    return [map.price, map.timestamp];
  }
}

Future<void> saveBinanceData(List<dynamic> data) async {
  final directory = await getApplicationDocumentsDirectory();

  final file = File('${directory.path}/binance_data.json');

  await file.writeAsString(jsonEncode(data));
  // print("binance data save at :${file.path}");
}

Future<List<dynamic>?> readBinanceData() async {
  final directory = await getApplicationDocumentsDirectory();

  final file = File('${directory.path}/binance_data.json');
  if (await file.exists()) {
    final jsonString = await file.readAsString();
    // print("data  loaded from${file.path}");

    return jsonDecode(jsonString);
  } else {
    // print("no saved data  data save at ");
    return null;
  }
}
