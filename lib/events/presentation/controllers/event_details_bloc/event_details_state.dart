part of 'event_details_bloc.dart';

class EventDetailsState {
  final EventDetail? eventDetail;
  final RequestStatus status;
  final String message;

  const EventDetailsState({
    this.eventDetail,
    this.status = RequestStatus.loading,
    this.message = '',
  });

  EventDetailsState copyWith({
    EventDetail? eventDetail,
    RequestStatus? status,
    String? message,
  }) {
    return EventDetailsState(
      eventDetail: eventDetail ?? eventDetail,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
