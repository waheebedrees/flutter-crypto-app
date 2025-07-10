import 'package:flutter/material.dart';

import '../models/crypto_model.dart';
import '../models/holding.dart';
import '../repo/portfolio_repo.dart';
import '../widgets/components/portfolio_holdings_list.dart';
import '../widgets/components/portfolio_summary.dart';
import '../widgets/components/profolio_list.dart';
import '../widgets/components/portfolio_actions.dart';
import '../widgets/charts/portfoilo_chart.dart';

class PortfolioScreen extends StatefulWidget {
  PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  double _totalValue = 0.0;
  List<Holding> _holdings = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Currency> _userPortfolio = List.empty();

  void getData() async {
    double totalValue = await PortfolioRepository.getTotalValue();
    List<Holding> holdings = await PortfolioRepository.getHoldings();
    List<Currency> userPortfolios =
        await PortfolioRepository.getUserPortfolio();
    if (userPortfolios.isEmpty) {
      userPortfolios.addAll([
        Currency(
          code: 'BTC',
          name: 'Bitcoin',
          icon: Image.asset("assets/btc.png"),
          priceHistory: [.0, .0, .0],
          currentAmount: 0.0,
          profit: 0.0,
          tradeHistory: [],
        ),
        Currency(
          code: 'ETH',
          name: 'Ethereum',
          icon: Image.asset('assets/eth.png'),
          priceHistory: [.0, .0, 00.0],
          currentAmount: 0.0,
          profit: 0.0,
          tradeHistory: [],
        )
      ]);
    }
    setState(() {
      _userPortfolio = userPortfolios;
      _holdings = holdings;
      _totalValue = totalValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PortfolioHoldingsWidgets(portfolio: _userPortfolio),
            const SizedBox(height: 20),
            PortfolioSummary(totalValue: _totalValue),
            const SizedBox(height: 20),
            const PortfolioActions(),
            const SizedBox(height: 20),
            PortfolioHoldingsList(holdings: _holdings),
            const SizedBox(height: 20),
            const PortfolioPerformanceChart(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
