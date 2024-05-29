import 'package:dartz/dartz.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

class GetEventsUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final EventsRespository _baseEventsRespository;

  GetEventsUseCase(this._baseEventsRespository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseEventsRespository.getEvents();
  }
}
