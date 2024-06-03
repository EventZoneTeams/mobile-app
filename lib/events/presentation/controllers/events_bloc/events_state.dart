import 'package:equatable/equatable.dart';

import 'package:eventzone/core/domain/entities/event.dart';

import 'package:eventzone/core/utils/enums.dart';

class EventsState extends Equatable {
  final List<Event> events;
  final RequestStatus status;
  final String message;

  const EventsState({
    this.events = const [],
    this.status = RequestStatus.loading,
    this.message = '',
  });

  EventsState copyWith({
    List<Event>? events,
    RequestStatus? status,
    String? message,
  }) {
    return EventsState(
      events: events ?? this.events,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    events,
    status,
    message,
  ];
}
