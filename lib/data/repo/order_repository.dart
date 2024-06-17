// order_repository.dart

import 'package:eventzone/data/remote_source/order_remote_datasouce.dart';

import 'package:eventzone/data/model/order_model.dart';

class OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepository(this._remoteDataSource);
  Future<List<Order>> getOrdersByUserId(int userId) async {
    return await _remoteDataSource.getOrdersByUserId(userId);
  }
}