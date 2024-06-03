import 'package:equatable/equatable.dart';
import 'package:eventzone/core/domain/entities/user.dart';

// ignore: must_be_immutable
class EventDetail extends Equatable {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final String donationStartDate;
  final String donationEndDate;
  final String eventStartDate;
  final String eventEndDate;
  final String location;
  final int userId;
  final int eventCategoryId;
  final String university;
  // final String status;
  final String organizationStatus;
  final bool isDonation;
  double totalCost;
  // final List<Post>? posts;
  // final List<Image>? eventImages;
  // final List<EventProduct>? eventProducts;
  // final List<EventOrder>? eventOrders;
  // final List<EventComment>? eventComments;
  // final User user;
  // final List<EventFeedback>? eventFeedbacks;
  // final bool isAdded;
  // final EventCategory eventCategory;

  EventDetail({
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
    required this.eventCategoryId,
    required this.university,
    // required this.status,
    required this.organizationStatus,
    required this.isDonation,
    required this.totalCost,
    // this.posts,
    // this.eventImages,
    // this.eventProducts,
    // this.eventOrders,
    // this.eventComments,
    // required this.user,
    // this.eventFeedbacks,
    // required this.isAdded,
    // required this.eventCategory,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    thumbnailUrl,
    donationStartDate,
    donationEndDate,
    eventStartDate,
    eventEndDate,
    location,
    userId,
    eventCategoryId,
    university,
    // status,
    organizationStatus,
    isDonation,
    totalCost,
    // posts,
    // eventImages,
    // eventProducts,
    // eventOrders,
    // eventComments,
    // user,
    // eventFeedbacks,
    // isAdded,
    // eventCategory,
      ];


}
