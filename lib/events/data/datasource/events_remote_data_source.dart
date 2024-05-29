import 'package:dio/dio.dart';
import 'package:eventzone/core/data/error/exceptions.dart';
import 'package:eventzone/core/data/network/api_constants.dart';
import 'package:eventzone/core/data/network/error_message_model.dart';
import 'package:eventzone/events/data/models/event_model.dart';
import 'package:eventzone/events/data/models/event_details_model.dart';

abstract class EventsRemoteDataSource {
  Future<List<EventModel>> getNowPlayingEvents();
  Future<List<EventModel>> getPopularEvents();
  Future<List<EventModel>> getTopRatedEvents();
  Future<List<List<EventModel>>> getEvents();
  Future<EventDetailsModel> getEventDetails(int eventId);
  Future<List<EventModel>> getAllPopularEvents(int page);
  Future<List<EventModel>> getAllTopRatedEvents(int page);
}

class EventsRemoteDataSourceImpl extends EventsRemoteDataSource {
  @override
  Future<List<EventModel>> getNowPlayingEvents() async {
    final response = await Dio().get(ApiConstants.nowPlayingEventsPath);
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
  Future<List<EventModel>> getPopularEvents() async {
    final response = await Dio().get(ApiConstants.popularEventsPath);
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
  Future<List<EventModel>> getTopRatedEvents() async {
    final response = await Dio().get(ApiConstants.topRatedEventsPath);
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
  Future<List<List<EventModel>>> getEvents() async {
    final response = Future.wait(
      [
        getNowPlayingEvents(),
        getPopularEvents(),
        getTopRatedEvents(),
      ],
      eagerError: true,
    );
    return response;
  }

  @override
  Future<EventDetailsModel> getEventDetails(int eventId) async {
    final response = await Dio().get(ApiConstants.getEventDetailsPath(eventId));
    if (response.statusCode == 200) {
      return EventDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<EventModel>> getAllPopularEvents(int page) async {
    final response =
        await Dio().get(ApiConstants.getAllPopularEventsPath(page));
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
  Future<List<EventModel>> getAllTopRatedEvents(int page) async {
    final response =
        await Dio().get(ApiConstants.getAllTopRatedEventsPath(page));
    if (response.statusCode == 200) {
      return List<EventModel>.from((response.data['results'] as List)
          .map((e) => EventModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
