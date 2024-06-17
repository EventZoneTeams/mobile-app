class Order {
  final int id;
  final int eventId;
  final int userId;
  final double totalAmount;
  final String status;
  final List<OrderDetail>? orderDetails; // Can be null initially, loaded on demand

  Order({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.totalAmount,
    required this.status,
    this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      eventId: json['event-id'] as int,
      userId: json['user-id'] as int,
      totalAmount: (json['total-amount'] as num).toDouble(),
      status: json['status'] as String,
      orderDetails: (json['event-order-details'] as List<dynamic>?)
          ?.map((detail) => OrderDetail.fromJson(detail as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OrderDetail {
  final int id;
  final int packageId;
  final int eventOrderId;
  final int quantity;
  final double price;

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
      price: (json['price'] as num).toDouble(),
    );
  }
}