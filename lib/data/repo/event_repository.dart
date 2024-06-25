import 'package:eventzone/data/model/category_model.dart';
import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/remote_source/event_remote_data_source.dart';

class EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;

  EventsRepository(this._remoteDataSource);

  Future<Map<String, dynamic>> fetchEvents({
    required int page,
    required int pageSize,
    String searchTerm = '',
    String? category,
    String? university,
  }) async {
    try {
      final data = await _remoteDataSource.fetchEvents(
        page,
        pageSize,
        searchTerm: searchTerm,
        category: category,
        university: university,
      );
      print('Fetched events for page $page: $data');
      return data;
    } catch (e, stackTrace) {
      print('Error fetching events for page $page: $e, Stacktrace: $stackTrace');
      rethrow;
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
  Future<List<CategoryModel>> fetchCategories() async {
    return await _remoteDataSource.fetchCategories();
  }
}