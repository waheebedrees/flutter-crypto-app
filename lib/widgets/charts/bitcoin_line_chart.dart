import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../utils/style.dart';

class BitcoinLineChart extends StatefulWidget {
  const BitcoinLineChart({super.key, required this.bitcoinPriceHistory});
  final List<(DateTime, double)>? bitcoinPriceHistory;
  @override
  State<BitcoinLineChart> createState() => _BitcoinLineChartState();
}

class _BitcoinLineChartState extends State<BitcoinLineChart> {
  late TransformationController _transformationController;
  bool _isPanEnabled = true;
  bool _isScaleEnabled = true;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Pan'),
                Switch(
                  value: _isPanEnabled,
                  onChanged: (value) => setState(() => _isPanEnabled = value),
                ),
                const Text('Scale'),
                Switch(
                  value: _isScaleEnabled,
                  onChanged: (value) => setState(() => _isScaleEnabled = value),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 1.4,
            child: LineCharts(bitcoinPriceHistory: widget.bitcoinPriceHistory),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }
}

class LineCharts extends StatelessWidget {
  const LineCharts({
    super.key,
    required List? bitcoinPriceHistory,
  }) : _bitcoinPriceHistory = bitcoinPriceHistory;

  final List? _bitcoinPriceHistory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: SizedBox(
        width: 1200, // Set a large width to accommodate all data points
        height: 200, // Fixed height for vertical scrolling
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: _bitcoinPriceHistory?.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.$2);
                    }).toList() ??
                    [],
                isCurved: true,
                color: AppColors.contentColorYellow,
                barWidth: 1.5,
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.contentColorYellow.withOpacity(0.3),
                ),
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final date = _bitcoinPriceHistory?[value.toInt()].$1;
                    return date != null
                        ? Text(
                            '${date.month}/${date.day}',
                            style: const TextStyle(fontSize: 12),
                          )
                        : const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
