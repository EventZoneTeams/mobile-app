part of 'popular_events_bloc.dart';

abstract class PopularEventsEvent extends Equatable {
  const PopularEventsEvent();

  @override
  List<Object> get props => [];
}

class GetPopularEventsEvent extends PopularEventsEvent {}

class FetchMorePopularEventsEvent extends PopularEventsEvent {}
