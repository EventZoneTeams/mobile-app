import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/data/model/order_model.dart';
import 'package:eventzone/presentation/provider/cart_provider.dart';
import 'package:eventzone/presentation/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final int eventId; // Declare eventId parameter

  const CartScreen({super.key, required this.eventId}); // Update constructor

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }

          return ListView.builder(
            itemCount: cartProvider.items.length,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.items.values.elementAt(index);
              return Card(
                margin: const EdgeInsets.all(8.0),
                color: AppColors.secondaryBackground,
                child: ListTile(
                  leading: cartItem.package.thumbnailUrl.isNotEmpty
                      ? Image.network(cartItem.package.thumbnailUrl)
                      : const Icon(Icons.image), // Placeholder if no image
                  title: Text(cartItem.package.description, style:  const TextStyle(color: Colors.white),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price: \$${cartItem.package.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Quantity: ${cartItem.quantity}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Total: \$${cartItem.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white), // Set icon color to white
                    onPressed: () {
                      cartProvider.removeFromCart(cartItem.package.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (cartProvider.items.isNotEmpty) {
                      // 1. Prepare Order Details
                      List<OrderDetail> orderDetails = cartProvider.items.entries.map((entry) {
                        return OrderDetail(
                          id: eventId, // Assuming API assigns ID
                          packageId: entry.key,
                          eventOrderId: 0, // Assuming API assigns ID
                          quantity: entry.value.quantity,
                          price: entry.value.totalPrice.toInt(), // Adjust if needed
                        );
                      }).toList();

                      // 2. Create Order Object (Get eventId from context or state)
                      Order newOrder = Order(
                        eventId: eventId,
                        totalAmount: cartProvider.totalPrice.toInt(), // Adjust if needed
                        status: 'PENDING', // Or any initial status
                        eventOrderDetails: orderDetails,
                      );

                      // 3. Call createOrder from OrderProvider
                      await orderProvider.createOrder(newOrder);

                      // 4. Handle Success/Error (Clear cart, show messages, etc.)
                      // TODO: Implement success/error handling
                      if (orderProvider.errorMessage.isEmpty) {
                        // Order created successfully
                        cartProvider.clearCart(); // Clear the cart
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order created successfully!')),
                        );
                      } else {
                        // Error creating order
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error creating order: ${orderProvider.errorMessage}')),
                        );
                      }
                    }
                  },
                  child: const Text('Create Order'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}