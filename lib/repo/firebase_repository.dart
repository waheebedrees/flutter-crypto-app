import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionRepository {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> saveTransaction({
    required String coin,
    required String amountText,
    required String type,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      print("User not authenticated.");
      return;
    }

    if (coin.isEmpty) {
      print("Please enter a coin name.");
      return;
    }
    if (amountText.isEmpty) {
      print("Please enter an amount.");
      return;
    }

    // Validate and parse amount
    double? amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      print("Invalid amount. Please enter a valid positive number.");
      return;
    }

    if (type.isEmpty || !(type == "buy" || type == "sell")) {
      print("Invalid transaction type. Must be 'buy' or 'sell'.");
      return;
    }

    // Create transaction data
    final transactionData = {
      'coin': coin,
      'amount': amount,
      'type': type,
      'timestamp': FieldValue.serverTimestamp(),
      'userId': user.uid,
    };

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('transactions')
          .add(transactionData);
      print("Transaction added successfully!");
    } catch (e) {
      print("Failed to add transaction: $e");
    }
  }

  // Fetch transactions for the current user
  Stream<QuerySnapshot> getTransactions() {
    final user = _auth.currentUser;
    if (user == null) {
      print("User not authenticated.");
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
