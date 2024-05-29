import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/domain/usecases/get_all_popular_events_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_events_event.dart';
part 'popular_events_state.dart';

class PopularEventsBloc extends Bloc<PopularEventsEvent, PopularEventsState> {
  final GetAllPopularEventsUseCase _allPopularEventsUseCase;

  PopularEventsBloc(this._allPopularEventsUseCase)
      : super(const PopularEventsState()) {
    on<GetPopularEventsEvent>(_getAllPopularEvents);
    on<FetchMorePopularEventsEvent>(_fetchMoreEvents);
  }

  int page = 1;

  Future<void> _getAllPopularEvents(
      GetPopularEventsEvent event, Emitter<PopularEventsState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getEvents(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getEvents(emit);
    } else {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getEvents(emit);
    }
  }

  Future<void> _getEvents(Emitter<PopularEventsState> emit) async {
    final result = await _allPopularEventsUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            events: state.events + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreEvents(FetchMorePopularEventsEvent event,
      Emitter<PopularEventsState> emit) async {
    final result = await _allPopularEventsUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.fetchMoreError,
        ),
      ),
      (r) {
        page++;
        return emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            events: state.events + r,
          ),
        );
      },
    );
  }
}
