import 'dart:math';


import '../models/holding.dart';
import '../models/market_model.dart';
import '../models/news_models.dart';
import '../models/trade_model.dart';
import '../models/user_model.dart';

List<User> users = [
  User(
    id: '1',
    name: 'Waheeb Edrees',
    email: 'ewaheeb02.doe@example.com',
    profileImageUrl: 'assets/sobGOGlight.png',
  ),
  User(
    id: '2',
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    profileImageUrl: null,
  ),
];


final List<Holdings> mockHoldings = [
  Holdings(assetSymbol: "BTC", quantity: 0.05, averagePrice: 45000.0),
  Holdings(assetSymbol: "ETH", quantity: 2.0, averagePrice: 3000.0),
];

List<Trade> trades = [
  Trade(
    id: 't1',
    orderId: 'o1',
    userId: '1',
    assetSymbol: 'BTC',
    tradeType: 'BUY',
    quantity: 0.5,
    price: 26000.00,
    timestamp: DateTime(2023, 10, 1, 12, 30),
  ),
  Trade(
    id: 't2',
    orderId: 'o2',
    userId: '1',
    assetSymbol: 'ETH',
    tradeType: 'SELL',
    quantity: 1.0,
    price: 1850.00,
    timestamp: DateTime(2023, 10, 2, 15, 45),
  ),
];

List<News> newsArticles = [
  News(
    title: 'Bitcoin Surges Past \$27,000 Amid Market Optimism',
    description:
        'Bitcoin has surged past the \$27,000 mark today, driven by renewed investor confidence and positive regulatory developments.',
    date: DateTime(2023, 10, 1),
  ),
  News(
    title: 'Ethereum Completes Major Network Upgrade',
    description:
        'Ethereum successfully completed its latest network upgrade, improving scalability and reducing gas fees.',
    date: DateTime(2023, 9, 28),
  ),
];

List<MarketData> marketData = [
  MarketData(
    timestamp: DateTime(2023, 10, 1, 12, 0),
    open: 26500.00,
    high: 27100.00,
    low: 26400.00,
    close: 27000.00,
    volume: 150000000,
  ),
  MarketData(
    timestamp: DateTime(2023, 10, 1, 13, 0),
    open: 27000.00,
    high: 27200.00,
    low: 26900.00,
    close: 27150.00,
    volume: 140000000,
  ),
];



class MockApiQueen {
  // Simulated delay to mimic network latency
  Future<T> _withDelay<T>(T value) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate 1-second delay
    return value;
  }

  // Fetch user profile data
  // Fetch user profile data
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final users = [
      {
        "id": "1",
        "name": "John Doe",
        "email": "john.doe@example.com",
        "profileImageUrl": "https://example.com/profiles/john.jpg",
      },
      {
        "id": "2",
        "name": "Jane Smith",
        "email": "jane.smith@example.com",
        "profileImageUrl": null,
      }
    ];

    // Provide a default empty map if no user is found
    final user = users.firstWhere(
      (u) => u["id"] == userId,
      orElse: () =>
          {"id": "", "name": "", "email": "", "profileImageUrl": null},
    );

    return _withDelay(user);
  }

  // Fetch wallet data for a specific user
  Future<Map<String, dynamic>> getWalletData(String userId) async {
    final wallets = [
      {
        "id": "w1",
        "userId": "1",
        "balance": 50000.00,
        "holdings": [
          {"assetSymbol": "BTC", "quantity": 0.5, "averagePrice": 26000.00},
          {"assetSymbol": "ETH", "quantity": 2.0, "averagePrice": 1750.00},
        ]
      },
      {
        "id": "w2",
        "userId": "2",
        "balance": 10000.00,
        "holdings": [
          {"assetSymbol": "SOL", "quantity": 10.0, "averagePrice": 20.00},
        ]
      }
    ];

    // Provide a default empty wallet if no wallet is found
    final wallet = wallets.firstWhere(
      (w) => w["userId"] == userId,
      orElse: () => {
        "id": "",
        "userId": "",
        "balance": 0.0,
        "holdings": [],
      },
    );

    return _withDelay(wallet);
  }

  // Fetch trade history for a specific user
  Future<List<Map<String, dynamic>>> getTradeHistory(String userId) async {
    final trades = [
      {
        "id": "t1",
        "orderId": "o1",
        "userId": "1",
        "assetSymbol": "BTC",
        "tradeType": "buy",
        "quantity": 0.5,
        "price": 26000.00,
        "timestamp": DateTime(2023, 10, 1, 12, 30).toIso8601String(),
      },
      {
        "id": "t2",
        "orderId": "o2",
        "userId": "1",
        "assetSymbol": "ETH",
        "tradeType": "sell",
        "quantity": 1.0,
        "price": 1850.00,
        "timestamp": DateTime(2023, 10, 2, 15, 45).toIso8601String(),
      }
    ];

    // Filter trades by userId; return an empty list if none are found
    final userTrades = trades.where((t) => t["userId"] == userId).toList();
    return _withDelay(userTrades);
  }

  // Fetch asset market data (e.g., BTC, ETH)
  Future<List<Map<String, dynamic>>> getAssets() async {
    final assets = [
      {
        "symbol": "BTC",
        "name": "Bitcoin",
        "logoUrl": "assets/btc.png",
        "marketCap": 523000000000,
        "currentPrice": 27000.50,
      },
      {
        "symbol": "ETH",
        "name": "Ethereum",
        "logoUrl": "assets/eth.png",
        "marketCap": 215000000000,
        "currentPrice": 1800.75,
      },
      {
        "symbol": "SOL",
        "name": "Solana",
        "logoUrl": "assets/sol.png",
        "marketCap": 9000000000,
        "currentPrice": 22.30,
      }
    ];
    return _withDelay(assets);
  }

  // Fetch market data for charts (large dataset)
  Future<List<Map<String, dynamic>>> getMarketData(String assetSymbol) async {
    final random = Random();
    final now = DateTime.now();

    // Generate 100 data points for the chart
    final marketData = List.generate(100, (index) {
      final timestamp = now.subtract(Duration(minutes: index * 15));
      final open = random.nextDouble() * 100 + 25000; // Random open price
      final high = open + random.nextDouble() * 500; // Random high price
      final low = open - random.nextDouble() * 500; // Random low price
      final close =
          low + random.nextDouble() * (high - low); // Random close price
      final volume = random.nextInt(1000000); // Random volume

      return {
        
        "timestamp": timestamp.toIso8601String(),
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
      };
    });

    return _withDelay(marketData);
  }

  // Fetch trade history for a specific user
  Future<List<Map<String, dynamic>>> getTradeHistory2(String userId) async {
    final trades = [
      {
        "id": "t1",
        "orderId": "o1",
        "userId": "1",
        "assetSymbol": "BTC",
        "tradeType": "buy",
        "quantity": 0.5,
        "price": 26000.00,
        "timestamp": DateTime(2023, 10, 1, 12, 30).toIso8601String(),
      },
      {
        "id": "t2",
        "orderId": "o2",
        "userId": "1",
        "assetSymbol": "ETH",
        "tradeType": "sell",
        "quantity": 1.0,
        "price": 1850.00,
        "timestamp": DateTime(2023, 10, 2, 15, 45).toIso8601String(),
      }
    ];

    final userTrades = trades.where((t) => t["userId"] == userId).toList();
    return _withDelay(userTrades);
  }

  // Fetch order history for a specific user
  Future<List<Map<String, dynamic>>> getOrderHistory(String userId) async {
    final orders = [
      {
        "id": "o1",
        "userId": "1",
        "assetSymbol": "BTC",
        "orderType": "buy",
        "quantity": 0.5,
        "price": 26000.00,
        "timestamp": DateTime(2023, 10, 1, 12, 30).toIso8601String(),
        "status": "executed",
      },
      {
        "id": "o2",
        "userId": "1",
        "assetSymbol": "ETH",
        "orderType": "sell",
        "quantity": 1.0,
        "price": 1850.00,
        "timestamp": DateTime(2023, 10, 2, 15, 45).toIso8601String(),
        "status": "pending",
      }
    ];

    final userOrders = orders.where((o) => o["userId"] == userId).toList();
    return _withDelay(userOrders);
  }
}
