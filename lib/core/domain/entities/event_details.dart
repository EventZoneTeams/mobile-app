import 'package:equatable/equatable.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/movies/domain/entities/cast.dart';
import 'package:eventzone/movies/domain/entities/review.dart';
import 'package:eventzone/tv_shows/domain/entities/episode.dart';
import 'package:eventzone/tv_shows/domain/entities/season.dart';

// ignore: must_be_immutable
class EventDetails extends Equatable {
  final int id;
  final String name;
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
  final String organizationStatus;
  final bool isDonation;
  final double totalCost;
  final List<Post>? post;
  final List<Image>? eventImage;
  final List<EventProduct>? similar;
  bool isAdded;

  EventDetails({
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
