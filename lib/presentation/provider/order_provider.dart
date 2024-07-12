import 'package:eventzone/data/model/order_model.dart';
import 'package:eventzone/data/repo/order_repository.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _repository;
  List<Order> _orders = [];
  String _errorMessage = '';
  bool _isLoading = false; // Add isLoading property

  OrderProvider(this._repository);

  List<Order> get orders => _orders;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading; // Getter for isLoading

  Future<void> fetchOrders() async {
    _isLoading = true; // Set isLoading to true before fetching
    notifyListeners();

    try {
      _orders = await _repository.getMyOrders();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load orders: ${e.toString()}';
    } finally {
      _isLoading = false; // Set isLoading to false after fetching, regardless of success or failure
      notifyListeners();
    }
  }

  Future<void> createOrder(Order order) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.createOrder(order);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to create order: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelOrder(int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.cancelOrder(orderId);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> payOrder(int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.payOrder(orderId);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}