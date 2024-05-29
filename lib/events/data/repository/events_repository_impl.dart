import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventzone/core/data/error/exceptions.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/events/data/datasource/events_remote_data_source.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';

class EventsRepositoryImpl extends EventsRespository {
  final EventsRemoteDataSource _baseEventsRemoteDataSource;

  EventsRepositoryImpl(this._baseEventsRemoteDataSource);

  @override
  Future<Either<Failure, MediaDetails>> getEventDetails(int eventId) async {
    try {
      final result = await _baseEventsRemoteDataSource.getEventDetails(eventId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<List<Media>>>> getEvents() async {
    try {
      final result = await _baseEventsRemoteDataSource.getEvents();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllPopularEvents(int page) async {
    try {
      final result =
          await _baseEventsRemoteDataSource.getAllPopularEvents(page);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllTopRatedEvents(int page) async {
    try {
      final result =
          await _baseEventsRemoteDataSource.getAllTopRatedEvents(page);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}
