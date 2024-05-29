import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/event.dart';
import 'package:movies_app/movies/domain/entities/cast.dart';
import 'package:movies_app/movies/domain/entities/review.dart';
import 'package:movies_app/tv_shows/domain/entities/episode.dart';
import 'package:movies_app/tv_shows/domain/entities/season.dart';

// ignore: must_be_immutable
class EventDetails extends Equatable {
  final int id
  final String name ;
  final String description;
  final String donationStartDate;
  final String donationEndDate;
  final String eventStartDate;
  final String eventEndDate;
  final String location;
  final int userId;
  final int eventCategoryId;
  final String university;
  final String status;
  final String origanizationStatus;
  final bool isDonation;
  final double totalCost;
  final List<Post>? reviews;
  // event
  final List<Image>? seasons;
  final List<Media> similar;
  bool isAdded;

  MediaDetails({
    this.id,
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    this.lastEpisodeToAir,
    required this.genres,
    this.runtime,
    this.numberOfSeasons,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.trailerUrl,
    this.cast,
    this.reviews,
    this.seasons,
    required this.similar,
    this.isAdded = false,
  });

  @override
  List<Object?> get props => [
        id,
        tmdbID,
        title,
        posterUrl,
        backdropUrl,
        releaseDate,
        genres,
        overview,
        voteAverage,
        voteCount,
        trailerUrl,
        similar,
        isAdded,
      ];
}
