import 'package:flutter/material.dart';
import '../components/my_icons.dart';
import '../../models/crypto_model.dart';
import '../../utils/style.dart';

class PortfolioHoldingsWidgets extends StatelessWidget {
  final List<Currency> portfolio;

  const PortfolioHoldingsWidgets({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Portfolio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
            ),
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemCount: portfolio.length, // Use the length of the portfolio
            itemBuilder: (_, index) => PortfolioItem(
                currency: portfolio[index]), // Pass the currency data
          ),
        ),
      ],
    );
  }
}

class PortfolioItem extends StatelessWidget {
  const PortfolioItem({super.key, required this.currency});
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 200,
        height: 100,
        color: AppColors.secondaryColor,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIcons(icon: currency.icon),
                  SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currency.code,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainTextColor1,
                        ),
                      ),
                      Text(
                        currency.name,
                        style: TextStyle(fontSize: 14, color: primaryTextColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        currency.usdAmount,
                        style: TextStyle(
                          color: backgroundTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${currency.currentAmount} ${currency.code}",
                        style: TextStyle(
                          color: backgroundTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
