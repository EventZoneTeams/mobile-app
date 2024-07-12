class EventDetailModel {
  final int id;
  final String name;
  final String? description;
  final String? thumbnailUrl;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String? note;
  final String location;
  final int userId;
  final String userEmail; // Instead of AccountModel
  final String userName;
  final String? userImage;// Instead of AccountModel
  final int eventCategoryId; // Instead of CategoryModel
  final String eventCategoryTitle;
  final String eventCategoryImageUrl;
  final String? university;
  final String status;
  final double totalCost;
  final DateTime createdAt;
  final bool isDeleted;
  final List<dynamic> eventCampaigns;

  EventDetailModel({
    required this.id,
    required this.name,
    this.description,
    this.thumbnailUrl,
    required this.eventStartDate,
    required this.eventEndDate,
    this.note,
    this.userImage,
    required this.userName,
    required this.location,
    required this.userId,
    required this.userEmail, // New field
    required this.eventCategoryId, // New field
    required this.eventCategoryTitle, // New field
    required this.eventCategoryImageUrl, // New field
    this.university,
    required this.status,
    required this.totalCost,
    required this.createdAt,
    required this.isDeleted,
    required this.eventCampaigns,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return EventDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnail-url'] as String?,
      eventStartDate: DateTime.parse(json['event-start-date'] as String),
      eventEndDate: DateTime.parse(json['event-end-date'] as String),
      note: json['note'] as String?,
      location: json['location'] as String,
      userId: json['user-id'] as int,
      userEmail: json['user']['email'] as String, // Extract email directly
      userName: json['user']['unsign-full-name'] as String? ?? 'AnonymousUser',
      userImage: json['user']['image'] as String?,
      eventCategoryId: json['event-category']['id'] as int, // Extract category ID
      eventCategoryTitle: json['event-category']['title'] as String, // Extract category title
      eventCategoryImageUrl: json['event-category']['image-url'] as String, // Extract category image URL
      university: json['university'] as String?,
      status: json['status'] as String,
      totalCost: (json['total-cost'] as num).toDouble(),
      createdAt: DateTime.parse(json['created-at'] as String),
      isDeleted: json['is-deleted'] as bool,
      eventCampaigns: json['event-campaigns'] as List<dynamic>,
    );
  }
}
class EventProductModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String? description;
  final int price;
  final List<ProductImage> productImages; // New field for product images

  EventProductModel({
    required this.id,
    required this.createdAt,
    required this.name,
    this.description,
    required this.price,
    required this.productImages, // Initialize the new field
  });

  factory EventProductModel.fromJson(Map<String, dynamic> json) {
    return EventProductModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created-at'] as String),
      name: json['name'] as String,
      description: json['description'] as String?,
      price: json['price'] as int,
      productImages: (json['product-images'] as List<dynamic>?)
          ?.map((imageJson) => ProductImage.fromJson(imageJson))
          .toList() ?? [],
    );
  }
}

// Model for product images
class ProductImage {
  final int id;
  final String imageUrl;
  final String name;

  ProductImage({
    required this.id,
    required this.imageUrl,
    required this.name,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int,
      imageUrl: json['image-url'] as String,
      name: json['name'] as String,
    );
  }
}
class EventPackageModel {
  final int id;
  final int eventId;
  final int totalPrice;
  final String description;
  final String thumbnailUrl;
  final bool isDeleted;
  final List<EventProductModel> productsInPackage; // Renamed to match API

  EventPackageModel({
    required this.id,
    required this.eventId,
    required this.totalPrice,
    required this.description,
    required this.thumbnailUrl,
    required this.isDeleted,
    required this.productsInPackage, // Renamed
  });

  factory EventPackageModel.fromJson(Map<String, dynamic> json) {
    return EventPackageModel(
      id: json['id'] as int,
      eventId: json['event-id'] as int,
      totalPrice: json['total-price'] as int,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnail-url'] as String,
      isDeleted: json['is-deleted'] as bool,
      productsInPackage: (json['products-in-package'] as List<dynamic>?)
          ?.map((productJson) =>
          EventProductModel.fromJson(productJson['event-product'] as Map<String, dynamic>)
      )
          .toList() ?? [],
    );
  }
}