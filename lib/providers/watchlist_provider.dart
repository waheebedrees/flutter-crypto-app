import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistProvider with ChangeNotifier {
  List<String> _watchlist = [];

  List<String> get watchlist => _watchlist;

  void addToWatchlist(String symbol) {
    if (!_watchlist.contains(symbol)) {
      _watchlist.add(symbol);
      notifyListeners();
      _saveWatchlist();
    }
  }

  void removeFromWatchlist(String symbol) {
    _watchlist.remove(symbol);
    notifyListeners();
    _saveWatchlist();
  }

  Future<void> loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    _watchlist = prefs.getStringList('watchlist') ?? [];
    notifyListeners();
  }

  Future<void> _saveWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('watchlist', _watchlist);
  }
}
