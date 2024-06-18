import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/presentation/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import for date formatting

// ... (Your EventModel and EventsProvider classes)

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Fetch initial batch of events
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventsProvider>(context, listen: false).fetchEvents();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<EventsProvider>(context, listen: false).fetchMoreEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Consumer<EventsProvider>(
        builder: (context, eventsProvider, child) {
          if (eventsProvider.isLoading && eventsProvider.events.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (eventsProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(eventsProvider.errorMessage));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: eventsProvider.events.length + (eventsProvider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < eventsProvider.events.length) {
                  final event = eventsProvider.events[index];
                  return EventCard(event: event);
                } else if (eventsProvider.hasMore) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const SizedBox.shrink(); // Reached the end of the list
                }
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

  const EventCard({super.key, required this.event});

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('dd/MM/yyyy h:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.grey[400], // Added background color for contrast
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
                color: Colors.white, // Improved text contrast
              ),
            ),
            const SizedBox(height: 8.0),
            if (event.description != null)
              Text(
                'Description: ${event.description}',
                style: const TextStyle(color: Colors.white), // Improved text contrast
              ),
            if (event.thumbnailUrl != null)
              CachedNetworkImage(
                imageUrl: event.thumbnailUrl!,
                height: 150, // Fixed height for consistent card heights
                fit: BoxFit.cover, // Maintain aspect ratio and fill space
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            Text(
              'Start Date: ${_formatDateTime(event.eventStartDate)}',
              style: const TextStyle(color: Colors.white), // Improved text contrast
            ),
            Text(
              'End Date: ${_formatDateTime(event.eventEndDate)}',
              style: const TextStyle(color: Colors.white), // Improved text contrast
            ),
            Text(
              'Category: ${event.eventCategoryName}',
              style: const TextStyle(color: Colors.white), // Improved text contrast
            ),
            if (event.university != null)
              Text(
                'University: ${event.university}',
                style: const TextStyle(color: Colors.white), // Improved text contrast
              ),
            Text(
              'Donation: ${event.isDonation ? 'Yes' : 'No'}',
              style: const TextStyle(color: Colors.white), // Improved text contrast
            ),
            if (event.isDonation)
              Text(
                'Total Cost: \$${event.totalCost}',
                style: const TextStyle(color: Colors.white), // Improved text contrast
              ),
          ],
        ),
      ),
    );
  }
}