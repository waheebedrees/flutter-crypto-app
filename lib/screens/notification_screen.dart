import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../repo/notification_rop.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  void _fetchNotifications() async {
    List<NotificationModel> fetchedNotifications =
        await NotificationRepository.getUserNotifications();
    setState(() {
      notifications = fetchedNotifications;
    });
  }

  void _markAsRead(String id) async {
    await NotificationRepository.markAsRead(id);
    _fetchNotifications(); // Refresh UI
  }

  void _deleteNotification(String id) async {
    await NotificationRepository.deleteNotification(id);
    _fetchNotifications(); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(
                notification.read
                    ? Icons.notifications_none
                    : Icons.notifications_active,
                color: notification.read ? Colors.grey : Colors.blue),
            title: Text(notification.title,
                style: TextStyle(
                    fontWeight: notification.read
                        ? FontWeight.normal
                        : FontWeight.bold)),
            subtitle: Text(notification.message),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.done, color: Colors.green),
                  onPressed: () => _markAsRead(notification.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteNotification(notification.id),
                ),
              ],
            ),
          );
        },
      
      ),
      
    );
  }
}
