import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/domain/entities/event_details.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class Event extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String thumbnailUrl;
  @HiveField(4)
  final String donationStartDate;
  @HiveField(5)
  final String donationEndDate;
  @HiveField(6)
  final String eventStartDate;
  @HiveField(7)
  final String eventEndDate;
  @HiveField(8)
  final String location;
  @HiveField(9)
  final int userId;
  @HiveField(10)
  final int eventCategory;
  @HiveField(11)
  final String university;
  @HiveField(12)
  final String status;
  @HiveField(13)
  final String organizationStatus;
  @HiveField(14)
  final bool isDonation;
  @HiveField(15)
  double totalCost;


  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.donationStartDate,
    required this.donationEndDate,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.location,
    required this.userId,
    required this.eventCategory,
    required this.university,
    required this.status,
    required this.organizationStatus,
    required this.isDonation,
    this.totalCost = 0
  });

  factory Event.fromEventDetails(EventDetails eventDetail) {
    return Event(
      id: eventDetailid.,
      name: mediaDetails.title,
      description: mediaDetails.posterUrl,
      thumbnailUrl: mediaDetails.backdropUrl,
      donationStartDate: mediaDetails.voteAverage,
      donationEndDate: mediaDetails.releaseDate,
      eventStartDate: mediaDetails.overview,
      eventEndDate: mediaDetails.lastEpisodeToAir == null,
      location: mediaDetails.lastEpisodeToAir == null,
      userId: mediaDetails.lastEpisodeToAir == null,
      eventCategory: mediaDetails.lastEpisodeToAir == null,
      university: mediaDetails.lastEpisodeToAir == null,
      status: mediaDetails.lastEpisodeToAir == null,
      organizationStatus: mediaDetails.lastEpisodeToAir == null,
      isDonation: mediaDetails.lastEpisodeToAir == null,
      totalCost: mediaDetails.lastEpisodeToAir == null,
    );
  }

  @override
  List<Object?> get props => [
        tmdbID,
        title,
        posterUrl,
        backdropUrl,
        voteAverage,
        releaseDate,
        overview,
        isMovie,
      ];
}
