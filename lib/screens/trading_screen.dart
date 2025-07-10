import 'package:app/screens/ai_trading.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/style.dart';
import 'transaction_screen.dart';

class TradingScreen extends StatelessWidget {
  const TradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            AccountSummary(),
            const SizedBox(height: 20),
            TradingChart(),
            const SizedBox(height: 20),
            PriceChart(),
            const SizedBox(height: 20),
            AssetDetails(),
            const SizedBox(height: 20),
            TradingButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PriceChart extends StatelessWidget {
  final List<FlSpot> _priceData = [
    FlSpot(0, 30000),
    FlSpot(1, 30500),
    FlSpot(2, 31000),
    FlSpot(3, 30800),
    FlSpot(4, 31200),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: _priceData,
              isCurved: true,
              color: AppColors.contentColorYellow,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.contentColorYellow.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}h',
                      style: TextStyle(fontSize: 10));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }
}

class AssetDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bitcoin (BTC)',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$31,200',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '+2.5%',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Market Cap: \$500B',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class TradingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTransactionScreen(),
                  ));
              // print('Buy Order Executed');
            },
            icon: Icon(Icons.arrow_upward, color: Colors.white),
            label: Text('Buy', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // print('Sell Order Executed');
            },
            icon: Icon(Icons.arrow_downward, color: Colors.white),
            label: Text('Sell', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Balance:', style: TextStyle(fontSize: 16)),
                  Text('\$10,000',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BTC Holdings:', style: TextStyle(fontSize: 16)),
                  Text('0.5 BTC',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
