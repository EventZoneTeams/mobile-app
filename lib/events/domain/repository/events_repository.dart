import 'package:dartz/dartz.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';

abstract class EventsRespository {
  Future<Either<Failure, List<List<Media>>>> getEvents();
  Future<Either<Failure, MediaDetails>> getEventDetails(int eventId);
  Future<Either<Failure, List<Media>>> getAllPopularEvents(int page);
  Future<Either<Failure, List<Media>>> getAllTopRatedEvents(int page);
}
