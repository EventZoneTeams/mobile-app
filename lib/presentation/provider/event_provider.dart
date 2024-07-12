import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/model/category_model.dart';
import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/data/repo/event_repository.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  final EventsRepository _repository;
  final List<EventModel> _events = [];
  final List<EventModel> _cachedEvents = [];
  String _errorMessage = '';
  bool _isLoading = false;
  bool _hasMore = true;
  bool _error = false;
  int _currentPage = 1;
  final  int _pageSize = 3;
  PaginationModel _pagination =
  PaginationModel(currentPage: 0, pageSize: 0, totalCount: 0, totalPages: 0);
  String _searchTerm = '';
  String? _selectedCategory;
  String? _selectedUniversity;

  EventsProvider(this._repository);

  List<EventModel> get events => _events;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get error => _error;

  Future<void> loadInitialEvents({
    String searchTerm = '',
    String? category,
    String? university,
  }) async {
    _searchTerm = searchTerm;
    _selectedCategory = category;
    _selectedUniversity = university;
    _events.clear();
    _cachedEvents.clear();
    _currentPage = 1;
    _hasMore = true;
    if (_cachedEvents.isEmpty) {
      await fetchEvents(
        searchTerm: searchTerm,
        category: category,
        university: university,
      );
      _cachedEvents.addAll(_events);
    } else {
      _events.addAll(_cachedEvents);
      // Update currentPage and hasMore based on cache
      _currentPage = (_cachedEvents.length / _pageSize).ceil();
      _hasMore = _currentPage < _pagination.totalPages;
      notifyListeners();
    }
  }

  Future<void> fetchEvents({
    String searchTerm = '',
    String? category,
    String? university,
  }) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = '';
    _error = false;
    notifyListeners();

    try {
      final data = await _repository.fetchEvents(
        page: _currentPage,
        pageSize: _pageSize,
        searchTerm: searchTerm,
        category: category,
        university: university,
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

  Future<void> fetchMoreEvents({
    String searchTerm = '',
    String? category,
    String? university,
  }) async {
    if (_isLoading || !_hasMore) return;
    _currentPage++;
    // Adjust currentPage if it's lower than the highest fetched page

    try {
      await fetchEvents(
        searchTerm: searchTerm,
        category: category,
        university: university,
      );
    } catch (e) {
      _errorMessage = 'Failed to load more events: ${e.toString()}';
      _error = true;
      notifyListeners();
    }
  }
  Future<List<CategoryModel>> fetchCategories() async {
    return await _repository.fetchCategories();
  }

  List<EventPackageModel> _eventPackages = [];
  bool _isLoadingPackages = false;
  String _packageErrorMessage = '';

  List<EventPackageModel> get eventPackages => _eventPackages;
  bool get isLoadingPackages => _isLoadingPackages;
  String get packageErrorMessage => _packageErrorMessage;

  Future<void> fetchEventPackagesForEvent(int eventId) async {
    _isLoadingPackages = true;
    _packageErrorMessage = '';
    notifyListeners();

    try {
      _eventPackages = await _repository.fetchEventPackages(eventId);
    } catch (e) {
      _packageErrorMessage = 'Failed to load event packages: ${e.toString()}';
    } finally {
      _isLoadingPackages = false;
      notifyListeners();
    }
  }
}