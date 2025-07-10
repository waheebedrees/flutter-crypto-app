import 'package:app/widgets/animations.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/price_model.dart';

class BitcoinPriceChart extends StatelessWidget {
  const BitcoinPriceChart({
    super.key,
    required this.zoomPanBehavior,
    required this.priceData,
  });

  final ZoomPanBehavior zoomPanBehavior;
  final List<PriceData> priceData;

  @override
  Widget build(BuildContext context) {
    if (priceData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        intervalType: getIntervalType(priceData),
        interactiveTooltip: InteractiveTooltip(enable: true),
        title: AxisTitle(text: 'الوقت'),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'السعر (USDT)'),
        labelFormat: '{value}',
        interactiveTooltip: InteractiveTooltip(enable: true),
      ),
      zoomPanBehavior: zoomPanBehavior,
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'BTC/USDT: point.y USDT at point.x',
      ),
      series: <LineSeries<PriceData, DateTime>>[
        LineSeries<PriceData, DateTime>(
          dataSource: priceData,
          xValueMapper: (PriceData price, _) => price.time,
          yValueMapper: (PriceData price, _) => price.price,
          name: 'BTC/USDT',
          color: Colors.blue,
          width: 2,
          markerSettings: MarkerSettings(isVisible: true),
        ),
      ],
    );
  }

  DateTimeIntervalType getIntervalType(List<PriceData> data) {
    final duration = data.last.time.difference(data.first.time);
    if (duration.inDays > 30) {
      return DateTimeIntervalType.days;
    } else if (duration.inHours > 24) {
      return DateTimeIntervalType.hours;
    } else {
      return DateTimeIntervalType.minutes;
    }
  }
}

class CryptoPriceChart extends StatelessWidget {
  const CryptoPriceChart({
    super.key,
    required this.zoomPanBehavior,
    required this.ethData,
    required this.bnbData,
    required this.btcData,
  });

  final ZoomPanBehavior zoomPanBehavior;
  final List<PriceData> btcData;
  final List<PriceData> ethData;
  final List<PriceData> bnbData;

  @override
  Widget build(BuildContext context) {
    if (btcData.isEmpty && ethData.isEmpty && bnbData.isEmpty) {
      return Center(child: ChartLoadingAnimation());
    }

    // final padding = MediaQuery.of(context).size.width < 600 ? 8.0 : 5.0;

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(title: AxisTitle(text: 'الوقت')),
      legend: Legend(isVisible: true, position: LegendPosition.top),
      zoomPanBehavior: zoomPanBehavior,
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'series.name: point.y USDT at point.x',
      ),
      series: <LineSeries<PriceData, DateTime>>[
        LineSeries<PriceData, DateTime>(
          dataSource: btcData,
          xValueMapper: (PriceData price, _) => price.time,
          yValueMapper: (PriceData price, _) => price.price.floor(),
          name: 'BTC/USDT',
          color: Colors.blue,
        ),
        LineSeries<PriceData, DateTime>(
          dataSource: ethData,
          xValueMapper: (PriceData price, _) => price.time,
          yValueMapper: (PriceData price, _) => price.price.floor(),
          name: 'ETH/USDT',
          color: Colors.green,
        ),
        LineSeries<PriceData, DateTime>(
          dataSource: bnbData,
          xValueMapper: (PriceData price, _) => price.time,
          yValueMapper: (PriceData price, _) => price.price.floor(),
          name: 'BNB/USDT',
          color: Colors.red,
        ),
      ],
    );
  }
}
