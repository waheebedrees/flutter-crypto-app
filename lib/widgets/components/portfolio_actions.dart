import 'package:flutter/material.dart';

class PortfolioActions extends StatelessWidget {
  const PortfolioActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => _showDepositDialog(context),
          icon: const Icon(Icons.add),
          label: const Text('Deposit'),
        ),
        ElevatedButton.icon(
          onPressed: () => _showWithdrawDialog(context),
          icon: const Icon(Icons.money_off),
          label: const Text('Withdraw'),
        ),
        ElevatedButton.icon(
          onPressed: () => _showTradeDialog(context),
          icon: const Icon(Icons.swap_horiz),
          label: const Text('Trade'),
        ),
      ],
    );
  }

  void _showDepositDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deposit Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount (USD)'),
            ),
            DropdownButton<String>(
              value: 'USDT',
              onChanged: (value) {},
              items: ['BTC', 'ETH', 'USDT'].map((currency) {
                return DropdownMenuItem(value: currency, child: Text(currency));
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(onPressed: () {}, child: const Text('Deposit')),
        ],
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount (USD)'),
            ),
            DropdownButton<String>(
              value: 'USDT',
              onChanged: (value) {},
              items: ['BTC', 'ETH', 'USDT'].map((currency) {
                return DropdownMenuItem(value: currency, child: Text(currency));
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(onPressed: () {}, child: const Text('Withdraw')),
        ],
      ),
    );
  }

  void _showTradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trade Assets'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: 'BTC',
              onChanged: (value) {},
              items: ['BTC', 'ETH', 'USDT'].map((currency) {
                return DropdownMenuItem(value: currency, child: Text(currency));
              }).toList(),
            ),
            DropdownButton<String>(
              value: 'USDT',
              onChanged: (value) {},
              items: ['BTC', 'ETH', 'USDT'].map((currency) {
                return DropdownMenuItem(value: currency, child: Text(currency));
              }).toList(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Exchange Rate'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(onPressed: () {}, child: const Text('Trade')),
        ],
      ),
    );
  }
}
