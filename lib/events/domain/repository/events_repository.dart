import 'package:dartz/dartz.dart';

import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';

abstract class EventsRespository {
  Future<Either<Failure, List<Event>>> getEvents();
  Future<Either<Failure, EventDetail>> getEventDetail(int eventId);
}
