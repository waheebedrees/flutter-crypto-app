import 'package:flutter/material.dart';

import '../models/holding.dart';

import '../models/user_model.dart';

List<Map<String, String>> onboardingData = [
  {
    "title": "Secure Digital Wallet",
    "desc": "Manage your assets with top-level security and privacy.",
  },
  {
    "title": "Instant Transactions",
    "desc": "Fast and reliable transactions anytime, anywhere.",
  },
  {
    "title": "Track Your Investments",
    "desc": "Monitor your portfolio and track crypto movements easily.",
  },
  {
    "title": "Start Now",
    "desc": "Create an account and enjoy a secure financial experience.",
  },
];

const backgroundColor = Color(0xff1A1E28);
const primaryColor = Color(0xff262f40);
const secondaryColor = Color(0xff3C495D);

const backgroundTextColor = Color(0xffeef1f4);
const primaryTextColor = Color(0xffb1bccd);

const backgroundColor2 = Color.fromARGB(255, 30, 37, 55);

// Simulated User
final User mockUser = User(
  id: '1',
  name: 'Waheeb Edrees',
  email: 'ewaheeb02.doe@example.com',
  profileImageUrl: 'assets/sobGOGlight.png',
);

// Simulated Holdings (for Wallet)
final List<Holdings> mockHoldings = [
  Holdings(assetSymbol: "BTC", quantity: 0.05, averagePrice: 45000.0),
  Holdings(assetSymbol: "ETH", quantity: 2.0, averagePrice: 3000.0),
];
