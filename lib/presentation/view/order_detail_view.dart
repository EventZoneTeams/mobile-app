import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/data/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id} Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondaryBackground,
        ),
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Order Summary
            Text('Event ID: ${order.eventId}'),
            // ... (fetch and display event name or other details if available)
            Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
            Text('Status: ${order.status}'),
            const SizedBox(height: 16),

            // Order Details
            const Text(
              'Order Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...order.eventOrderDetails.map((detail) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text('Package ID: ${detail.packageId}'),
                  // ... (fetch and display package name or other details)
                  subtitle: Text(
                    'Quantity: ${detail.quantity} - Price: \$${detail.price.toStringAsFixed(2)}',
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}