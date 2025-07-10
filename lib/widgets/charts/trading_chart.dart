import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<dynamic> chartData;

  const ChartWidget({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Real-Time Price Movement'),
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: InteractiveTooltip(
          format:
              'Date: point.x\nOpen: point.open\nHigh: point.high\nLow: point.low\nClose: point.close',
        ),
      ),
      onDataLabelRender: (DataLabelRenderArgs args) {
        final close = chartData[args.pointIndex]['close'];
        final open = chartData[args.pointIndex]['open'];
        final isPositive = close > open;

        args.textStyle = TextStyle(
          color: isPositive ? Colors.green : Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        );
      },
      series: <CandleSeries>[
        CandleSeries<dynamic, DateTime>(
          dataSource: chartData,
          xValueMapper: (data, _) => data['x'],
          lowValueMapper: (data, _) => data['low'],
          highValueMapper: (data, _) => data['high'],
          openValueMapper: (data, _) => data['open'],
          closeValueMapper: (data, _) => data['close'],
          bullColor: Colors.green,
          bearColor: Colors.red,
        ),
      ],
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(),
    );
  }
}
