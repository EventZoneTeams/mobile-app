import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:eventzone/data/model/event_model.dart';

class WatchlistRemoteDataSource {
  final String baseUrl = 'https://ez-api.azurewebsites.net/api/v1/'; // Replace with your API base URL

  Future<List<EventModel>> getWatchlistEventsByUserId(int userId) async {
    // final url = Uri.parse('$apiBaseUrl/watchlist?userId=$userId');
    final url = Uri.parse('$baseUrl/events');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((eventJson) => EventModel.fromJson(eventJson)).toList();
    } else {
      throw Exception('Failed to load watchlist events');
    }
  }

// ... (Other methods for adding/removing events from watchlist, etc.)
}