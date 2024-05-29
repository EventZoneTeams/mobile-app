import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_all_top_rated_tv_shows_usecase.dart';
import 'package:flutter_bloc/flutter_blocsecase.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTVShowsBloc
    extends Bloc<TopRatedTVShowsEvent, TopRatedTVShowsState> {
  TopRatedTVShowsBloc(this._getAllTopRatedTvShowsUseCase)
      : super(const TopRatedTVShowsState()) {
    on<GetTopRatedTVShowsEvent>(_getTopRatedTVShows);
    on<FetchMoreTopRatedTVShowsEvent>(_fetchMoreTVShows);
  }

  final GetAllTopRatedTVShowsUseCase _getAllTopRatedTvShowsUseCase;
  int page = 1;

  Future<void> _getTopRatedTVShows(
      GetTopRatedTVShowsEvent event, Emitter<TopRatedTVShowsState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getTVShows(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getTVShows(emit);
    } else {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getTVShows(emit);
    }
  }

  Future<void> _getTVShows(Emitter<TopRatedTVShowsState> emit) async {
    final result = await _getAllTopRatedTvShowsUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            tvShows: state.tvShows + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreTVShows(FetchMoreTopRatedTVShowsEvent event,
      Emitter<TopRatedTVShowsState> emit) async {
    final result = await _getAllTopRatedTvShowsUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.fetchMoreError,
          message: l.message,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            tvShows: state.tvShows + r,
          ),
        );
      },
    );
  }
}
