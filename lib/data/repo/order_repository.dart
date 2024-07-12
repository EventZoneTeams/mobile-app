import 'package:eventzone/data/model/order_model.dart';
import 'package:eventzone/data/model/secure_storage.dart';
import 'package:eventzone/data/remote_source/order_remote_data_source.dart';

class OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepository(this._remoteDataSource);

  Future<List<Order>> getMyOrders() async {
    final jwtToken = await StorageService.secureStorage.read(key: 'jwt');
    if (jwtToken != null) {
      return await _remoteDataSource.fetchOrders(jwtToken);
    } else {
      throw Exception("Your are not login or the session has expired! Please login again!");
    }
  }

  Future<Order> createOrder(Order order) async {
    final jwtToken = await StorageService.secureStorage.read(key: 'jwt');
    if (jwtToken != null) {
      return await _remoteDataSource.createOrder(jwtToken, order);
    } else {
      throw Exception('JWT token not found');
    }
  }  Future<Order> cancelOrder(int orderId) async {
    final jwtToken = await _getJwtToken(); // Replace with your token retrieval logic
    return _remoteDataSource.cancelOrder(jwtToken, orderId);
  }

  Future<String> _getJwtToken() async {
    return await StorageService.secureStorage.read(key: 'jwt') ?? '';
  }
  // Future<void> payOrder(int orderId) async {
  //   try {
  //     final userId = int.parse(
  //         await StorageService.secureStorage.read(key: 'userId') ?? '-1');
  //     await _remoteDataSource.payOrder(orderId, userId);
  //   }catch (e){
  //     rethrow;
  //   }
  // }
  Future<void> payOrder(int orderId) async {
      try {
    final jwtToken = await _getJwtToken(); // Replace with your token retrieval logic
    await _remoteDataSource.payOrder(orderId, jwtToken);
      }catch (e){
        rethrow;
      }
  }
}