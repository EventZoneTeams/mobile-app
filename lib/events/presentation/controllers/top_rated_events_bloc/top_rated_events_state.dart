part of 'top_rated_events_bloc.dart';

class TopRatedEventsState extends Equatable {
  const TopRatedEventsState({
    this.events = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  final List<Media> events;
  final GetAllRequestStatus status;
  final String message;

  TopRatedEventsState copyWith({
    List<Media>? events,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return TopRatedEventsState(
      events: events ?? this.events,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        events,
        status,
        message,
      ];
}
