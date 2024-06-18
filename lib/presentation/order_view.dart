// orders_view.dart
import 'package:eventzone/presentation/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders on screen load (assuming you have the userId)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false)
          .fetchOrders(0); // Replace userId with the actual user ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(orderProvider.errorMessage),
            );
          }

          if (orderProvider.orders.isEmpty) {
            return const Center(
              child: Text('You have no orders yet.'),
            );
          }

          return ListView.builder(
            itemCount: orderProvider.orders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.orders[index];
              return ExpansionTile(
                title: Text('Order #${order.id} - Status: ${order.status}'),
                subtitle: Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                children: order.orderDetails?.map((detail) {
                  return ListTile(
                    title: Text('Package ID: ${detail.packageId}'),
                    subtitle: Text(
                      'Quantity: ${detail.quantity} - Price: \$${detail.price.toStringAsFixed(2)}',
                    ),
                  );
                }).toList() ?? [], // Handle null orderDetails
              );
            },
          );
        },
      ),
    );
  }
}