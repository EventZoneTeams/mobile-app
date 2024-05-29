import 'package:dartz/dartz.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

class GetEventsDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final EventsRespository _baseEventsRespository;

  GetEventsDetailsUseCase(this._baseEventsRespository);

  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _baseEventsRespository.getEventDetails(p);
  }
}
