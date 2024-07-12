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
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<EventDetailModel> getEventById(int eventId) async {
    try {
      return await _remoteDataSource.getEventById(eventId);
    } catch (e) {
      rethrow; // Rethrow the error to be handled by the caller
    }
  }
  Future<List<CategoryModel>> fetchCategories() async {
    return await _remoteDataSource.fetchCategories();
  }
  Future<List<EventPackageModel>> fetchEventPackages(int eventId) async {
    try {
      return await _remoteDataSource.fetchEventPackages(eventId);
    } catch (e) {
      rethrow; // Rethrow the error to be handled by the caller
    }
  }
}