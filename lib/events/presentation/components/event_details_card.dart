import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/components/circle_dot.dart';

class EventCardDetails extends StatelessWidget {
  const EventCardDetails({
    super.key,
    required this.eventDetails,
  });

  final EventDetail eventDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
      return Row(
        children: [
            Text(
              eventDetails.eventStartDate,
              style: textTheme.bodyLarge,
            ),
            const CircleDot(),
          Text(
              eventDetails.eventCategoryId.toString(),
              style: textTheme.bodyLarge,
            ),
            const CircleDot(),
          Text(
            eventDetails.location,
            style: textTheme.bodyLarge,
          ),
          const CircleDot(),
        ],
      );
    }
}
