import 'package:eventzone/data/repo/watchlist_repository.dart';
import 'package:flutter/material.dart';

import 'package:eventzone/data/model/event_model.dart'; // Import your repository

class WatchlistProvider extends ChangeNotifier {
  final WatchlistRepository _repository;
  List<EventModel> _watchlistEvents = [];
  String _errorMessage = '';

  WatchlistProvider(this._repository);

  List<EventModel> get watchlistEvents => _watchlistEvents;
  String get errorMessage => _errorMessage;

  Future<void> fetchWatchlistEvents(int userId) async {
    try {
      _watchlistEvents = await _repository.getEventsByUserId(userId);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load watchlist events: ${e.toString()}';
    }
    notifyListeners();
  }
}