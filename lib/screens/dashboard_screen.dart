import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/style.dart';
import '../widgets/animations.dart';
import '../widgets/charts/bitcoin_price_chart.dart';
import '../widgets/charts/pie_chart.dart';
import '../widgets/charts/bitcoin_line_chart.dart';
import '../widgets/charts/line_charts.dart';
import '../service/api.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<(DateTime, double)>? _bitcoinPriceHistory;
  String selectedRange = '1D';
  @override
  void initState() {
    super.initState();
    _fetchBitcoinPriceHistory();
  }

  void _fetchBitcoinPriceHistory() async {
    try {
      final data = await BinanceApi.fetchBitcoinPrice(
        symbol: 'BTCUSDT',
        interval: '1d',
        limit: 30,
      );
      setState(() {
        _bitcoinPriceHistory =
            data.map((item) => (item.timestamp, item.price)).toList();
      });
    } catch (e) {
      print('Error fetching Bitcoin price history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _bitcoinPriceHistory == null
                  ? Center(child: ChartLoadingAnimation())
                  : Column(
                      children: [
                        MarketPredictions(),
                        SizedBox(height: 20),
                        MarketAnalysis(),
                        SizedBox(height: 20),
                        FinancialNews(),
                        SizedBox(height: 20),
                        LineChartScreen(
                            bitcoinPriceHistory: _bitcoinPriceHistory!),
                        SizedBox(height: 20),
                        BitcoinPriceChart(
                            bitcoinPriceHistory: _bitcoinPriceHistory!),
                        SizedBox(height: 20),
                        BitcoinLineChart(
                            bitcoinPriceHistory: _bitcoinPriceHistory!),
                        PieCharts(),
                        SizedBox(height: 20),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarketPredictions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Market Predictions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Bitcoin'),
          subtitle: const Text('Expected to reach \$40,000 by next month.'),
          trailing: Icon(Icons.arrow_upward, color: Colors.green),
        ),
        ListTile(
          title: const Text('Ethereum'),
          subtitle: const Text('Expected to stabilize at \$2,000.'),
          trailing: Icon(Icons.arrow_downward, color: Colors.red),
        ),
      ],
    );
  }
}

class MarketAnalysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Market Analysis',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.4,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 10000),
                    FlSpot(1, 12000),
                    FlSpot(2, 15000),
                    FlSpot(3, 18000),
                  ],
                  color: AppColors.contentColorYellow,
                  barWidth: 2,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The market is showing an upward trend with Bitcoin leading the charge.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

class FinancialNews extends StatelessWidget {
  final List<Map<String, String>> news = [
    {
      'title': 'Bitcoin Surges to New Highs',
      'summary': 'Bitcoin has reached a new all-time high...',
      'url': 'https://example.com/bitcoin-news',
    },
    {
      'title': 'Ethereum Faces Volatility',
      'summary': 'Ethereum prices are fluctuating due to...',
      'url': 'https://example.com/ethereum-news',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Latest Financial News',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: news.length,
          itemBuilder: (context, index) {
            final item = news[index];
            return ListTile(
              title: Text(item['title']!),
              subtitle: Text(item['summary']!),
              onTap: () {
                launchUrl(Uri.parse(item['url']!));
              },
            );
          },
        ),
      ],
    );
  }
}

void launchUrl(Uri parse) {}
