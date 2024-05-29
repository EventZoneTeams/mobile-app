part of 'top_rated_events_bloc.dart';

abstract class TopRatedEventsEvent extends Equatable {
  const TopRatedEventsEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedEventsEvent extends TopRatedEventsEvent {}

class FetchMoreTopRatedEventsEvent extends TopRatedEventsEvent {}
