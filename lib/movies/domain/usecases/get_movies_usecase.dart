import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/movies/domain/repository/movies_repository.dart';
import 'package:eventzone/core/data/error/failuredart';

class GetMoviesUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final MoviesRespository _baseMoviesRespository;

  GetMoviesUseCase(this._baseMoviesRespository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _baseMoviesRespository.getMovies();
  }
}
