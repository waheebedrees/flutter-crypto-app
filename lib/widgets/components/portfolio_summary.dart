import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

class PortfolioSummary extends StatelessWidget {
  final double totalValue;
  const PortfolioSummary({super.key, required this.totalValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Total Value',
            style: TextStyle(fontSize: 18, color: AppColors.mainTextColor1)),
        Text('\$$totalValue',
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1)),
        const Text('+\$2,000 (4%)',
            style: TextStyle(color: AppColors.contentColorCyan, fontSize: 16)),
      ],
    );
  }
}
