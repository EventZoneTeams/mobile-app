import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';

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
  final int eventCategoryId;
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

  Event(
      {required this.id,
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
      required this.status,
      required this.organizationStatus,
      required this.isDonation,
      this.totalCost = 0});

  factory Event.fromEventDetails(EventDetail eventDetail) {
    return Event(
      id: eventDetail.id,
      name: eventDetail.name,
      description: eventDetail.description,
      thumbnailUrl: eventDetail.thumbnailUrl,
      donationStartDate: eventDetail.donationStartDate,
      donationEndDate: eventDetail.donationEndDate,
      eventStartDate: eventDetail.eventStartDate,
      eventEndDate: eventDetail.eventEndDate,
      location: eventDetail.location,
      userId: eventDetail.userId,
      eventCategoryId: eventDetail.eventCategoryId,
      university: eventDetail.university,
      status: eventDetail.status,
      organizationStatus: eventDetail.organizationStatus,
      isDonation: eventDetail.isDonation,
      totalCost: eventDetail.totalCost,
    );
  }

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
        status,
        organizationStatus,
        isDonation,
        totalCost
      ];
}
