import 'dart:convert';
import 'package:eventzone/data/model/account_model.dart';
import 'package:http/http.dart' as http;

class AccountRemoteDataSource {
  final String baseUrl = 'https://ez-api.azurewebsites.net/api/v1';
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return json;
    } else {
      throw Exception('Failed to login: ${json['message']}');
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
      // Fetch wallets for the user
      final walletResponse = await http.get(
          Uri.parse('$baseUrl/wallets'),
          headers: headers
      );
      final walletJson = jsonDecode(walletResponse.body);
      if (walletResponse.statusCode == 200) {
        final personalWallet = (walletJson['data'] as List)
            .firstWhere((wallet) => wallet['wallet-type'] == 'PERSONAL', orElse: () => null);

        double personalBalance = 0.0;
        if (personalWallet != null) {
          personalBalance = (personalWallet['balance'] as num).toDouble();
        }

        return AccountModel.fromJson(jsonMap['data'], personalBalance);
      } else {
        throw Exception('Failed to fetch wallets! ${walletJson['message']}');
      }
    } else {
      throw Exception('Fail getting account information!');
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
      // 'image': account.image
      'image': 'a',
      'university': account.university,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Registration successful (you might want to parse the response for confirmation)
    } else {
      // Handle registration errors
      final jsonMap = jsonDecode(response.body);
      final message = jsonMap['message'] as String? ?? 'Registration failed';
      throw Exception(message);
    }
  }

  Future<List<UniversityModel>> getUniversities() async {
    // Replace with actual API call when available
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    return universityList; // Return the list of UniversityModel objects
  }
  Future<String?> createTransaction(String jwtToken, int amount) async {
    final url = Uri.parse('$baseUrl/wallets/transactions');
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $jwtToken',
      'Content-Type': 'application/json' // Add this lin
    };
    final body = jsonEncode({'amount': amount});
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        return jsonResponse['data'] as String? ?? ''; // Extract payment URL from 'data'
      } else {
        throw Exception(jsonResponse['message'] as String? ?? 'Transaction failed');
      }
    } else {
      throw Exception('Failed to create transaction: ${response.statusCode}');
    }
  }
// Add other API interaction methods as needed
// ...
}// Temporary University Model
class UniversityModel {
  final String name;
  final String code;

  UniversityModel(this.name, this.code);
}

// Sample list of universities (replace with your actual data)
final List<UniversityModel> universityList = [
  UniversityModel('FPT University', 'FPTU'),
  UniversityModel('University of Science, VNU-HCM', 'VNU-US'),
  UniversityModel('University of Technology, VNU-HCM', 'VNU-UT'),
  UniversityModel('University of Social Sciences and Humanities, VNU-HCM', 'VNU-USH'),
  UniversityModel('University of Economics and Law, VNU-HCM', 'VNU-UEL'),
  UniversityModel('University of Information Technology, VNU-HCM', 'VNU-UIT'),
  UniversityModel('International University, VNU-HCM', 'VNU-IU'),
  UniversityModel('Ton Duc Thang University', 'TDTU'),
  UniversityModel('Ho Chi Minh City University of Technology', 'HUTECH'),
  UniversityModel('Ho Chi Minh City University of Industry', 'IUH'),
  UniversityModel('Ho Chi Minh City University of Economics and Finance', 'UEF'),
  UniversityModel('Ho Chi Minh City University of Architecture', 'UAH'),
  UniversityModel('Ho Chi Minh City University of Fine Arts', 'HCMUFA'),
  UniversityModel('Ho Chi Minh City University of Food Industry', 'HUFI'),
  UniversityModel('Ho Chi Minh City University of Transport', 'HUT'),
  UniversityModel('Ho Chi Minh City University of Agriculture and Forestry', 'HUAF'),
  UniversityModel('Ho Chi Minh City University of Law', 'HUL'),
  UniversityModel('Ho Chi Minh City University of Medicine and Pharmacy', 'HUMP'),
  UniversityModel('Ho Chi Minh City University of Sports and Physical Education', 'HUSPE'),
  UniversityModel('Ho Chi Minh City Open University', 'HCMOU'),
  UniversityModel('Van Lang University', 'VLU'),
  UniversityModel('Hong Bang International University', 'HIU'),
  UniversityModel('RMIT University Vietnam', 'RMIT'),
  UniversityModel('Nguyen Tat Thanh University', 'NTTU'),
  UniversityModel('Hoa Sen University', 'HSU'),
  UniversityModel('Sai Gon University', 'SGU'),
  UniversityModel('University of Finance - Marketing', 'UFM'),
  UniversityModel('Banking University Ho Chi Minh City', 'BUH'),
  UniversityModel('University of Foreign Languages - Information Technology', 'UFLIT'),
  UniversityModel('HCMC University of Education', 'HCMUE'),
  UniversityModel('Vietnam National University of Agriculture', 'VNUA'),
  UniversityModel('University of Economics Ho Chi Minh City', 'UEH'),
  UniversityModel('Lac Hong University', 'LHU'),
  UniversityModel('Sai Gon Technology University', 'STU'),
  UniversityModel('People\'s Security University of Ho Chi Minh City', 'PSUH'),
  UniversityModel('Thu Duc University', 'TDU'),
  UniversityModel('University of Labor and Social Affairs', 'ULSA'),
  UniversityModel('Greenwich University (Vietnam)', 'GUV'),
  UniversityModel('The University of Hawaii System', 'UHS'),
  UniversityModel('The American University of Vietnam', 'AUV'),
  UniversityModel('Western Sydney University (Vietnam)', 'WSUV'),
  UniversityModel('Curtin University (Vietnam)', 'CUV'),
  UniversityModel('James Cook University (Singapore Campus)', 'JCUSC'),
  UniversityModel('Vietnam Maritime University', 'VMU'),
  UniversityModel('Ho Chi Minh City University of Natural Resources and Environment', 'HCMUNRE'),
  UniversityModel('Ho Chi Minh City University of Technical Education', 'HCMUTE'),
  UniversityModel('Ho Chi Minh City University of Foreign Trade', 'HUFT'),
  UniversityModel('Ho Chi Minh City University of Banking', 'HUB')
];

// Convert UniversityModel to a different model object (example)
class UniversityDisplayItem {
  final String displayName;
  final String shortCode;

  UniversityDisplayItem({required this.displayName, required this.shortCode});
}

// Extension method to convert UniversityModel to UniversityDisplayItem
extension UniversityModelExtensions on UniversityModel {
  UniversityDisplayItem toDisplayItem() {
    return UniversityDisplayItem(
      displayName: name,
      shortCode: '($code)',
    );
  }
}

// Usage:
final List<UniversityDisplayItem> displayItems =
universityList.map((uni) => uni.toDisplayItem()).toList();