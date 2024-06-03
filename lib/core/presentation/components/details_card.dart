// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:eventzone/core/domain/entities/event.dart';
// import 'package:eventzone/core/domain/entities/event_details.dart';
// import 'package:eventzone/core/presentation/components/slider_card_image.dart';
// import 'package:eventzone/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
//
// import 'package:eventzone/core/resources/app_colors.dart';
// import 'package:eventzone/core/resources/app_values.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DetailsCard extends StatelessWidget {
//   const DetailsCard({
//     required this.eventDetail,
//     required this.detailsWidget,
//     super.key,
//   });
//
//   final EventDetail eventDetail;
//   final Widget detailsWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final size = MediaQuery.of(context).size;
//
//     context
//         .read<WatchlistBloc>()
//         .add(CheckItemAddedEvent(tmdbId: eventDetail.id));
//     return SafeArea(
//       child: Stack(
//         children: [
//           SliderCardImage(imageUrl: eventDetail.thumbnailUrl),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
//             child: SizedBox(
//               height: size.height * 0.6,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: AppPadding.p8),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             eventDetail.name,
//                             maxLines: 2,
//                             style: textTheme.titleMedium,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               top: AppPadding.p4,
//                               bottom: AppPadding.p6,
//                             ),
//                             child: detailsWidget,
//                           ),
//                           // Row(
//                           //   children: [
//                           //     const Icon(
//                           //       Icons.star_rate_rounded,
//                           //       color: AppColors.ratingIconColor,
//                           //       size: AppSize.s18,
//                           //     ),
//                           //     Text(
//                           //       '${eventDetail.voteAverage} ',
//                           //       style: textTheme.bodyMedium,
//                           //     ),
//                           //     Text(
//                           //       mediaDetails.voteCount,
//                           //       style: textTheme.bodySmall,
//                           //     )
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                     ),
//                     // if (mediaDetails.trailerUrl.isNotEmpty) ...[
//                     //   InkWell(
//                     //     onTap: () async {
//                     //       final url = Uri.parse(mediaDetails.trailerUrl);
//                     //       if (await canLaunchUrl(url)) {
//                     //         await launchUrl(url);
//                     //       }
//                     //     },
//                     //     child: Container(
//                     //       height: AppSize.s40,
//                     //       width: AppSize.s40,
//                     //       decoration: const BoxDecoration(
//                     //         color: AppColors.primary,
//                     //         shape: BoxShape.circle,
//                     //       ),
//                     //       child: const Icon(
//                     //         Icons.play_arrow_rounded,
//                     //         color: AppColors.secondaryText,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: AppPadding.p12,
//               left: AppPadding.p16,
//               right: AppPadding.p16,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(AppPadding.p8),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.iconContainerColor,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       color: AppColors.secondaryText,
//                       size: AppSize.s20,
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     eventDetail.isAdded
//                         ? context
//                             .read<WatchlistBloc>()
//                             .add(RemoveWatchListItemEvent(mediaDetails.id!))
//                         : context.read<WatchlistBloc>().add(
//                               AddWatchListItemEvent(
//                                   media: Media.fromMediaDetails(mediaDetails)),
//                             );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(AppPadding.p8),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.iconContainerColor,
//                     ),
//                     child: BlocConsumer<WatchlistBloc, WatchlistState>(
//                       listener: (context, state) {
//                         if (state.status == WatchlistRequestStatus.itemAdded) {
//                           mediaDetails.id = state.id;
//                           mediaDetails.isAdded = true;
//                         } else if (state.status ==
//                             WatchlistRequestStatus.itemRemoved) {
//                           mediaDetails.id = null;
//                           mediaDetails.isAdded = false;
//                         } else if (state.status ==
//                                 WatchlistRequestStatus.isItemAdded &&
//                             state.id != -1) {
//                           mediaDetails.id = state.id;
//                           mediaDetails.isAdded = true;
//                         }
//                       },
//                       builder: (context, state) {
//                         return Icon(
//                           Icons.bookmark_rounded,
//                           color: mediaDetails.isAdded
//                               ? AppColors.primary
//                               : AppColors.secondaryText,
//                           size: AppSize.s20,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
