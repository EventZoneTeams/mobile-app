// order_provider.dart
import 'package:eventzone/data/model/order_model.dart';
import 'package:eventzone/data/repo/order_repository.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _repository;
  List<Order> _orders = [];
  String _errorMessage = '';

  OrderProvider(this._repository);

  List<Order> get orders => _orders;
  String get errorMessage => _errorMessage;

  Future<void> fetchOrders(int userId) async {
    try {
      _orders = await _repository.getOrdersByUserId(userId);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load orders: ${e.toString()}';
    }
    notifyListeners();
  }
}