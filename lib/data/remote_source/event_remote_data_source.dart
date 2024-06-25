import 'dart:convert';
import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/model/category_model.dart';
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

  Future<Map<String, dynamic>> fetchEvents(
      int page,
      int pageSize, {
        String searchTerm = '', // Add searchTerm parameter
        String? category, // Add category filter (optional)
        String? university, // Add university filter (optional)
      }) async {
    // Construct the API URL with query parameters
    String url = '$baseUrl/events?page-number=$page&page-size=$pageSize';

    if (searchTerm.isNotEmpty) {
      url += '&search-term=$searchTerm';
    }
    if (category != null) {
      url += '&event-category-id=$category'; // Adjust parameter name if needed
    }
    if (university != null) {
      // Add university filter to URL (adjust parameter name as needed)
    }

    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

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
      if (response.statusCode == 404) {
        throw NetworkException('Events not found');
      } else {
        throw NetworkException(
            'Failed to load events (HTTP ${response.statusCode})');
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

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/event-categories'),
      headers: {'accept': 'text/plain'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData['success'] == true) {
        final List<CategoryModel> categories = (jsonData['data'] as List)
            .map((json) => CategoryModel.fromJson(json))
            .toList();
        return categories;
      } else {
        throw ServerException(
            jsonData['message'] ?? 'Failed to fetch categories');
      }
    } else {
      throw NetworkException(
          'Failed to load categories (HTTP ${response.statusCode})');
    }
  }
}
