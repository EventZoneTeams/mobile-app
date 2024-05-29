import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:eventzone/core/data/error/failuredart';

class GetTVShowsUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final TVShowsRepository _baseTVShowsRepository;

  GetTVShowsUseCase(this._baseTVShowsRepository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseTVShowsRepository.getTVShows();
  }
}
