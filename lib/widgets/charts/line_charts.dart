import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../utils/style.dart';
import '../components/charts_title.dart';
import '../components/transformation_bottom.dart';

class LineChartScreen extends StatefulWidget {
  final List<(DateTime, double)>? bitcoinPriceHistory;
  const LineChartScreen({super.key, required this.bitcoinPriceHistory});

  @override
  State createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  late TransformationController _transformationController;
  bool _isPanEnabled = true;
  bool _isScaleEnabled = true;

  @override
  void initState() {
    _transformationController = TransformationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const leftReservedSize = 50.0;
    double maxYValue = widget.bitcoinPriceHistory!
        .map((e) => e.$2)
        .reduce((a, b) => a > b ? a : b);

    return SafeArea(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return width >= 300
                  ? Row(
                      children: [
                        const SizedBox(width: leftReservedSize),
                        const ChartTitle(),
                        const Spacer(),
                        Center(
                          child: TransformationButtons(
                              controller: _transformationController),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const ChartTitle(),
                        const SizedBox(height: 16),
                        TransformationButtons(
                            controller: _transformationController),
                      ],
                    );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Pan'),
                Switch(
                  value: _isPanEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isPanEnabled = value;
                    });
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                const Text('Scale'),
                Switch(
                  value: _isScaleEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isScaleEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 1.2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1200,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 18.0),
                  child: LineChart(
                    transformationConfig: FlTransformationConfig(
                      scaleAxis: FlScaleAxis.horizontal,
                      minScale: 1.0,
                      maxScale: 25.0,
                      panEnabled: _isPanEnabled,
                      scaleEnabled: _isScaleEnabled,
                      transformationController: _transformationController,
                    ),
                    LineChartData(
                      maxY: maxYValue + 4000,
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: widget.bitcoinPriceHistory
                                  ?.asMap()
                                  .entries
                                  .map((e) {
                                final index = e.key;
                                final item = e.value;
                                return FlSpot(index.toDouble(), item.$2);
                              }).toList() ??
                              [],
                          dotData: const FlDotData(show: true),
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
                                AppColors.contentColorYellow
                                    .withValues(alpha: 0.2),
                                AppColors.contentColorYellow
                                    .withValues(alpha: 0.0),
                              ],
                              stops: const [0.5, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchSpotThreshold: 210,
                        getTouchLineStart: (_, __) => -double.infinity,
                        getTouchLineEnd: (_, __) => double.infinity,
                        getTouchedSpotIndicator:
                            (LineChartBarData barData, List<int> spotIndexes) {
                          return spotIndexes.map((spotIndex) {
                            return TouchedSpotIndicatorData(
                              const FlLine(
                                color: AppColors.contentColorRed,
                                strokeWidth: 1.5,
                                dashArray: [8, 2],
                              ),
                              FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 6,
                                    color: AppColors.contentColorYellow,
                                    strokeWidth: 0,
                                    strokeColor: AppColors.contentColorYellow,
                                  );
                                },
                              ),
                            );
                          }).toList();
                        },
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              final price = barSpot.y;
                              final date = widget
                                  .bitcoinPriceHistory![barSpot.x.toInt()].$1;
                              return LineTooltipItem(
                                '',
                                const TextStyle(
                                  color: AppColors.contentColorBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${date.year}/${date.month}/${date.day}',
                                    style: TextStyle(
                                      color: AppColors.contentColorGreen
                                        ..colorSpace,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\n\$${price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: AppColors.contentColorYellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            }).toList();
                          },
                          getTooltipColor: (LineBarSpot barSpot) =>
                              AppColors.contentColorBlack,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            maxIncluded: false,
                            minIncluded: false,
                            showTitles: true,
                            reservedSize: leftReservedSize,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          drawBelowEverything: true,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: leftReservedSize,
                            maxIncluded: false,
                            minIncluded: false,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 38,
                            maxIncluded: false,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final date =
                                  widget.bitcoinPriceHistory![value.toInt()].$1;
                              return SideTitleWidget(
                                meta: meta,
                                child: Transform.rotate(
                                  angle: -45 * 3.14 / 180,
                                  child: Text(
                                    '${date.month}/${date.day}',
                                    style: const TextStyle(
                                      color: AppColors.contentColorGreen,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    duration: Duration.zero,
                  ),
                ),
              ),
            ),
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

class _TradeDialog extends StatefulWidget {
  final Function(
          String fromCurrency, String toCurrency, double amount, double rate)
      onTrade;

  const _TradeDialog({required this.onTrade});

  @override
  State<_TradeDialog> createState() => _TradeDialogState();
}

class _TradeDialogState extends State<_TradeDialog> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  String _fromCurrency = 'BTC';
  String _toCurrency = 'USDT';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Trade'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: _fromCurrency,
            onChanged: (value) => setState(() => _fromCurrency = value!),
            items: ['BTC', 'ETH', 'USDT'].map((currency) {
              return DropdownMenuItem(value: currency, child: Text(currency));
            }).toList(),
          ),
          DropdownButton<String>(
            value: _toCurrency,
            onChanged: (value) => setState(() => _toCurrency = value!),
            items: ['BTC', 'ETH', 'USDT'].map((currency) {
              return DropdownMenuItem(value: currency, child: Text(currency));
            }).toList(),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          TextField(
            controller: _rateController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Exchange Rate'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final amount = double.tryParse(_amountController.text) ?? 0.0;
            final rate = double.tryParse(_rateController.text) ?? 0.0;
            if (amount > 0 && rate > 0) {
              widget.onTrade(_fromCurrency, _toCurrency, amount, rate);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _rateController.dispose();
    super.dispose();
  }
}
