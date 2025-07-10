import 'package:flutter/material.dart';
import 'dart:ui';

import '../utils/some_functions.dart';
import '../widgets/components/my_drawer.dart';
import '../widgets/components/my_appbar.dart';
import '../utils/style.dart';
import 'ai_trading.dart';
import 'settings/bot_screen_settings.dart';
import 'chat_screen.dart';
import 'dashboard_screen.dart';
import 'portfolio_screen.dart';
import 'trading_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  final List<Widget> _screens = [
    PortfolioScreen(),
    DashboardScreen(),
    TradingScreen(),
    TradingBotScreen(),
    TradingBotSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Ask AI'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatScreen();
            },
          ));
        },
      ),
      drawer: AppDrawer(),
      appBar: CustomAppBar(
        userAvatar: CircleAvatar(
          backgroundImage: const AssetImage('assets/sobGOGdark.png'),
          backgroundColor: AppColors.accentColor,
          radius: 15,
        ),
        title: getTitle(_selectedIndex),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBlurredBottomNavBar(),
    );
  }

  Widget _buildBlurredBottomNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor.withOpacity(0.8),
            border: Border.all(color: Colors.white, width: 0),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
            ),
          ),
          height: 80.0,
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.pie_chart, "Portfolio", 0),
              _buildNavItem(Icons.swap_horiz, "Market", 1),
              _buildNavItem(Icons.swap_horiz, "Trade", 2),
              _buildNavItem(Icons.history, "Bot", 3),
              _buildNavItem(Icons.history, "Settings", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return Tooltip(
      message: label,
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 30),
            Text(
              label,
              style:
                  isSelected ? GlobalStyle.textH0White : GlobalStyle.textH0Grey,
            ),
          ],
        ),
      ),
    );
  }
}
