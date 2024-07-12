class EventModel {
  final int id;
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final String eventStartDate;
  final String eventEndDate;
  final String eventCategoryName;
  final String eventCategoryImageUrl;
  final String? university;
  final double totalCost;

  const EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventCategoryName,
    required this.eventCategoryImageUrl,
    required this.university,
    required this.totalCost,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnail-url'] as String?,
      eventStartDate: json['event-start-date'] as String,
      eventEndDate: json['event-end-date'] as String,
      eventCategoryName: json['event-category']['title'] as String,
      eventCategoryImageUrl: json['event-category']['image-url'] as String,
      university: json['university'] as String?,
      totalCost: (json['total-cost'] as num).toDouble()
    );
  }
}