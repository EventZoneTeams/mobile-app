import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:flutter_bloc/flutter_blocusecase.dart';

part 'tv_shows_event.dart';
part 'tv_shows_state.dart';

class TVShowsBloc extends Bloc<TVShowsEvent, TVShowsState> {
  TVShowsBloc(this._getTvShowsUseCase) : super(const TVShowsState()) {
    on<GetTVShowsEvent>(_getTvShows);
  }

  final GetTVShowsUseCase _getTvShowsUseCase;

  Future<void> _getTvShows(
      TVShowsEvent event, Emitter<TVShowsState> emit) async {
    emit(
      const TVShowsState(
        status: RequestStatus.loading,
      ),
    );
    final result = await _getTvShowsUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        const TVShowsState(
          status: RequestStatus.error,
        ),
      ),
      (r) => emit(
        TVShowsState(
          status: RequestStatus.loaded,
          tvShows: r,
        ),
      ),
    );
  }
}
