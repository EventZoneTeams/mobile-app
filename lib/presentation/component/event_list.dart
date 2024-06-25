import 'package:eventzone/presentation/component/event_card_view.dart';
import 'package:eventzone/presentation/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListView extends StatelessWidget {
  final ScrollController scrollController;

  const EventListView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder: (context, eventsProvider, child) {
        if (eventsProvider.isLoading && eventsProvider.events.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (eventsProvider.errorMessage.isNotEmpty ||
            eventsProvider.error) {
          return Center(child: Text(eventsProvider.errorMessage));
        } else {
          return ListView.builder(
            controller: scrollController,
            itemCount: eventsProvider.events.length +
                (eventsProvider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < eventsProvider.events.length) {
                final event = eventsProvider.events[index];
                return EventCard(event: event);
              } else if (eventsProvider.hasMore) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        }
      },
    );
  }
}