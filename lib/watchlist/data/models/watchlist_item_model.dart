import 'package:eventzone/core/domain/entities/event.dart';

class WatchlistItemModel extends Media {
  const WatchlistItemModel({
    required super.tmdbID,
    required super.title,
    required super.releaseDate,
    required super.voteAverage,
    required super.posterUrl,
    required super.backdropUrl,
    required super.overview,
    required super.isEvent,
  });

  factory WatchlistItemModel.fromEntity(Media media) {
    return WatchlistItemModel(
      tmdbID: media.tmdbID,
      title: media.title,
      releaseDate: media.releaseDate,
      voteAverage: media.voteAverage,
      posterUrl: media.posterUrl,
      backdropUrl: media.backdropUrl,
      overview: media.overview,
      isEvent: media.isEvent,
    );
  }
}
