import 'package:eventzone/core/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

import 'package:eventzone/core/domain/entities/event_details.dart';

class GetEventDetailUseCase extends BaseUseCase<EventDetail, int> {
  final EventsRespository _baseEventRepository;

  GetEventDetailUseCase(this._baseEventRepository);

  @override
  Future<Either<Failure, EventDetail>> call(int p) async {
    return await _baseEventRepository.getEventDetail(p);
  }
}
