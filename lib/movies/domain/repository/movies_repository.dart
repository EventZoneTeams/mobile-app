import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event';

abstract class MoviesRespository {
  Future<Either<Failure, List<List<Media>>>> getMovies();
  Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId);
  Future<Either<Failure, List<Media>>> getAllPopularMovies(int page);
  Future<Either<Failure, List<Media>>> getAllTopRatedMovies(int page);
}
