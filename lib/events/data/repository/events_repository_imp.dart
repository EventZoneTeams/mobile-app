import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventzone/core/data/error/exceptions.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/events/data/datasource/events_remote_data_source.dart';
// import 'package:movies_app/core/data/error/exceptions.dart';
// import 'package:movies_app/core/data/error/failure.dart';
// import 'package:movies_app/core/domain/entities/media.dart';
// import 'package:movies_app/core/domain/entities/media_details.dart';
// import 'package:movies_app/movies/domain/repository/movies_repository.dart';
//
// import 'package:movies_app/movies/data/datasource/movies_remote_data_source.dart';

class EventsRepositoryImp extends EventsRespository {
  final EventsRemoteDataSource _baseEventRemoteDataSource;

  EventsRepositoryImp(this._baseEventRemoteDataSource);

  @override
  Future<Either<Failure, EventDetail>> getEventDetail(int eventId) async {
    try {
      final result = await _baseEventRemoteDataSource.getEventDetail(eventId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    try {
      final result = await _baseEventRemoteDataSource.getEvents();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  // @override
  // Future<Either<Failure, List<Media>>> getAllPopularMovies(int page) async {
  //   try {
  //     final result =
  //     await _baseMoviesRemoteDataSource.getAllPopularMovies(page);
  //     return Right(result);
  //   } on ServerException catch (failure) {
  //     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
  //   } on DioError catch (failure) {
  //     return Left(ServerFailure(failure.message));
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, List<Media>>> getAllTopRatedMovies(int page) async {
  //   try {
  //     final result =
  //     await _baseMoviesRemoteDataSource.getAllTopRatedMovies(page);
  //     return Right(result);
  //   } on ServerException catch (failure) {
  //     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
  //   } on DioError catch (failure) {
  //     return Left(ServerFailure(failure.message));
  //   }
  // }
}
