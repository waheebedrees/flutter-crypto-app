import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TradeDirection { buy, sell }

class TradeCurrency {
  final TradeDirection tradeDirection;
  final String date; // Changed 'data' to 'date' for clarity
  final double amount;

  TradeCurrency({
    required this.tradeDirection,
    required this.amount,
    required this.date,
  });
}

class Currency {
  final String code;
  final String name;
  final Image icon;
  final double currentAmount;
  final double profit;
  final List<double> priceHistory;
  final List<TradeCurrency> tradeHistory;

  Currency({
    required this.code,
    required this.name,
    required this.icon,
    required this.priceHistory,
    this.currentAmount = 0.0,
    this.profit = 0.0,
    this.tradeHistory = const [],
  });

  String get usdAmount => NumberFormat.simpleCurrency().format(
      currentAmount * (priceHistory.isNotEmpty ? priceHistory.first : 0));

  // Method to convert a map to a Currency object
  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      code: map['code'],
      name: map['name'],
      icon: Image.network(map['icon']), // Assuming the icon is a URL
      priceHistory: List<double>.from(map['priceHistory']),
      currentAmount: map['currentAmount'] ?? 0.0,
      profit: map['profit'] ?? 0.0,
      tradeHistory: (map['tradeHistory'] as List)
          .map((e) => TradeCurrency(
                tradeDirection: TradeDirection.values[map['tradeDirection']],
                amount: e['amount'],
                date: e['date'],
              ))
          .toList(),
    );
  }

  // Method to convert a Currency object to a map
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'icon': icon.toString(), // Change this according to your icon handling
      'priceHistory': priceHistory,
      'currentAmount': currentAmount,
      'profit': profit,
      'tradeHistory': tradeHistory
          .map((trade) => {
                'tradeDirection': trade.tradeDirection.index,
                'amount': trade.amount,
                'date': trade.date,
              })
          .toList(),
    };
  }
}


