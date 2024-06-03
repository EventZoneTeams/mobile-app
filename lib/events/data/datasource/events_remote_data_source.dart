import 'package:dio/dio.dart';
import 'package:eventzone/core/data/error/exceptions.dart';
import 'package:eventzone/events/data/models/event_detail_model.dart';

import 'package:eventzone/core/data/network/api_constants.dart';
import 'package:eventzone/core/data/network/error_message_model.dart';
import 'package:eventzone/events/data/models/event_model.dart';

abstract class EventsRemoteDataSource {
  // Future<List<EventModel>> getNowPlayingMovies();
  // Future<List<EventModel>> getPopularMovies();
  // Future<List<EventModel>> getTopRatedMovies();
  Future<List<EventModel>> getEvents();
  Future<EventDetailModel> getEventDetail(int eventId);
  // Future<List<EventModel>> getAllPopularMovies(int page);
  // Future<List<EventModel>> getAllTopRatedMovies(int page);
}

class EventsRemoteDataSourceImpl extends EventsRemoteDataSource {

  @override
  Future<List<EventModel>> getEvents() async {
    final response = await Dio().get(ApiConstants.event);
    if (response.statusCode == 200) {
      return List<EventModel>.from((response.data['results'] as List)
          .map((e) => EventModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<EventDetailModel> getEventDetail(int eventId) async {
    final response = await Dio().get(ApiConstants.getEventDetailPath(eventId));
    if (response.statusCode == 200) {
      return EventDetailModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }


}

