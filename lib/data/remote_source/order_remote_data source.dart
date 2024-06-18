import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:eventzone/data/model/order_model.dart';

class OrderRemoteDataSource {
  final String baseUrl = 'https://eventzone.azurewebsites.net/api/v1/'; // Replace with your actual API base URL

  Future<List<Order>> getOrdersByUserId(int userId) async {
    final url = Uri.parse('$baseUrl/orders?userId=$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((orderJson) => Order.fromJson(orderJson)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}