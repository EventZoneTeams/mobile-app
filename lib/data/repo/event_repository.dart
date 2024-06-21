import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/remote_source/event_remote_data_source.dart';

class EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;

  EventsRepository(this._remoteDataSource);

  Future<Map<String, dynamic>> fetchEvents({required int page, required int pageSize}) async {
    try {
      final data = await _remoteDataSource.fetchEvents(page, pageSize);
      print('Fetched events for page $page: $data'); // Log response data
      return data;
    } catch (e, stackTrace) {
      print('Error fetching events for page $page: $e, Stacktrace: $stackTrace'); // Log detailed error
      rethrow; // Rethrow the exception
    }
  }

  Future<EventDetailModel> getEventById(int eventId) async {
    try {
      return await _remoteDataSource.getEventById(eventId);
    } catch (e) {
      print('Error fetching event details: $e'); // Log the error
      rethrow; // Rethrow the error to be handled by the caller
    }
  }
}