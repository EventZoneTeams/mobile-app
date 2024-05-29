part of 'popular_events_bloc.dart';

class PopularEventsState extends Equatable {
  final List<Media> events;
  final GetAllRequestStatus status;
  final String message;

  const PopularEventsState({
    this.events = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  PopularEventsState copyWith({
    List<Media>? events,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return PopularEventsState(
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
