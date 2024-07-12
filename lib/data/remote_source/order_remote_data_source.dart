import 'dart:convert';

import 'package:eventzone/data/model/order_model.dart';
import 'package:http/http.dart' as http;
// ... other imports

class OrderRemoteDataSource {
  final String baseUrl = 'https://ez-api.azurewebsites.net/api/v1';


  Future<List<Order>> fetchOrders(String jwtToken) async {
    final url = Uri.parse('$baseUrl/users/me/event-orders'); // Adjust endpoint if needed
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $jwtToken',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final orderList = (jsonData['data'] as List<dynamic>); // Access the 'data' field
      return orderList.map((orderJson) => Order.fromJson(orderJson)).toList();
    } else {
      throw Exception('Failed to load orders: ${response.statusCode}');
    }
  }

  Future<Order> createOrder(String jwtToken, Order order) async {
    final url = Uri.parse('$baseUrl/event-orders');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
      'accept': 'text/plain',
    };
    final body = json.encode(order.toJson());
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Order.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to create order: ${response.statusCode}');
    }
  } Future<Order> cancelOrder(String jwtToken, int orderId) async {
    final url = Uri.parse('$baseUrl/event-orders/$orderId');
    final headers = {
      'accept': 'text/plain',
      'Authorization': 'Bearer $jwtToken',
      'Content-Type': 'multipart/form-data', // Important for form data
    };
    final request = http.MultipartRequest('PUT', url);
    request.headers.addAll(headers);
    request.fields['eventOrderStatusEnums'] = 'CANCELLED'; // Set the status

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Order.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to cancel order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error cancelling order: $e');
      rethrow;
    }
  }
  // Future<void> payOrder(int orderId, int userId) async {
  //   final url = Uri.parse('https://ez-api.azurewebsites.net/api/v1/payment/event-orders/$orderId?userId=$userId');
  //   final response = await http.post(url);
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to pay order');
  //   }
  // }
  Future<void> payOrder(int orderId, String jwtToken) async {
    final url = Uri.parse('https://ez-api.azurewebsites.net/api/v1/payment/event-orders/$orderId');
    final headers = {
      'Authorization': 'Bearer $jwtToken', // Add JWT token to Authorization header
    };
    final response = await http.post(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to pay order');
    }
  }
}