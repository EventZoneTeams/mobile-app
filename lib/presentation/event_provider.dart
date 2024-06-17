import 'package:flutter/material.dart';
import 'package:eventzone/data/repo/event_repository.dart';
import 'package:eventzone/data/model/event_model.dart';

class EventsProvider extends ChangeNotifier {
  final EventsRepository _repository;
  List<EventModel> _events = [];
  String _errorMessage = '';
  bool _isLoading = false; // Add a loading state flag

  EventsProvider(this._repository);

  List<EventModel> get events => _events;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading; // Getter for loading state

  Future<void> fetchEvents() async {
    try {
      _isLoading = true; // Set loading state to true
      notifyListeners(); // Notify listeners about loading state change
      _events = await _repository.getEvents();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load events: ${e.toString()}';
    } finally {
      _isLoading = false; // Set loading state to false after fetching (or error)
      notifyListeners(); // Notify listeners about loading state change
    }
  }
}