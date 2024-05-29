import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/presentation/components/details_card.dart';
import 'package:eventzone/core/presentation/components/error_screen.dart';
import 'package:eventzone/core/presentation/components/loading_indicator.dart';
import 'package:eventzone/core/presentation/components/section_listview.dart';
import 'package:eventzone/core/presentation/components/section_title.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/resources/app_values.dart';
import 'package:eventzone/core/services/service_locator.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/core/utils/functions.dart';
import 'package:eventzone/events/domain/entities/cast.dart';
import 'package:eventzone/events/domain/entities/review.dart';
import 'package:eventzone/events/presentation/components/cast_card.dart';
import 'package:eventzone/events/presentation/components/event_card_details.dart';
import 'package:eventzone/events/presentation/components/review_card.dart';
import 'package:eventzone/events/presentation/controllers/event_details_bloc/event_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsView extends StatelessWidget {
  final int eventId;

  const EventDetailsView({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<EventDetailsBloc>()..add(GetEventDetailsEvent(eventId)),
      child: Scaffold(
        body: BlocBuilder<EventDetailsBloc, EventDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return EventDetailsWidget(eventDetails: state.eventDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<EventDetailsBloc>()
                        .add(GetEventDetailsEvent(eventId));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class EventDetailsWidget extends StatelessWidget {
  const EventDetailsWidget({
    required this.eventDetails,
    super.key,
  });

  final MediaDetails eventDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: eventDetails,
            detailsWidget: EventCardDetails(eventDetails: eventDetails),
          ),
          getOverviewSection(eventDetails.overview),
          _getCast(eventDetails.cast),
          _getReviews(eventDetails.reviews),
          getSimilarSection(eventDetails.similar),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }
}

Widget _getCast(List<Cast>? cast) {
  if (cast != null && cast.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.cast),
        SectionListView(
          height: AppSize.s175,
          itemCount: cast.length,
          itemBuilder: (context, index) => CastCard(
            cast: cast[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}

Widget _getReviews(List<Review>? reviews) {
  if (reviews != null && reviews.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: AppStrings.reviews),
        SectionListView(
          height: AppSize.s175,
          itemCount: reviews.length,
          itemBuilder: (context, index) => ReviewCard(
            review: reviews[index],
          ),
        ),
      ],
    );
  } else {
    return const SizedBox();
  }
}
