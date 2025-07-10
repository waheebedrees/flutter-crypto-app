import 'package:app/models/holding.dart';
import 'package:app/utils/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PortfolioPieChart extends StatelessWidget {
  final List<Holding> holdings;
  const PortfolioPieChart({super.key, required this.holdings});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              if (pieTouchResponse != null &&
                  pieTouchResponse.touchedSection != null) {
                final touchedSection = pieTouchResponse.touchedSection!;
                final holding = holdings[touchedSection.touchedSectionIndex];
                print('Tapped on ${holding.symbol}');
                // You can also show a dialog or navigate to another screen here
              }
            },
          ),
          sections: holdings.map((holding) {
            return PieChartSectionData(
              value: holding.percentage,
              title: holding.symbol,
              color: getColorForSymbol(holding.symbol),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PortfolioPerformanceChart extends StatelessWidget {
  const PortfolioPerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 10000),
                const FlSpot(1, 12000),
                const FlSpot(2, 15000),
                const FlSpot(3, 18000),
              ],
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
