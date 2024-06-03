import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';

@HiveType(typeId: 1)
class Event extends Equatable {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final String eventStartDate;
  final String eventEndDate;
  final int eventCategoryId;
  final String university;
  final bool isDonation;
  final double totalCost;
  // double currentDonate;
  const Event(
  {
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventCategoryId,
    required this.university,
    required this.isDonation,
    required this.totalCost
    // double currentDonate;
  });

  factory Event.fromEventDetails(EventDetail eventDetail) {
    return Event(
      id: eventDetail.id,
      name: eventDetail.name,
      description: eventDetail.description,
      thumbnailUrl: eventDetail.thumbnailUrl,
      eventStartDate: eventDetail.eventStartDate,
      eventEndDate: eventDetail.eventEndDate,
      eventCategoryId: eventDetail.eventCategoryId,
      university: eventDetail.university,
      isDonation: eventDetail.isDonation,
      totalCost: eventDetail.totalCost,
      // double currentDonate;
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        thumbnailUrl,
        eventStartDate,
        eventEndDate,
        eventCategoryId,
        university,
        isDonation,
        totalCost
    // double currentDonate;
      ];
}
