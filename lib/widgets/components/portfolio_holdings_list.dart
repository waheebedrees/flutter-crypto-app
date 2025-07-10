import 'package:flutter/material.dart';

import '../../models/model.dart';
class PortfolioHoldingsList extends StatelessWidget {
  final List<Holding> holdings;
  const PortfolioHoldingsList({super.key, required this.holdings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Holdings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: holdings.length,
          itemBuilder: (context, index) {
            final holding = holdings[index];
            return ListTile(
              leading:
                  CircleAvatar(backgroundImage: AssetImage(holding.logoUrl)),
              title: Text(holding.name),
              subtitle: Text('${holding.quantity} ${holding.symbol}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$${holding.value.toStringAsFixed(2)}'),
                  Text('${holding.percentage.toStringAsFixed(2)}%'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
