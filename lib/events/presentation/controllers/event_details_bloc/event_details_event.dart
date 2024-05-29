part of 'event_details_bloc.dart';

abstract class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();
}

class GetEventDetailsEvent extends EventDetailsEvent {
  final int id;
  const GetEventDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
