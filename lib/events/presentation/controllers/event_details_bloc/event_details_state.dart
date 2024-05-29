part of 'event_details_bloc.dart';

class EventDetailsState {
  final MediaDetails? eventDetails;
  final RequestStatus status;
  final String message;

  const EventDetailsState({
    this.eventDetails,
    this.status = RequestStatus.loading,
    this.message = '',
  });

  EventDetailsState copyWith({
    MediaDetails? eventDetails,
    RequestStatus? status,
    String? message,
  }) {
    return EventDetailsState(
      eventDetails: eventDetails ?? this.eventDetails,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
