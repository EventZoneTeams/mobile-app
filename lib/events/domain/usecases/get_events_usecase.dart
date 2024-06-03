import 'package:eventzone/core/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';

import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

class GetEventsUseCase extends BaseUseCase<List<Event>, NoParameters> {
  final EventsRespository _baseMoviesRepository;

  GetEventsUseCase(this._baseMoviesRepository);

  @override
  Future<Either<Failure, List<Event>>> call(NoParameters p) async {
    return await _baseMoviesRepository.getEvents();
  }
}
