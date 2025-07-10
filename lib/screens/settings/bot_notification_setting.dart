import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BotNotificationSettings extends StatefulWidget {
  final bool tradeExecution;
  final bool profitLossAlerts;
  final bool dailySummary;
  final ValueChanged<bool> onTradeExecutionChanged;
  final ValueChanged<bool> onProfitLossChanged;
  final ValueChanged<bool> onDailySummaryChanged;
  const BotNotificationSettings({
    super.key,
    required this.tradeExecution,
    required this.profitLossAlerts,
    required this.dailySummary,
    required this.onTradeExecutionChanged,
    required this.onProfitLossChanged,
    required this.onDailySummaryChanged,
  });

  @override
  _BotNotificationSettingsState createState() =>
      _BotNotificationSettingsState();
}

class _BotNotificationSettingsState extends State<BotNotificationSettings> {
  late bool _tradeExecution;
  late bool _profitLossAlerts;
  late bool _dailySummary;

  @override
  void initState() {
    super.initState();
    _tradeExecution = widget.tradeExecution;
    _profitLossAlerts = widget.profitLossAlerts;
    _dailySummary = widget.dailySummary;
    _loadPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tradeExecution =
          prefs.getBool('tradeExecution') ?? widget.tradeExecution;
      _profitLossAlerts =
          prefs.getBool('profitLossAlerts') ?? widget.profitLossAlerts;
      _dailySummary = prefs.getBool('dailySummary') ?? widget.dailySummary;
    });
  }

  // Save preferences
  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔔 إعدادات التنبيهات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(),
            _buildSwitchTile(
              title: 'تفعيل التنبيهات عند تنفيذ الصفقات',
              subtitle: 'احصل على إشعارات عند تنفيذ عمليات التداول.',
              value: _tradeExecution,
              onChanged: (value) {
                setState(() => _tradeExecution = value);
                _savePreference('tradeExecution', value);
                widget.onTradeExecutionChanged(value);
              },
            ),
            _buildSwitchTile(
              title: 'تنبيهات عند تحقيق ربح/خسارة',
              subtitle: 'تلقي إشعارات عند تحقيق أرباح أو خسائر.',
              value: _profitLossAlerts,
              onChanged: (value) {
                setState(() => _profitLossAlerts = value);
                _savePreference('profitLossAlerts', value);
                widget.onProfitLossChanged(value);
              },
            ),
            _buildSwitchTile(
              title: 'إرسال تقرير يومي عن الأداء',
              subtitle: 'احصل على ملخص يومي حول صفقاتك.',
              value: _dailySummary,
              onChanged: (value) {
                setState(() => _dailySummary = value);
                _savePreference('dailySummary', value);
                widget.onDailySummaryChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey)),
      value: value,
      onChanged: onChanged,
    );
  }
}
