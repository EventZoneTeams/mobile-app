import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/presentation/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Fetch initial batch of events using loadInitialEvents()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventsProvider>(context, listen: false).loadInitialEvents();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      try {
        Provider.of<EventsProvider>(context, listen: false).fetchMoreEvents();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to load more events. Please try again.'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                Provider.of<EventsProvider>(context, listen: false).fetchMoreEvents();
              },
            ),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Consumer<EventsProvider>(
        builder: (context, eventsProvider, child) {
          if (eventsProvider.isLoading && eventsProvider.events.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (eventsProvider.errorMessage.isNotEmpty || eventsProvider.error) { // Handle error state
            return Center(child: Text(eventsProvider.errorMessage));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: eventsProvider.events.length + (eventsProvider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < eventsProvider.events.length) {
                  final event = eventsProvider.events[index];
                  return EventCard(event: event); // Render EventCard for fetched event
                } else if (eventsProvider.hasMore) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ); // Loading indicator for pagination
                } else {
                  return const SizedBox.shrink(); // No more events to load
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
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      final formatter = DateFormat('dd/MM/yyyy h:mm a');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid Date'; // Handle invalid date formats
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.grey[400],
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
                color: Colors.white,
              ),
            ),
            if (event.thumbnailUrl != null && event.thumbnailUrl!.isNotEmpty)
              Image.network(
                event.thumbnailUrl!,
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/event_thumbnail.jpg',
                    height: 150,
                    fit: BoxFit.cover,
                  );
                },
              )
            else // Load asset image if thumbnailUrl is null or empty
              Image.asset(
                'assets/event_thumbnail.jpg',
                height: 150,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8.0),
            if (event.description != null)
              Text(
                'Description: ${event.description}',
                style: const TextStyle(color: Colors.white),
              ),
            Text(
              'Start Date: ${_formatDateTime(event.eventStartDate)}',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'End Date: ${_formatDateTime(event.eventEndDate)}',
              style: const TextStyle(color: Colors.white),
            ),
            if (event.eventCategoryImageUrl.isNotEmpty)
              Image.network(
                event.eventCategoryImageUrl,
                height: 50,
                fit: BoxFit.cover,
              ),
            Text(
              'Category: ${event.eventCategoryName}',
              style: const TextStyle(color: Colors.white),
            ),
            if (event.university != null)
              Text(
                'University: ${event.university}',
                style: const TextStyle(color: Colors.white),
              ),
            Text(
              'Donation: ${event.isDonation ? 'Yes' : 'No'}',
              style: const TextStyle(color: Colors.white),
            ),
            if (event.isDonation)
              Text(
                'Total Cost: \$${event.totalCost}',
                style: const TextStyle(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}