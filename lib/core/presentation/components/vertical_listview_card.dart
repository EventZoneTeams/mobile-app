import 'package:flutter/material.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/presentation/components/image_with_shimmer.dart';

import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/core/resources/app_values.dart';
import 'package:eventzone/core/utils/functions.dart';

class VerticalListViewCard extends StatelessWidget {
  const VerticalListViewCard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        // navigateToDetailsView(context, media);
      },
      child: Container(
        height: AppSize.s175,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s8),
                child: ImageWithShimmer(
                  imageUrl: event.thumbnailUrl,
                  width: AppSize.s110,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p6),
                    child: Text(
                      event.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall,
                    ),
                  ),
                  Row(
                    children: [
                      // if (media.releaseDate.isNotEmpty) ...[
                      //   Padding(
                      //     padding: const EdgeInsets.only(right: AppPadding.p12),
                      //     child: Text(
                      //       media.releaseDate.split(', ')[1],
                      //       textAlign: TextAlign.center,
                      //       style: textTheme.bodyLarge,
                      //     ),
                      //   ),
                      // ],
                      const Icon(
                        Icons.star_rate_rounded,
                        color: AppColors.ratingIconColor,
                        size: AppSize.s18,
                      ),
                      Text(
                        '10/10',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p14),
                    child: Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
