import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

import '../../screens/notification_screen.dart';
import '../../screens/settings_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showSettingButton;
  final bool showNotifications;
  final List<Widget>? actions;
  final Widget? userAvatar;
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.userAvatar,
    this.showSettingButton = true,
    this.showNotifications = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor, // Use your app's primary color
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        if (showNotifications)
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.whiteColor),
            onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NotificationsScreen();
                },
              ));
              print("Notifications tapped");
            },
          ),
        if (showSettingButton)
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.whiteColor),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SettingsScreen();
                },
              ));
              print("Settings tapped");
            },
          ),
        if (userAvatar != null) userAvatar!,
        SizedBox(width: 20)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
