import 'dart:convert';
import 'package:eventzone/data/model/account_model.dart';
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
  final String baseUrl = 'https://eventzone.azurewebsites.net/api/v1';

  // Singleton pattern for http.Client (optional)
  static final http.Client _client = http.Client();

  Future<Map<String, dynamic>> fetchEvents(int page, int pageSize) async {
    final response = await _client.get(
        Uri.parse('$baseUrl/events?page-number=$page&page-size=$pageSize')
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Validate response structure
      if (jsonData['success'] == null || jsonData['data'] == null) {
        throw ServerException('Invalid API response format');
      }

      if (jsonData['success'] == true) {
        final List<EventModel> events = (jsonData['data'] as List)
            .map((json) => EventModel.fromJson(json))
            .toList();
        print('Count event: ${events.length}');

        final PaginationModel pagination = PaginationModel.fromJson(jsonData);
        return {
          'events': events,
          'pagination': pagination,
        };
      } else {
        throw ServerException(jsonData['message'] ?? 'Failed to fetch events');
      }
    } else {
      // Handle specific HTTP error codes (optional)
      if (response.statusCode == 404) {
        throw NetworkException('Events not found');
      } else {
        throw NetworkException('Failed to load events (HTTP ${response.statusCode})');
      }
    }
  }

  Future<EventDetailModel> getEventById(int eventId) async {
    final url = Uri.parse('$baseUrl/events/$eventId');
    final response = await _client.get(url, headers: {'accept': '*/*'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      // Validate response structure
      if (jsonData['success'] == null || jsonData['data'] == null) {
        throw ServerException('Invalid API response format');
      }

      if (jsonData['success'] == true) {
        return EventDetailModel.fromJson(jsonData['data']);
      } else {
        throw ServerException(jsonData['message'] ?? 'Failed to get event');
      }
    } else {
      // Handle specific HTTP error codes (optional)
      if (response.statusCode == 404) {
        throw NetworkException('Event not found');
      } else {
        throw NetworkException('Failed to load event details (HTTP ${response.statusCode})');
      }
    }
  }
}