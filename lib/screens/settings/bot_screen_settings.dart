import 'package:app/service/notification_service.dart';
import 'package:app/service/settings.dart';
import 'package:flutter/material.dart';

import '../../ai_engine/bot_core.dart';
import '../../widgets/components/slider_with_label.dart';
import '../bot_performance.dart';
import 'bot_notification_setting.dart';

class TradingBotSettingsScreen extends StatefulWidget {
  const TradingBotSettingsScreen({super.key});

  @override
  State<TradingBotSettingsScreen> createState() =>
      _TradingBotSettingsScreenState();
}

class _TradingBotSettingsScreenState extends State<TradingBotSettingsScreen> {
  final BotCore botCore = BotCore(); // Initialize BotCore
  String _selectedStrategy = 'Scalping';
  double _tradeSize = 100;
  double _stopLoss = 5;
  double _takeProfit = 10;
  bool _reinvest = false;
  bool _isBotActive = false;
  int _totalTrades = 0;
  double _successRate = 0.0;
  double _totalProfit = 0.0;
  double _totalLoss = 0.0;
  bool _tradeExecution = true;
  bool _profitLossAlerts = false;
  bool _dailySummary = true;

  final List<String> _strategies = [
    'Scalping',
    'Grid Trading',
    'Mean Reversion',
    'Momentum Trading',
    'Arbitrage',
  ];
  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load settings when the widget is initialized
  }

  Future<void> _loadSettings() async {
    TradingBotConfig settings = await TradingBotSettings.loadSettings();

    setState(() {
      _selectedStrategy = settings.selectedStrategy;
      _tradeSize = settings.tradeSize;
      _stopLoss = settings.stopLoss;
      _takeProfit = settings.takeProfit;
      _reinvest = settings.reinvest;
      _isBotActive = settings.isBotActive;
      _totalTrades = settings.totalTrades;
      _successRate = settings.successRate;
      _totalProfit = settings.totalProfit;
      _totalLoss = settings.totalLoss;
      _tradeExecution = settings.tradeExecution;
      _profitLossAlerts = settings.profitLossAlerts;
      _dailySummary = settings.dailySummary;
    });
  }

  void saveSettings() async {
    TradingBotConfig botConfig = TradingBotConfig(
      selectedStrategy: _strategies[0],
      tradeSize: _tradeSize,
      stopLoss: _stopLoss,
      takeProfit: _takeProfit,
      reinvest: _reinvest,
      isBotActive: _isBotActive,
      totalTrades: _totalTrades,
      successRate: _successRate,
      totalProfit: _totalProfit,
      totalLoss: _totalLoss,
      tradeExecution: _tradeExecution,
      profitLossAlerts: _profitLossAlerts,
      dailySummary: _dailySummary,
    );

    await TradingBotSettings.saveSettings(botConfig);
    _loadSettings();
  }

  void _runBot() async {
    if (_isBotActive) {
      Map<String, dynamic> result =
          await botCore.executeStrategy(_selectedStrategy, 'BTCUSDT');

      String action = result["action"] ?? "hold";
      double amount = result["amount"] ?? 0.0;
      double profitOrLoss = result["profit"] ?? 0.0;

      setState(() {
        _totalTrades++;
        if (action == "buy" || action == "sell") {
          if (profitOrLoss > 0) {
            _totalProfit += profitOrLoss;
          } else {
            _totalLoss += profitOrLoss.abs();
          }
          _successRate = (_totalProfit + _totalLoss == 0)
              ? 0.0
              : ((_totalProfit / (_totalProfit + _totalLoss)) * 100);
        }
      });

      // Send notification
      await NotificationService.showNotification(
        "Trading Bot Alert",
        "Bot executed $action of \$$amount | Profit/Loss: \$$profitOrLoss",
      );

      print('Bot executed: $action \$$amount, Profit/Loss: \$$profitOrLoss');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('استراتيجيات التداول'),
            DropdownButtonFormField<String>(
              value: _selectedStrategy,
              items: _strategies.map((strategy) {
                return DropdownMenuItem(
                  value: strategy,
                  child: Text(strategy),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStrategy = value!;
                });
                saveSettings();
              },
              decoration: const InputDecoration(
                labelText: 'اختر استراتيجية',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('إعدادات المخاطر'),
            SliderWithLabel(
              label: 'حجم الصفقة (\$)',
              value: _tradeSize,
              min: 100,
              max: 10000,
              onChanged: (value) {
                setState(() {
                  _tradeSize = value;
                });
                saveSettings();
              },
            ),
            SliderWithLabel(
              label: 'إيقاف الخسارة (%)',
              value: _stopLoss,
              min: 1,
              max: 20,
              onChanged: (value) {
                setState(() {
                  _stopLoss = value;
                });
                saveSettings();
              },
            ),
            SliderWithLabel(
              label: 'جني الأرباح (%)',
              value: _takeProfit,
              min: 5,
              max: 50,
              onChanged: (value) {
                setState(() {
                  _takeProfit = value;
                });
                saveSettings();
              },
            ),
            SwitchListTile(
              title: const Text('إعادة الاستثمار'),
              value: _reinvest,
              onChanged: (value) {
                setState(() {
                  _reinvest = value;
                });
                saveSettings();
              },
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('إدارة الروبوت'),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isBotActive = !_isBotActive;
                });
                saveSettings();
                _runBot();
              },
              icon: Icon(_isBotActive ? Icons.stop : Icons.play_arrow),
              label: Text(_isBotActive ? 'إيقاف الروبوت' : 'تشغيل الروبوت'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBotActive ? Colors.red : Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _isBotActive ? 'الروبوت قيد التشغيل' : 'الروبوت متوقف',
              style: TextStyle(
                color: _isBotActive ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('أداء الروبوت'),
            PerformanceSummary(
              totalTrades: _totalTrades,
              successRate: _successRate,
              totalProfit: _totalProfit,
              totalLoss: _totalLoss,
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('التنبيهات'),
            BotNotificationSettings(
              tradeExecution: _tradeExecution,
              profitLossAlerts: _profitLossAlerts,
              dailySummary: _dailySummary,
              onTradeExecutionChanged: (value) {
                setState(() {
                  _tradeExecution = value;
                });
              },
              onProfitLossChanged: (value) {
                setState(() {
                  _profitLossAlerts = value;
                });
              },
              onDailySummaryChanged: (value) {
                setState(() {
                  _dailySummary = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
