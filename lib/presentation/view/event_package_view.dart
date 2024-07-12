import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:eventzone/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventzone/presentation/provider/event_provider.dart';

class EventPackagesScreen extends StatefulWidget {
  final int eventId;

  const EventPackagesScreen({super.key, required this.eventId});

  @override
  State<EventPackagesScreen> createState() => _EventPackagesScreenState();
}

class _EventPackagesScreenState extends State<EventPackagesScreen> {
  @override
  void initState() {
    super.initState();
    _clearCartIfNecessary();
    _fetchEventPackages(); // Fetch packages on screen load
  }

  Future<void> _fetchEventPackages() async {
    final eventsProvider = Provider.of<EventsProvider>(context, listen: false);
    await eventsProvider.fetchEventPackagesForEvent(widget.eventId);
  }

  @override
  void didUpdateWidget(EventPackagesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.eventId != widget.eventId) {
      _clearCartIfNecessary();
      _fetchEventPackages(); // Fetch packages when eventId changes
    }
  }

  void _clearCartIfNecessary() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.clearCart();
  }

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventsProvider>(context); // Listen to changes

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Packages'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              context.push("/events/${widget.eventId}/packages/cart");
            },
          ),
        ],
      ),
      body: eventsProvider.isLoadingPackages // Handle loading state
          ? const Center(child: CircularProgressIndicator())
          : eventsProvider.packageErrorMessage.isNotEmpty
          ? Center(child: Text(eventsProvider.packageErrorMessage))
          : ListView.builder(
        itemCount: eventsProvider.eventPackages.length,
        itemBuilder: (context, index) {
          final package = eventsProvider.eventPackages[index];
          return _buildPackageCard(context, package);
        },
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, EventPackageModel package) {
    int quantity = 1;
    final _formKey = GlobalKey<FormState>(); // Form key for validation

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${package.description} to Cart'),
        content: Form( // Wrap content in a Form
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price: \$${package.totalPrice}'),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: quantity.toString(),
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (value) { // Add validator
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  final parsedQuantity = int.tryParse(value);
                  if (parsedQuantity == null) {
                    return 'Please enter a valid number';
                  }
                  if (parsedQuantity < 1) {
                    return 'Quantity must be at least 1';
                  }
                  return null; // Return null if input is valid
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) { // Validate before adding
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                cartProvider.addToCart(package, quantity);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${package.description} added to cart')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: const Text('Login Required'),
          content: const Text('You need to be logged in to add items to cart.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.pushNamed(AppRoutes.login);
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
    );
  }

  Widget _buildPackageCard(BuildContext context, EventPackageModel package) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: AppColors.secondaryBackground,
      child: InkWell(
        onTap: () {
          context.pushNamed(
            AppRoutes.packageProducts,
            pathParameters: {
              'eventId': widget.eventId.toString(), // Use widget.eventId
              'packageId': package.id.toString()
            },
            extra: package,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (package.thumbnailUrl.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: package.thumbnailUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              const SizedBox(height: 8),
              Text(
                package.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total Price: \$${package.totalPrice}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final accountProvider = Provider.of<AccountProvider>(context, listen: false);
                    if (await accountProvider.isLoggedIn()) {
                      _showAddToCartDialog(context, package);
                    } else {
                      _showLoginPrompt(context);
                    }
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}