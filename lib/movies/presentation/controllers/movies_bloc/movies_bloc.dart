import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/movies/domain/usecases/get_movies_usecase.dart';

import 'package:eventzone/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:eventzone/movies/presentation/controllers/movies_bloc/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;

  MoviesBloc(
    this._getMoviesUseCase,
  ) : super(const MoviesState()) {
    on<GetMoviesEvent>(_getMovies);
  }

  Future<void> _getMovies(
      GetMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
      ),
    );
    final result = await _getMoviesUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: RequestStatus.loaded,
          movies: r,
        ),
      ),
    );
  }
}
