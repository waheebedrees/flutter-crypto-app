import 'package:app/utils/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BitcoinPriceChart extends StatelessWidget {
  final List<(DateTime, double)> bitcoinPriceHistory;
  const BitcoinPriceChart({super.key, required this.bitcoinPriceHistory});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 800, // Set a large width to enable horizontal scrolling
          height: 400, // Fixed height for vertical scrolling
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: bitcoinPriceHistory.asMap().entries.map((e) {
                    final index = e.key;
                    final item = e.value;
                    return FlSpot(index.toDouble(), item.$2);
                  }).toList(),
                  dotData: const FlDotData(show: false),
                  color: AppColors.contentColorYellow,
                  barWidth: 1,
                  shadow: const Shadow(
                    color: AppColors.contentColorYellow,
                    blurRadius: 2,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.contentColorYellow.withValues(alpha: 0.2),
                        AppColors.contentColorYellow.withValues(alpha: 0.0),
                      ],
                      stops: const [0.5, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 38,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final date = bitcoinPriceHistory[value.toInt()].$1;
                      return SideTitleWidget(
                        meta: meta,
                        child: Text(
                          '${date.month}/${date.day}',
                          style: const TextStyle(
                            color: AppColors.contentColorGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
