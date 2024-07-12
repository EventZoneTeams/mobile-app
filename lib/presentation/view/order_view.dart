import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:eventzone/presentation/provider/order_provider.dart';
import 'package:eventzone/presentation/view/order_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _selectedStatus = 'PENDING'; // Set default to 'PENDING'
  List<String> _statusOptions = ['PENDING', 'CANCELLED', 'PAID'];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrders();
    });
  }

  Future<void> _fetchOrders() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    try {
      await orderProvider.fetchOrders();
    } catch (e) {
      // Handle token expiration or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session expired. Please log in again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Add this line
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('My Orders'),
        ),
        actions: [
          // Filter Dropdown on AppBar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            // Add margin for tappable area
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryBackground),
              // Add border
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButtonHideUnderline(
              // Hide default underline
              child: DropdownButton<String>(
                dropdownColor: AppColors.secondaryBackground,
                value: _selectedStatus,
                icon: const Icon(
                  Icons.arrow_drop_down, // Use dropdown icon
                  color: Colors.white,
                ),
                style: const TextStyle(color: Colors.white),
                // Text style for dropdown items
                items: _statusOptions.map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Consumer2<OrderProvider, AccountProvider>(
        builder: (context, orderProvider, accountProvider, child) {
          if (orderProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    orderProvider.errorMessage,
                    textAlign: TextAlign.center, // Center align the text content
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed(AppRoutes.login);
                    },
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            );
          } else if (orderProvider.orders.isNotEmpty) {
            final filteredOrders =
                    orderProvider.orders
                        .where((order) => order.status == _selectedStatus)
                        .toList();

            if (filteredOrders.isEmpty) {
              // Display message for empty filtered orders
              return const Center(
                child: Text('You have no orders with this status.'),
              );
            } else {
              // Display the list of filtered orders
              return RefreshIndicator( // Wrap ListView.builder with RefreshIndicator
                  onRefresh: () async{
                    await _fetchOrders(); // Call _fetchOrders on refresh
                    await Future.delayed(const Duration(milliseconds: 500)); // Add a small delay
                  },
                  child: ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Card(
                    color: AppColors.secondaryBackground,
                    child: ExpansionTile(
                      title: Text(
                        'Order #${order.id} - Status: ${order.status}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Total: \$${order.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      children: [
                        // Order Details List
                        ...order.eventOrderDetails.map((detail) {
                          return ListTile(
                            title: Text(
                              'Package ID: ${detail.packageId}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Quantity: ${detail.quantity} - Price: \$${detail.price.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),

                        // Buttons Row
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderDetailScreen(order: order),
                                    ),
                                  );
                                },
                                child: const Text('View Details'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  orderProvider.cancelOrder(order.id!);
                                  _fetchOrders();

                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Confirm Payment'),
                                      content: const Text('Are you sure you want to pay for this order?', style: const TextStyle(color: AppColors.black),),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false), // Cancel
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true), // Confirm
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirmed == true) {
                                    bool paymentSuccess = false;
                                    String errorMessage = '';
                                    try {
                                      await orderProvider.payOrder(order.id!);
                                      paymentSuccess = true;
                                    } catch (e) {
                                      errorMessage = 'Error: ${e.toString()}';
                                      paymentSuccess = false;
                                    }

                                    // 3. Result Popup
                                    await showDialog(
                                      context: _scaffoldKey.currentContext!, // Use the key here
                                      builder: (context) => AlertDialog(
                                        title: paymentSuccess ? const Text('Payment Successful') : const Text('Payment Failed'),
                                        content: Text(paymentSuccess ? 'Your order has been paid successfully.' : 'Fail to perform pay action, check again and retry!' , style: const TextStyle(color: AppColors.black)),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _fetchOrders(); // Call _fetchOrders after the dialog is dismissed
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Pay'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              );
            }
          } else {
            // Check if user is logged in using AccountProvider
            final isLoggedInFuture = accountProvider.isLoggedIn(); // Call the isLoggedIn function

            return FutureBuilder<bool>(
              future: isLoggedInFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final isLoggedIn = snapshot.data ?? false; // Get the result

                  if (isLoggedIn) {
                    // User is logged in but has no orders overall
                    return const Center(
                      child: Text('You have no orders yet.'),
                    );
                  } else {
                    // User is not logged in or token expired
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You haven\'t logged in or your session has expired.'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.goNamed(AppRoutes.login); // Use context.goNamed with the named route
                            },
                            child: const Text('Go to Login'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            );
          }
        },
      ),
    );
  }
}
