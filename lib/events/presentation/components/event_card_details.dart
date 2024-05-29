import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/presentation/components/circle_dot.dart';
import 'package:flutter/material.dart';

class EventCardDetails extends StatelessWidget {
  const EventCardDetails({
    super.key,
    required this.eventDetails,
  });

  final MediaDetails eventDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (eventDetails.releaseDate.isNotEmpty &&
        eventDetails.genres.isNotEmpty &&
        eventDetails.runtime!.isNotEmpty) {
      return Row(
        children: [
          if (eventDetails.releaseDate.isNotEmpty) ...[
            Text(
              eventDetails.releaseDate.split(',')[1],
              style: textTheme.bodyLarge,
            ),
            const CircleDot(),
          ],
          if (eventDetails.genres.isNotEmpty) ...[
            Text(
              eventDetails.genres,
              style: textTheme.bodyLarge,
            ),
            const CircleDot(),
          ] else ...[
            if (eventDetails.runtime!.isNotEmpty) ...[
              const CircleDot(),
            ]
          ],
          Text(
            eventDetails.runtime!,
            style: textTheme.bodyLarge,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
