import 'package:eventzone/presentation/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eventzone/data/model/event_model.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventsProvider>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Consumer<EventsProvider>(
        builder: (context, eventsProvider, child) {
          if (eventsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (eventsProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(eventsProvider.errorMessage));
          } else {
            return ListView.builder(
              itemCount: eventsProvider.events.length,
              itemBuilder: (context, index) {
                final event = eventsProvider.events[index];
                return EventCard(event: event); // Use the custom EventCard
              },
            );
          }
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            if (event.description != null)
              Text('Description: ${event.description}'),
            if (event.thumbnailUrl != null)
              Image.network(event.thumbnailUrl!),
            Text('Start Date: ${event.eventStartDate}'),
            Text('End Date: ${event.eventEndDate}'),
            Text('Category: ${event.eventCategoryName}'),
            if (event.university != null)
              Text('University: ${event.university}'),
            Text('Donation: ${event.isDonation ? 'Yes' : 'No'}'),
            if (event.isDonation)
              Text('Total Cost: \$${event.totalCost}'),
          ],
        ),
      ),
    );
  }
}