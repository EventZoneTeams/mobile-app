import 'dart:convert';
import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/model/event_model.dart';
import 'package:http/http.dart' as http;

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

class EventsRemoteDataSource {
  final String baseUrl = 'https://eventzone.azurewebsites.net/api/v1/';
  final http.Client _client = http.Client(); // Use a single client for connection pooling

  Future<List<EventModel>> fetchEvents() async {
    final response = await _client.get(Uri.parse('$baseUrl/events'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw NetworkException('Failed to load events (HTTP ${response.statusCode})');
    }
  }

  Future<EventDetailModel> getEventById(int eventId) async {
    final url = Uri.parse('$baseUrl/events/$eventId');
    final response = await _client.get(url, headers: {'accept': '*/*'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        return EventDetailModel.fromJson(jsonData['data']);
      } else {
        throw ServerException(jsonData['message'] ?? 'Failed to get event');
      }
    } else {
      throw NetworkException('Failed to load event details (HTTP ${response.statusCode})');
    }
  }

  // Remember to close the HTTP client when it's no longer needed
  void dispose() {
    _client.close();
  }
}