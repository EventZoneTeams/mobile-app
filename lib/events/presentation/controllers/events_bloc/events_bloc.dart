import 'dart:async';

import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/domain/usecases/get_events_usecase.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_event.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEventsUseCase _getEventsUseCase;

  EventsBloc(
    this._getEventsUseCase,
  ) : super(const EventsState()) {
    on<GetEventsEvent>(_getEvents);
  }

  Future<void> _getEvents(
      GetEventsEvent event, Emitter<EventsState> emit) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
      ),
    );
    final result = await _getEventsUseCase(const NoParameters());
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
          events: r,
        ),
      ),
    );
  }
}
