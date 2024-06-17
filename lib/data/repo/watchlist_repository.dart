import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/data/remote_source/watchlist_remote_data_source.dart';

class WatchlistRepository {
  final WatchlistRemoteDataSource _remoteDataSource;

  WatchlistRepository(this._remoteDataSource);

  Future<List<EventModel>> getEventsByUserId(int userId) async {
    // return await _remoteDataSource.getWatchlistEventsByUserId(userId);
    try {
      final events = await _remoteDataSource.getWatchlistEventsByUserId(userId);
      return events; // Return an empty list if events is null
    } catch (e) {
      // Handle errors
      return []; // Return an empty list in case of an error
    }
  }

// ... (Other methods for managing the watchlist, delegating to _remoteDataSource)
}