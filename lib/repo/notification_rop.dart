import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> addNotification(NotificationModel notification) async {
    await _firestore
        .collection('users')
        .doc(notification.userId)
        .collection('notifications')
        .doc(notification.id)
        .set(notification.toJson());
  }

  static Future<List<NotificationModel>> getUserNotifications() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return NotificationModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  static Future<void> markAsRead(String notificationId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .doc(notificationId)
        .update({'read': true});
  }

  static Future<void> deleteNotification(String notificationId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .doc(notificationId)
        .delete();
  }
}
