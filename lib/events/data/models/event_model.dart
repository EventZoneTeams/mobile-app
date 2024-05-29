import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/utils/functions.dart';

class EventModel extends Media {
  const EventModel({
    required super.tmdbID,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.voteAverage,
    required super.releaseDate,
    required super.overview,
    required super.isEvent,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        tmdbID: json['id'],
        title: json['title'],
        posterUrl: getPosterUrl(json['poster_path']),
        backdropUrl: getBackdropUrl(json['backdrop_path']),
        voteAverage: double.parse((json['vote_average']).toStringAsFixed(1)),
        releaseDate: getDate(json['release_date']),
        overview: json['overview'] ?? '',
        isEvent: true,
      );
}
