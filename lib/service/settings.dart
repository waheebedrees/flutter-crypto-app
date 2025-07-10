import 'package:shared_preferences/shared_preferences.dart';

class TradingBotConfig {
  String selectedStrategy;
  double tradeSize;
  double stopLoss;
  double takeProfit;
  bool reinvest;
  bool isBotActive;
  int totalTrades;
  double successRate;
  double totalProfit;
  double totalLoss;
  bool tradeExecution;
  bool profitLossAlerts;
  bool dailySummary;

  TradingBotConfig({
    required this.selectedStrategy,
    required this.tradeSize,
    required this.stopLoss,
    required this.takeProfit,
    required this.reinvest,
    required this.isBotActive,
    required this.totalTrades,
    required this.successRate,
    required this.totalProfit,
    required this.totalLoss,
    required this.tradeExecution,
    required this.profitLossAlerts,
    required this.dailySummary,
  });

  // Convert to Map (for saving)
  Map<String, dynamic> toMap() {
    return {
      'selectedStrategy': selectedStrategy,
      'tradeSize': tradeSize,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'reinvest': reinvest,
      'isBotActive': isBotActive,
      'totalTrades': totalTrades,
      'successRate': successRate,
      'totalProfit': totalProfit,
      'totalLoss': totalLoss,
      'tradeExecution': tradeExecution,
      'profitLossAlerts': profitLossAlerts,
      'dailySummary': dailySummary,
    };
  }

  // Create an object from Map (for loading)
  factory TradingBotConfig.fromMap(Map<String, dynamic> map) {
    return TradingBotConfig(
      selectedStrategy: map['selectedStrategy'] ?? 'Scalping',
      tradeSize: map['tradeSize'] ?? 100.0,
      stopLoss: map['stopLoss'] ?? 5.0,
      takeProfit: map['takeProfit'] ?? 10.0,
      reinvest: map['reinvest'] ?? false,
      isBotActive: map['isBotActive'] ?? false,
      totalTrades: map['totalTrades'] ?? 0,
      successRate: map['successRate'] ?? 0.0,
      totalProfit: map['totalProfit'] ?? 0.0,
      totalLoss: map['totalLoss'] ?? 0.0,
      tradeExecution: map['tradeExecution'] ?? true,
      profitLossAlerts: map['profitLossAlerts'] ?? false,
      dailySummary: map['dailySummary'] ?? true,
    );
  }
}

class TradingBotSettings {
  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveSettings(TradingBotConfig config) async {
    final prefs = await _getPreferences();
    await prefs.setString('selectedStrategy', config.selectedStrategy);
    await prefs.setDouble('tradeSize', config.tradeSize);
    await prefs.setDouble('stopLoss', config.stopLoss);
    await prefs.setDouble('takeProfit', config.takeProfit);
    await prefs.setBool('reinvest', config.reinvest);
    await prefs.setBool('isBotActive', config.isBotActive);
    await prefs.setInt('totalTrades', config.totalTrades);
    await prefs.setDouble('successRate', config.successRate);
    await prefs.setDouble('totalProfit', config.totalProfit);
    await prefs.setDouble('totalLoss', config.totalLoss);
    await prefs.setBool('tradeExecution', config.tradeExecution);
    await prefs.setBool('profitLossAlerts', config.profitLossAlerts);
    await prefs.setBool('dailySummary', config.dailySummary);
  }

  static Future<TradingBotConfig> loadSettings() async {
    final prefs = await _getPreferences();
    return TradingBotConfig(
      selectedStrategy: prefs.getString('selectedStrategy') ?? 'Scalping',
      tradeSize: prefs.getDouble('tradeSize') ?? 100.0,
      stopLoss: prefs.getDouble('stopLoss') ?? 5.0,
      takeProfit: prefs.getDouble('takeProfit') ?? 10.0,
      reinvest: prefs.getBool('reinvest') ?? false,
      isBotActive: prefs.getBool('isBotActive') ?? false,
      totalTrades: prefs.getInt('totalTrades') ?? 0,
      successRate: prefs.getDouble('successRate') ?? 0.0,
      totalProfit: prefs.getDouble('totalProfit') ?? 0.0,
      totalLoss: prefs.getDouble('totalLoss') ?? 0.0,
      tradeExecution: prefs.getBool('tradeExecution') ?? true,
      profitLossAlerts: prefs.getBool('profitLossAlerts') ?? false,
      dailySummary: prefs.getBool('dailySummary') ?? true,
    );
  }
}
