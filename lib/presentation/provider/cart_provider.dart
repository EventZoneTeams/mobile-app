import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:flutter/material.dart';


class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {}; // Key is packageId

  Map<int, CartItem> get items => _items;

  void addToCart(EventPackageModel package, int quantity) {
    if (_items.containsKey(package.id)) {
      _items[package.id]!.quantity += quantity;
    } else {
      _items[package.id] = CartItem(package: package, quantity: quantity);
    }
    notifyListeners();
  }

  void removeFromCart(int packageId) {
    _items.remove(packageId);
    notifyListeners();
  }

  void updateQuantity(int packageId, int newQuantity) {
    if (_items.containsKey(packageId)) {
      _items[packageId]!.quantity = newQuantity;
      notifyListeners();
    }
  }

  double get totalPrice {
    return _items.values.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class CartItem {
  final EventPackageModel package;
  int quantity;

  CartItem({required this.package, required this.quantity});

  int get totalPrice => package.totalPrice * quantity;
}