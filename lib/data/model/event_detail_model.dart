class EventDetailModel {
  final int id;
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final String donationStartDate;
  final String donationEndDate;
  final String eventStartDate;
  final String eventEndDate;
  final String location;
  final int userId;
  final String eventCategoryName;
  final String eventCategoryImageUrl;
  final String university;
  final String organizationStatus;
  final bool isDonation;
  final double totalCost;
  // ... other properties you want to include (posts, eventImages, etc.)

  const EventDetailModel({
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
    required this.eventCategoryName,
    required this.eventCategoryImageUrl,
    required this.university,
    required this.organizationStatus,
    required this.isDonation,
    required this.totalCost,
    // ... other properties
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return EventDetailModel(
      id: json['id'] as int,
      name: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnail-url'] as String?,
      donationStartDate: json['donation-start-date'] as String,
      donationEndDate: json['donation-end-date'] as String,
      eventStartDate: json['event-start-date'] as String,
      eventEndDate: json['event-end-date'] ?? '',
      location: json['location'] ?? '',
      userId: int.parse(json['user-id'] as String),
      eventCategoryName: json['event-category']['title'] as String,
      eventCategoryImageUrl: json['event-category']['image-url'] as String,
      university: json['university'] ?? '',
      organizationStatus: json['organization-status'] ?? '',
      isDonation: json['is-donation'] == null ? false : (json['is-donation'] as bool),
      totalCost: json['total-cost'] == null ? 0 : (json['total-cost'] as num).toDouble(),
      // ... parse other properties
    );
  }
}