import 'package:flutter/material.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/presentation/components/image_with_shimmer.dart';

import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/core/resources/app_values.dart';
// import 'package:eventzone/core/utils/functions.dart';

class SectionListViewCard extends StatelessWidget {
  final Event event;

  const SectionListViewCard({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: AppSize.s120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // navigateToDetailsView(context, event);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: event.thumbnailUrl,
                width: double.infinity,
                height: AppSize.s175,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.ratingIconColor,
                    size: AppSize.s18,
                  ),
                  Text(
                    '10/10',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
