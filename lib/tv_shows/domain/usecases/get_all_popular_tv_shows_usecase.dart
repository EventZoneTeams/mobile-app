import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:eventzone/core/data/error/failuredart';

class GetAllPopularTVShowsUseCase extends BaseUseCase<List<Media>, int> {
  final TVShowsRepository _baseTVShowsRepository;

  GetAllPopularTVShowsUseCase(this._baseTVShowsRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int p) async {
    return await _baseTVShowsRepository.getAllPopularTVShows(p);
  }
}
