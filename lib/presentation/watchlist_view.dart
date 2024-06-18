import 'package:eventzone/data/model/event_model.dart';
import 'package:eventzone/presentation/watchlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch watchlist events on screen load (assuming you have the userId)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WatchlistProvider>(context, listen: false)
          .fetchWatchlistEvents(0); // Replace userId with the actual user ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Watchlist'),
      ),
      body: Consumer<WatchlistProvider>(
        builder: (context, watchlistProvider, child) {
          if (watchlistProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(watchlistProvider.errorMessage),
            );
          }

          if (watchlistProvider.watchlistEvents.isEmpty) {
            return const Center(
              child: Text('Your watchlist is empty.'),
            );
          }

          return ListView.builder(
            itemCount: watchlistProvider.watchlistEvents.length,
            itemBuilder: (context, index) {
              final event = watchlistProvider.watchlistEvents[index];
              return _buildEventItem(event);
            },
          );
        },
      ),
    );
  }

  Widget _buildEventItem(EventModel event) {
    // Reuse or adapt the event item widget from your EventsScreen
    return ListTile(
      leading: event.thumbnailUrl != null
          ? Image.network(event.thumbnailUrl!)
          : null,
      title: Text(event.name),
      subtitle: Text(event.eventCategoryName),
      onTap: () {
        // Navigate to EventDetailScreen (pass the event)
      },
    );
  }
}