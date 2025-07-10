import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/crypto_model.dart';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('walletium.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        profileImageUrl TEXT,
        preferences TEXT
      )
    ''');
    await db.execute('''
          CREATE TABLE portfolio (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            asset TEXT,
            balance REAL
          )
        ''');

    await db.execute(
      'CREATE TABLE cryptocurrencies(id INTEGER PRIMARY KEY, name TEXT, code TEXT, usdAmount REAL, currentAmount REAL)',
    );
    await db.execute('''
      CREATE TABLE wallets (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        balance REAL NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE holdings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        walletId TEXT NOT NULL,
        assetSymbol TEXT NOT NULL,
        quantity REAL NOT NULL,
        averagePrice REAL NOT NULL,
        currentPrice REAL NOT NULL,
        FOREIGN KEY (walletId) REFERENCES wallets (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        walletId TEXT NOT NULL,
        assetSymbol TEXT NOT NULL,
        orderType TEXT NOT NULL,
        quantity REAL NOT NULL,
        price REAL NOT NULL,
        timestamp TEXT NOT NULL,
        status TEXT NOT NULL,
        filledQuantity REAL DEFAULT 0,
        expirationDate TEXT,
        FOREIGN KEY (walletId) REFERENCES wallets (id) ON DELETE CASCADE
      )
    ''');
  }
}

class UserData {
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('users', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(String userId, Map<String, dynamic> newUser) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('users', newUser, where: 'id = ?', whereArgs: [userId]);
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final db = await DatabaseHelper.instance.database;
    final result =
        await db.query('users', where: 'id = ?', whereArgs: [userId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteUser(String userId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('users', where: 'id = ?', whereArgs: [userId]);
  }
}

class WalletData {
  Future<void> insertWallet(Map<String, dynamic> wallet) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('wallets', wallet,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getWallet(String userId) async {
    final db = await DatabaseHelper.instance.database;
    final result =
        await db.query('wallets', where: 'userId = ?', whereArgs: [userId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> updateWalletBalance(String walletId, double newBalance) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'wallets',
      {'balance': newBalance},
      where: 'id = ?',
      whereArgs: [walletId],
    );
  }

  Future<void> updateWallet(
      String walletId, Map<String, dynamic> newWallet) async {
    final db = await DatabaseHelper.instance.database;
    await db
        .update('wallets', newWallet, where: 'id = ?', whereArgs: [walletId]);
  }

  Future<void> deleteWallet(String walletId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('wallets', where: 'id = ?', whereArgs: [walletId]);
  }
}

class HoldingData {
  Future<void> insertHolding(Map<String, dynamic> holding) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('holdings', holding,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getHoldings(String walletId) async {
    final db = await DatabaseHelper.instance.database;
    return await db
        .query('holdings', where: 'walletId = ?', whereArgs: [walletId]);
  }

  Future<void> updateHolding(
      int holdingId, Map<String, dynamic> newHolding) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('holdings', newHolding,
        where: 'id = ?', whereArgs: [holdingId]);
  }

  Future<void> deleteHolding(int holdingId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('holdings', where: 'id = ?', whereArgs: [holdingId]);
  }
}

class TransactionData {
  Future<void> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('transactions', transaction,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getTransactions(String walletId) async {
    final db = await DatabaseHelper.instance.database;
    return await db
        .query('transactions', where: 'walletId = ?', whereArgs: [walletId]);
  }

  Future<void> updateTransaction(
      String transactionId, Map<String, dynamic> newTransaction) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('transactions', newTransaction,
        where: 'id = ?', whereArgs: [transactionId]);
  }

  Future<void> deleteTransaction(String transactionId) async {
    final db = await DatabaseHelper.instance.database;
    await db
        .delete('transactions', where: 'id = ?', whereArgs: [transactionId]);
  }
}

Future<void> insertAsset(String asset, double balance) async {
  final db = await DatabaseHelper.instance.database;
  await db.insert('portfolio', {"asset": asset, "balance": balance});
}

Future<List<Map<String, dynamic>>> getPortfolio() async {
  final db = await DatabaseHelper.instance.database;
  return await db.query('portfolio');
}

Future<void> insertCryptocurrency(Currency currency) async {
  final db = await DatabaseHelper.instance.database;
  await db.insert(
    'cryptocurrencies',
    currency.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Currency>> getCryptocurrencies() async {
  final db = await DatabaseHelper.instance.database;
  final List<Map<String, dynamic>> maps = await db.query('cryptocurrencies');

  return List.generate(maps.length, (i) {
    return Currency.fromMap(maps[i]);
  });
}

Future<void> deleteCryptocurrency(int id) async {
  final db = await DatabaseHelper.instance.database;
  await db.delete(
    'cryptocurrencies',
    where: 'id = ?',
    whereArgs: [id],
  );
}
