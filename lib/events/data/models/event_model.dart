import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/utils/functions.dart';

class EventModel extends Event {
  const EventModel ({
    required super.id,
    required super.name,
    required super.description,
    required super.thumbnailUrl,
    required super.eventStartDate,
    required super.eventEndDate,
    required super.eventCategoryId,
    required super.university,
    required super.isDonation,
    required super.totalCost
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    thumbnailUrl: json['thumbnailUrl'],
    eventStartDate: json['eventStartDate'],
    eventEndDate: json['eventEndDate'],
    eventCategoryId: int.parse(json['eventCategoryId']),
    university: json['university'],
    isDonation: bool.parse(json['isDonation']),
    totalCost: bool.parse(json['isDonation']) == false ? 0 : double.parse(json['totalCost'])
  );
}
