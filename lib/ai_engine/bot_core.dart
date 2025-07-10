import 'component/arbitrage.dart';
import 'component/grid_trading.dart';
import 'component/mean_reversion.dart';
import 'component/momentum_trading.dart';
import 'component/scalping.dart';
import 'component/strategies_interface.dart';

class BotCore {
  final Map<String, TradingStrategy> strategies = {
    'Scalping': ScalpingStrategy(),
    'Grid Trading': GridTradingStrategy(),
    'Mean Reversion': MeanReversionStrategy(),
    'Momentum Trading': MomentumStrategy(),
    'Arbitrage': ArbitrageStrategy(),
  };

  TradingStrategy? getStrategy(String strategyName) {
    return strategies[strategyName];
  }

  /// Execute strategy asynchronously with real market data
  Future<Map<String, dynamic>> executeStrategy(
      String strategyName, String symbol) async {
    TradingStrategy? strategy = getStrategy(strategyName);
    if (strategy != null) {
      return await strategy.execute(symbol);
    } else {
      return {"action": "hold", "amount": 0.0};
    }
  }
}
