import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> insertUser(String userId, Map<String, dynamic> userData) async {
    await usersCollection.doc(userId).set(userData);
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    DocumentSnapshot doc = await usersCollection.doc(userId).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  Future<void> updateUser(
      String userId, Map<String, dynamic> newUserData) async {
    await usersCollection.doc(userId).update(newUserData);
  }

  Future<void> deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
  }
}

class WalletRepository {
  final CollectionReference walletsCollection =
      FirebaseFirestore.instance.collection('wallets');

  Future<void> insertWallet(
      String walletId, Map<String, dynamic> walletData) async {
    await walletsCollection.doc(walletId).set(walletData);
  }

  Future<Map<String, dynamic>?> getWallet(String walletId) async {
    DocumentSnapshot doc = await walletsCollection.doc(walletId).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  Future<void> updateWallet(
      String walletId, Map<String, dynamic> updatedData) async {
    await walletsCollection.doc(walletId).update(updatedData);
  }

  Future<void> deleteWallet(String walletId) async {
    await walletsCollection.doc(walletId).delete();
  }
}

class TransactionRepository {
  final CollectionReference transactionsCollection =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> insertTransaction(Map<String, dynamic> transaction) async {
    await transactionsCollection.add(transaction);
  }

  Future<List<Map<String, dynamic>>> getTransactions(String walletId) async {
    QuerySnapshot snapshot = await transactionsCollection
        .where('walletId', isEqualTo: walletId)
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> updateTransaction(
      String transactionId, Map<String, dynamic> newTransaction) async {
    await transactionsCollection.doc(transactionId).update(newTransaction);
  }

  Future<void> deleteTransaction(String transactionId) async {
    await transactionsCollection.doc(transactionId).delete();
  }
}

class HoldingRepository {
  final CollectionReference holdingsCollection =
      FirebaseFirestore.instance.collection('holdings');

  Future<void> insertHolding(Map<String, dynamic> holding) async {
    await holdingsCollection.add(holding);
  }

  Future<List<Map<String, dynamic>>> getHoldings(String walletId) async {
    QuerySnapshot snapshot =
        await holdingsCollection.where('walletId', isEqualTo: walletId).get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> updateHolding(
      String holdingId, Map<String, dynamic> newHolding) async {
    await holdingsCollection.doc(holdingId).update(newHolding);
  }

  Future<void> deleteHolding(String holdingId) async {
    await holdingsCollection.doc(holdingId).delete();
  }
}
