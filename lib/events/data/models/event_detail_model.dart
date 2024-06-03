import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/utils/functions.dart';
// import 'package:eventzone/movies/data/models/event_model.dart';
// import 'package:eventzone/movies/data/models/review_model.dart';
// import 'package:eventzone/movies/data/models/cast_model.dart';

// ignore: must_be_immutable
class EventDetailModel extends EventDetail {
  EventDetailModel({
    required super.id,
    required super.name,
    required super.description,
    required super.thumbnailUrl,
    required super.donationStartDate,
    required super.donationEndDate,
    required super.eventStartDate,
    required super.eventEndDate,
    required super.location,
    required super.userId,
    required super.eventCategoryId,
    required super.university,
    required super.organizationStatus,
    required super.isDonation,
    required super.totalCost,
    // this.posts,
    // this.eventImages,
    // this.eventProducts,
    // this.eventOrders,
    // this.eventComments,
    // required super.user,
    // this.eventFeedbacks,
    // required super.isAdded,
    // required this.eventCategory,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return EventDetailModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      thumbnailUrl: json['backdrop_path'],
      donationStartDate: json['donationStartDate'],
      donationEndDate: json['donationEndDate'],
      eventStartDate: json['eventStartDate'],
      eventEndDate: json['eventEndDate'] ?? '',
      location: json['location'] ?? '',
      userId:  json['userId'] == null ? -1 : int.parse(json['userId']),
      eventCategoryId: json['eventCategoryId'] == null ? -1 : int.parse(json['eventCategoryId']),
      university: json['university'] ?? '',
      organizationStatus: json['organizationStatus'] ?? '',
      isDonation:  json['isDonation'] == null ? false : bool.parse(json['isDonation']),
      totalCost: json['totalCost'] == null ? 0 : double.parse(json['totalCost']),



      //TEMPLATE REFERENCE
      // double.parse((json['vote_average'] as double).toStringAsFixed(1)),
      // voteCount: getVotesCount(json['vote_count']),
      // trailerUrl: getTrailerUrl(json),
      // cast: List<CastModel>.from(
      //     (json['credits']['cast'] as List).map((e) => CastModel.fromJson(e))),
      // reviews: List<ReviewModel>.from((json['reviews']['results'] as List)
      //     .map((e) => ReviewModel.fromJson(e))),
      // similar: List<MovieModel>.from((json['similar']['results'] as List)
      //     .map((e) => MovieModel.fromJson(e))),
    );
  }
}
