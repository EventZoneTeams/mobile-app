import 'package:dartz/dartz.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/tv_shows/domain/repository/tv_shows_repository.dart';

class GetAllTopRatedTVShowsUseCase extends BaseUseCase<List<Media>, int> {
  final TVShowsRepository _baseTVShowsRepository;

  GetAllTopRatedTVShowsUseCase(this._baseTVShowsRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int p) async {
    return await _baseTVShowsRepository.getAllTopRatedTVShows(p);
  }
}
