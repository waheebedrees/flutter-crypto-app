import 'package:flutter/material.dart';

class PerformanceSummary extends StatelessWidget {
  final int totalTrades;
  final double successRate;
  final double totalProfit;
  final double totalLoss;

  const PerformanceSummary({
    super.key,
    required this.totalTrades,
    required this.successRate,
    required this.totalProfit,
    required this.totalLoss,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 سجل الأداء',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildStatRow('عدد الصفقات:', totalTrades.toString()),
            _buildStatRow('نسبة النجاح:', '${successRate.toStringAsFixed(1)}%'),
            _buildStatRow(
                'إجمالي الأرباح:', '\$${totalProfit.toStringAsFixed(2)}',
                textColor: Colors.green[700]),
            _buildStatRow(
                'إجمالي الخسائر:', '\$${totalLoss.toStringAsFixed(2)}',
                textColor: Colors.red[700]),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
