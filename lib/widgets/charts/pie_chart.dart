import 'package:app/service/api.dart';
import 'package:app/widgets/animations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieCharts extends StatefulWidget {
  const PieCharts({super.key});

  @override
  State<PieCharts> createState() => _PieChartsState();
}

class _PieChartsState extends State<PieCharts> {
  int touchedIndex = -1;
  List<Map<String, dynamic>> cryptoData = [];

  @override
  void initState() {
    super.initState();
    fetchMarket();
  }

  Future<void> fetchMarket() async {
    final marketCaps = await BinanceApi.fetchMarketShareData();
    setState(() {
      cryptoData = [
        {"name": "BTC", "value": marketCaps["btc"], "color": Colors.blue},
        {"name": "ETH", "value": marketCaps["eth"], "color": Colors.orange},
        {"name": "BNB", "value": marketCaps["bnb"], "color": Colors.green},
        {"name": "USDT", "value": marketCaps["usdt"], "color": Colors.red},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return cryptoData.isEmpty
        ? Center(child: ChartLoadingAnimation())
        : AspectRatio(
            aspectRatio: 1.3,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse?.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse!
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cryptoData.map((data) {
                    return Indicator(
                      color: data["color"],
                      text: data["name"],
                      isSquare: true,
                    );
                  }).toList(),
                ),
                const SizedBox(width: 28),
              ],
            ),
          );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(cryptoData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: cryptoData[i]["color"],
        value: cryptoData[i]["value"],
        title: "${cryptoData[i]["value"].toStringAsFixed(1)}%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.white,
          ),
        )
      ],
    );
  }
}
