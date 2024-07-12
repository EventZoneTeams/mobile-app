class Order {
  final int? id;
  final int eventId;
  final int totalAmount;
  final String status;
  final List<OrderDetail> eventOrderDetails;

  Order({
    this.id,
    required this.eventId,
    required this.totalAmount,
    required this.status,
    required this.eventOrderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      eventId: json['event-id'] as int,
      totalAmount: json['total-amount'] as int,
      status: json['status'] as String,
      eventOrderDetails: (json['event-order-details'] as List<dynamic>)
          .map((detail) => OrderDetail.fromJson(detail as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event-id': eventId,
      'event-order-details': eventOrderDetails.map((detail) => detail.toJson()).toList(),
    }; // Removed 'user-id'
  }
}

class OrderDetail {
  final int id;
  final int packageId;
  final int eventOrderId;
  final int quantity;
  final int price; // Change to int to match the response

  OrderDetail({
    required this.id,
    required this.packageId,
    required this.eventOrderId,
    required this.quantity,
    required this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] as int,
      packageId: json['package-id'] as int,
      eventOrderId: json['event-order-id'] as int,
      quantity: json['quantity'] as int,
      price: json['price'] as int, // No need for conversion
    );
  }

  // Add a toJson() method for creating order requests
  Map<String, dynamic> toJson() {
    return {
      'package-id': packageId,
      'quantity': quantity,
    };
  }
}