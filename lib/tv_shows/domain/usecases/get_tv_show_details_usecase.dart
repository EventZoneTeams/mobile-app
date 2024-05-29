import 'package:eventzone/core/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/tv_shows/domain/repository/tv_shows_repository.dart';

class GetTVShowDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final TVShowsRepository _baseTVShowsRepository;

  GetTVShowDetailsUseCase(this._baseTVShowsRepository);
  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _baseTVShowsRepository.getTVShowDetails(p);
  }
}
