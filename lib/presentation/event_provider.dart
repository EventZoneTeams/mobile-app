import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/data/repo/event_repository.dart';
import 'package:flutter/material.dart';


class EventsProvider extends ChangeNotifier {
  final EventsRepository _repository;
  final List<EventModel> _events = [];
  final List<EventModel> _cachedEvents = []; // Cache for events
  String _errorMessage = '';
  bool _isLoading = false;
  bool _hasMore = true;
  bool _error = false;
  int _currentPage = 1;
  final int _pageSize = 10;
  PaginationModel _pagination = PaginationModel(currentPage: 0, pageSize: 0, totalCount: 0, totalPages: 0);

  EventsProvider(this._repository);

  List<EventModel> get events => _events;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get error => _error;


  Future<void> loadInitialEvents() async {
    _events.clear();
    _cachedEvents.clear();
    _currentPage = 1;
    _hasMore = true;
    if (_cachedEvents.isEmpty) {
      await fetchEvents();
      _cachedEvents.addAll(_events);
    } else {
      _events.addAll(_cachedEvents);
      // Update currentPage and hasMore based on cache
      _currentPage = (_cachedEvents.length / _pageSize).ceil();
      _hasMore = _currentPage < _pagination.totalPages;
      notifyListeners();
    }
  }

  Future<void> fetchEvents() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = '';
    _error = false;
    notifyListeners();

    try {
      final data = await _repository.fetchEvents(
        page: _currentPage,
        pageSize: _pageSize,
      );

      final newEvents = data['events'];
      if (newEvents.isNotEmpty) {
        _events.addAll(newEvents);
        _cachedEvents.addAll(newEvents);
        notifyListeners();
      }

      _pagination = data['pagination'];
      _hasMore = _currentPage < _pagination.totalPages;
    } catch (e) {
      _errorMessage = 'Failed to load events: ${e.toString()}';
      _error = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreEvents() async {
    if (_isLoading || !_hasMore) return;
    _currentPage++;
    // Adjust currentPage if it's lower than the highest fetched page

    try {
      await fetchEvents();
    } catch (e) {
      _errorMessage = 'Failed to load more events: ${e.toString()}';
      _error = true;
      notifyListeners();
    }
  }
}