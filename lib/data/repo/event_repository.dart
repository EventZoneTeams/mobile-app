import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/data/remote_source/event_remote_data_source.dart';

class EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;
  List<EventModel>? _cachedEvents; // Cache for events
  DateTime? _lastFetchTime; // To track cache validity

  EventsRepository(this._remoteDataSource);

  Future<List<EventModel>> getEvents() async {
    // Check if cache is valid (e.g., fetched within the last hour)
    if (_cachedEvents != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) < const Duration(hours: 1)) {
      return _cachedEvents!; // Return cached events
    }

    // Fetch events from the remote data source
    try {
      final events = await _remoteDataSource.fetchEvents();

      // Update cache and last fetch time
      _cachedEvents = events;
      _lastFetchTime = DateTime.now();

      return events;
    } catch (e) {
      // Handle errors (you might want to log the error here)
      return []; // Return an empty list in case of an error
    }
  }

  Future<EventDetailModel> getEventById(int eventId) async {
    // (No caching for individual event details for now)
    return await _remoteDataSource.getEventById(eventId);
  }

  // Method to invalidate the cache (e.g., on refresh)
  void invalidateCache() {
    _cachedEvents = null;
    _lastFetchTime = null;
  }
}