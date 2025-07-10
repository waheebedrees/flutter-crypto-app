import 'package:app/screens/transaction_screen.dart';
import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

import '../../screens/notification_screen.dart';
import '../../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark
        ? AppColors.whiteColor
        : AppColors.mainTextColor1;

    return Drawer(
      child: Container(
        color: theme.drawerTheme.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Waheeb",
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/sobGOGdark.png'),
                        backgroundColor: AppColors.accentColor,
                        radius: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // drawerItem(context, Icons.home, "Home", const HomeScreen()),
            // drawerItem(context, Icons.account_balance_wallet, "Wallet",
            //     const WalletScreen()),
            drawerItem(context, Icons.swap_horiz, "Transactions",
                TransactionsScreen()),
            drawerItem(context, Icons.notifications, "Notifications",
                const NotificationsScreen()),
            drawerItem(
                context, Icons.settings, "Settings", const SettingsScreen()),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),

            // Logout
            ListTile(
              leading: Icon(Icons.logout, color: textColor),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                print("User logged out");
                // Add logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method for Drawer Items
  Widget drawerItem(
      BuildContext context, IconData icon, String title, Widget screen) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark
        ? AppColors.whiteColor
        : AppColors.mainTextColor1;

    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer before navigation
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
