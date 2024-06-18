import 'package:flutter/material.dart';
import 'package:eventzone/data/repo/event_repository.dart';
import 'package:eventzone/data/model/event_model.dart';

class EventsProvider extends ChangeNotifier {
  final EventsRepository _repository;
  final List<EventModel> _events = [];
  String _errorMessage = '';
  bool _isLoading = false;
  bool _hasMore = true; // Flag to indicate if there are more events to fetch

  EventsProvider(this._repository);

  List<EventModel> get events => _events;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchEvents() async {
    if (_isLoading || !_hasMore) return; // Prevent fetching if already loading or no more events

    try {
      _isLoading = true;
      notifyListeners();

      final newEvents = await _repository.getEvents(); // Assuming your repository handles pagination
      _events.addAll(newEvents);
      _errorMessage = '';

      // Check if there are more events to fetch (you'll need to implement this logic in your repository)
      _hasMore = newEvents.isNotEmpty;
    } catch (e) {
      _errorMessage = 'Failed to load events: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreEvents() async {
    if (_isLoading || !_hasMore) return;

    await fetchEvents(); // Simply call fetchEvents to load the next batch
  }
}