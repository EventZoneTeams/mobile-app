import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/domain/usecases/get_all_top_rated_events_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_events_event.dart';
part 'top_rated_events_state.dart';

class TopRatedEventsBloc
    extends Bloc<TopRatedEventsEvent, TopRatedEventsState> {
  TopRatedEventsBloc(this._getAllTopRatedEventsUseCase)
      : super(const TopRatedEventsState()) {
    on<TopRatedEventsEvent>(_getAllTopRatedEvents);
    on<FetchMoreTopRatedEventsEvent>(_fetchMoreEvents);
  }

  final GetAllTopRatedEventsUseCase _getAllTopRatedEventsUseCase;
  int page = 1;

  Future<void> _getAllTopRatedEvents(
      TopRatedEventsEvent event, Emitter<TopRatedEventsState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getEvents(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getEvents(emit);
    } else if (state.status == GetAllRequestStatus.error) {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getEvents(emit);
    }
  }

  Future<void> _getEvents(Emitter<TopRatedEventsState> emit) async {
    final result = await _getAllTopRatedEventsUseCase(page);
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

  Future<void> _fetchMoreEvents(FetchMoreTopRatedEventsEvent event,
      Emitter<TopRatedEventsState> emit) async {
    final result = await _getAllTopRatedEventsUseCase(page);
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
