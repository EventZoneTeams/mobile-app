import 'package:dartz/dartz.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

class GetAllTopRatedEventsUseCase extends BaseUseCase<List<Media>, int> {
  final EventsRespository _baseEventsRespository;

  GetAllTopRatedEventsUseCase(this._baseEventsRespository);

  @override
  Future<Either<Failure, List<Media>>> call(int p) async {
    return await _baseEventsRespository.getAllTopRatedEvents(p);
  }
}
