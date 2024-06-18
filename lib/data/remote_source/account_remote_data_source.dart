import 'dart:convert';
import 'package:eventzone/data/model/account_model.dart';
import 'package:http/http.dart' as http;

class AccountRemoteDataSource {
  final String baseUrl = 'https://eventzone.azurewebsites.net/api/v1';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  Future<AccountModel> getAccountDetails(String jwtToken) async {
    final url = Uri.parse('$baseUrl/users/me');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $jwtToken'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      return AccountModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch account details: ${response.statusCode}');
    }
  }

  Future<void> register(RegisterAccountModel account) async {
    final url = Uri.parse('$baseUrl/users/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': account.email,
      'password': account.password,
      // Assuming your AccountModel has a password field
      'full-name': account.fullName,
      'dob': account.dob,
      // Format DateTime to ISO 8601
      'gender': account.gender,
      'image': account.image,
      'university': account.university,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Registration successful (you might want to parse the response for confirmation)
      print('Registration successful');
    } else {
      // Handle registration errors
      final jsonMap = jsonDecode(response.body);
      final message = jsonMap['message'] as String? ?? 'Registration failed';
      throw Exception(message);
    }
  }
// Add other API interaction methods as needed
// ...
}