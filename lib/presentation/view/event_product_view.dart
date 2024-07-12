import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventPackageProductsScreen extends StatelessWidget {
  final EventPackageModel package;

  const EventPackageProductsScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in ${package.description}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: package.productsInPackage.length, // Use productsInPackage
        itemBuilder: (context, index) {
          final product = package.productsInPackage[index]; // Access correct list
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(EventProductModel product) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: AppColors.secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (product.description != null)
              Text(
                product.description!,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 8),
            Text(
              'Price: \$${product.price}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Display product images if available
            if (product.productImages.isNotEmpty)
              ...product.productImages.map((image) => Image.network(image.imageUrl)),
          ],
        ),
      ),
    );
  }
}