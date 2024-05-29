import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/domain/usecases/get_event_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_details_event.dart';
part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final GetEventsDetailsUseCase _getEventsDetailsUseCase;

  EventDetailsBloc(this._getEventsDetailsUseCase)
      : super(const EventDetailsState()) {
    on<GetEventDetailsEvent>(_getEventDetails);
  }

  Future<void> _getEventDetails(
      GetEventDetailsEvent event, Emitter<EventDetailsState> emit) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
      ),
    );
    final result = await _getEventsDetailsUseCase(event.id);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: RequestStatus.loaded,
          eventDetails: r,
        ),
      ),
    );
  }
}
