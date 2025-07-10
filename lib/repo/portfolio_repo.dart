import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../models/holding.dart';

void checkAuth() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("User not authenticated!");
  } else {
    print("Authenticated as: ${user.uid}");
  }
}

Future<void> fetchHoldings() async {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  if (userId.isEmpty) {
    print("User not authenticated");
    return;
  }

  CollectionReference holdingsRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('holdings');

  print("Fetching from: users/$userId/holdings"); // Debugging log

  try {
    QuerySnapshot snapshot = await holdingsRef.get();

    if (snapshot.docs.isEmpty) {
      print("No holdings found in Firestore!");
    } else {
      print("Holdings found: ${snapshot.docs.length}");
      for (var doc in snapshot.docs) {
        print("Holding: ${doc.data()}");
      }
    }
  } catch (e) {
    print("Firestore error: $e");
  }
}

class PortfolioRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<List<Currency>> getUserPortfolio() async {
    checkAuth();
    fetchHoldings();

    final user = _auth.currentUser;
    if (user == null) return [];

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('portfolio')
        .get();

    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return Currency(
        code: data['code'],
        name: data['name'],
        icon: Image.asset(data['icon']), // Load local asset
        priceHistory: List<double>.from(data['priceHistory']),
        currentAmount: data['currentAmount'].toDouble(),
        profit: data['profit'].toDouble(),
        tradeHistory: [], // Load trade history if needed
      );
    }).toList();
  }

  static Future<List<Holding>> getHoldings() async {
    final user = _auth.currentUser;
    print("Current user UID: ${user?.uid}");
    if (user == null) {
      print(" User not authenticated.");
      return [];
    }

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('holdings')
          .get();

      List<Holding> holdings = snapshot.docs.map((doc) {
        final data = doc.data();
        return Holding(
          name: data['name'],
          symbol: doc.id, // Document ID as symbol (BTC, ETH, etc.)
          quantity: (data['quantity'] as num).toDouble(),
          value: (data['value'] as num).toDouble(),
          percentage: (data['percentage'] as num).toDouble(),
          logoUrl: data['logoUrl'],
        );
      }).toList();

      return holdings;
    } catch (e) {
      print("Error fetching holdings: $e");
      return [];
    }
  }

  // Calculate total value dynamically
  static Future<double> getTotalValue() async {
    List<Holding> holdings = await getHoldings();
    double totalValue = 0.0;
    for (var holding in holdings) {
      totalValue += await holding.value; //  Wait for each value
    }
    return totalValue;
  }
}
