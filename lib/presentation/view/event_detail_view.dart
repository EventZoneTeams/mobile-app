import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:eventzone/data/model/event_detail_model.dart'; // Your model

class EventDetailScreen extends StatelessWidget {
  final EventDetailModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String formattedStartDate =
    DateFormat('MMM d, yyyy').format(event.eventStartDate);
    String formattedEndDate =
    DateFormat('MMM d, yyyy').format(event.eventEndDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Card(
                color: AppColors.secondaryBackground,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          event.userImage ?? 'assets/user_image.jpg',
                        ), // Use NetworkImage directly
                        foregroundImage: const AssetImage('assets/user_image.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Organized by: ${event.userName.isEmpty ? 'AnonymousUser' : event.userName}',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // Image with Fallback using FadeInImage
              FadeInImage.assetNetwork(
                placeholder: 'assets/event_thumbnail.jpg', // Fallback image
                image: event.thumbnailUrl ?? '', // Actual image URL (empty if null)
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/event_thumbnail.jpg'), // Error image
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 16.0),

              // Event Name
              Text(
                event.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8.0),

              // Description
              Text(
                event.description ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 16.0),

              // Event Details Card
              Card(
                color: AppColors.secondaryBackground,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Category:', event.eventCategoryTitle),
                      _buildDetailRow('Event Dates:',
                          '$formattedStartDate - $formattedEndDate'),
                      _buildDetailRow('Location:', event.location),
                      _buildDetailRow('University:', event.university ?? 'None'),
                      _buildDetailRow('Organization Status:', event.status),
                      _buildDetailRow('Total Cost:',
                          '\$${event.totalCost.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(
                    AppRoutes.packages,
                    pathParameters: {'eventId': event.id.toString()},
                  );
                },
                child: const Text('View Event Packages'),
              )
              // ... (Add other sections or buttons as needed)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '$label ',style: const TextStyle(fontWeight: FontWeight.bold),
    ),
      Flexible(
        child: Text(
          value,
          textAlign: TextAlign.end,
        ),
      ),
    ],
    ),
    );
  }
}