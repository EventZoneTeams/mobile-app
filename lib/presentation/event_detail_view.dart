import 'package:flutter/material.dart';

import 'package:eventzone/data/model/event_detail_model.dart'; // Your model

class EventDetailScreen extends StatelessWidget {
  final EventDetailModel event;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image
              if (event.thumbnailUrl != null)
                Image.network(event.thumbnailUrl!),

              // 2. Event Name
              Text(
                event.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              // 3. Event Category (with Image)
              Row(
                children: [
                  Text('Category: ${event.eventCategoryName}'),
                  if (event.eventCategoryImageUrl.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.network(
                        event.eventCategoryImageUrl,
                        height: 20, // Adjust size as needed
                        width: 20,
                      ),
                    ),
                ],
              ),

              // 4. Description
              if (event.description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(event.description!),
                ),

              // 5. Event Dates
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Event Dates: ${event.eventStartDate} - ${event.eventEndDate}',
                ),
              ),

              // 6. Donation Dates (if applicable)
              if (event.isDonation)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Donation Dates: ${event.donationStartDate} - ${event.donationEndDate}',
                  ),
                ),

              // 7. Location
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Location: ${event.location}'),
              ),

              // 8. University
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('University: ${event.university}'),
              ),

              // 9. Organization Status
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Organization Status: ${event.organizationStatus}'),
              ),

              // 10. Total Cost (if donation)
              if (event.isDonation)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Total Cost: \$${event.totalCost.toStringAsFixed(2)}'),
                ),

              // ... (Add other details or buttons as needed)
            ],
          ),
        ),
      ),
    );
  }
}