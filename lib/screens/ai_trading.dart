import 'package:app/service/api.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import '../models/price_model.dart';
import '../widgets/charts/bot_chart.dart';

class TradingChart extends StatefulWidget {
  const TradingChart({super.key});

  @override
  TradingChartState createState() => TradingChartState();
}

class TradingChartState extends State<TradingChart> {
  List<PriceData> btcData = [];
  List<PriceData> ethData = [];
  List<PriceData> bnbData = [];
  late Timer _timer;
  ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    enableDoubleTapZooming: true,
    zoomMode: ZoomMode.xy,
  );

  @override
  void initState() {
    super.initState();
    loadInitialData();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) => updateLiveData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  Future<void> loadInitialData() async {
    List<PriceData> btc = await BinanceApi.fetchHistoricalData("BTC");
    List<PriceData> eth = await BinanceApi.fetchHistoricalData("ETH");
    List<PriceData> bnb = await BinanceApi.fetchHistoricalData("BNB");
    setState(() {
      btcData = btc;
      ethData = eth;
      bnbData = bnb;
    });
  }

  Future<void> updateLiveData() async {
    // PriceData? newData = await BinanceService.fetchMarketData("BTC");
    // if (newData != null) {
    //   setState(() {
    //     priceData.add(newData);
    //     if (priceData.length > 50) {
    //       priceData.removeAt(0);
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 800, // Set a large width to enable horizontal scrolling
        height: 500, // Fixed height for vertical scrolling
        child: CryptoPriceChart(
          zoomPanBehavior: zoomPanBehavior,
          ethData: ethData,
          bnbData: bnbData,
          btcData: btcData,
        ),
      ),
      // Your chart configuration her
    );
  }
}

class TradingBotScreen extends StatefulWidget {
  const TradingBotScreen({super.key});

  @override
  State<TradingBotScreen> createState() => _TradingBotScreenState();
}

class _TradingBotScreenState extends State<TradingBotScreen> {
  bool _isBotRunning = false;
  final int _openTradesCount = 5;
  final double _profitLossPercentage = 12.5;

  List<PriceData> priceData = [];

  late Timer _timer;
  ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
    enablePinching: false, 
    enablePanning: false,
    enableDoubleTapZooming: true, 
  );

  @override
  void initState() {
    super.initState();
    _fetchBitcoinPriceHistory(); 
    _timer = Timer.periodic(
        Duration(seconds: 5), (timer) => _fetchBitcoinPriceHistory());
  }

  void _fetchBitcoinPriceHistory() async {
    try {
      final data = await BinanceApi.fetchHistoricalData('BTC');

      setState(() {
        priceData = data;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'حالة البوت:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: _isBotRunning ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      _isBotRunning ? 'يعمل' : 'متوقف',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
          
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أداء البوت:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('عدد الصفقات المفتوحة:',
                        style: TextStyle(fontSize: 14)),
                    Text('${_openTradesCount}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('نسبة الربح/الخسارة:', style: TextStyle(fontSize: 14)),
                    Text('${_profitLossPercentage}%',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 16),
                Text('سجل التداول:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(height: 16),

            
            ElevatedButton.icon(
              onPressed: () {
     
              },
              icon: Icon(Icons.settings),
              label: Text('إعدادات متقدمة'),
            ),
            SizedBox(height: 16),

        

            SizedBox(height: 16),


            ExpansionTile(
              title: Text('استراتيجيات البوت',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                ListTile(
                  title: Text('Scalping'),
                  subtitle: Text('يفتح صفقات قصيرة جدًا ويغلقها بسرعة.'),
                ),
                ListTile(
                  title: Text('Grid Trading'),
                  subtitle:
                      Text('يضع أوامر شراء وبيع تلقائيًا بفواصل سعرية محددة.'),
                ),
                ListTile(
                  title: Text('Mean Reversion'),
                  subtitle: Text('يعتمد على أن السعر سيعود لمتوسطه.'),
                ),
                ListTile(
                  title: Text('Momentum Trading'),
                  subtitle:
                      Text('يفتح صفقات مع الاتجاه الصاعد أو الهابط القوي.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
