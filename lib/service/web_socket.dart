import 'dart:convert';

import 'package:app/models/market_model.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RealTimeDataProvider with ChangeNotifier {
  List<MarketData> marketData = [];
  final WebSocketChannel channel;

  RealTimeDataProvider()
      : channel = WebSocketChannel.connect(
          Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@kline_1m'),
        ) {
    channel.stream.listen((data) {
      final jsonData = json.decode(data);
      final newData = MarketData(
          timestamp: DateTime.fromMillisecondsSinceEpoch(jsonData['k']['t']),
          open: double.parse(jsonData['k']['o']),
          high: double.parse(jsonData['k']['h']),
          low: double.parse(jsonData['k']['l']),
          close: double.parse(jsonData['k']['c']),
          volume: double.parse(jsonData['k']['c']));
      marketData.add(newData);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
