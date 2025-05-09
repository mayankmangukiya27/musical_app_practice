import 'package:flutter/material.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';

class CartProvider with ChangeNotifier {
  final List<Song> _cartItems = [];

  List<Song> get cartItems => _cartItems;

  void addToCart(Song song) {
    if (!_cartItems.any((item) => item.id == song.id)) {
      _cartItems.add(song);
      notifyListeners();
    }
  }

  void removeFromCart(Song song) {
    _cartItems.removeWhere((item) => item.id == song.id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
