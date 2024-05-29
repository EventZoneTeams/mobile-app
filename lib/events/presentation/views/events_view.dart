import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/presentation/components/custom_slider.dart';
import 'package:eventzone/core/presentation/components/error_screen.dart';
import 'package:eventzone/core/presentation/components/loading_indicator.dart';
import 'package:eventzone/core/presentation/components/section_header.dart';
import 'package:eventzone/core/presentation/components/section_listview.dart';
import 'package:eventzone/core/presentation/components/section_listview_card.dart';
import 'package:eventzone/core/presentation/components/slider_card.dart';
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/resources/app_values.dart';
import 'package:eventzone/core/services/service_locator.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_bloc.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_event.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventsBloc>()..add(GetEventsEvent()),
      child: Scaffold(
        body: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return EventsWidget(
                  nowPlayingEvents: state.events[0],
                  popularEvents: state.events[1],
                  topRatedEvents: state.events[2],
                );
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<EventsBloc>().add(GetEventsEvent());
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class EventsWidget extends StatelessWidget {
  final List<Media> nowPlayingEvents;
  final List<Media> popularEvents;
  final List<Media> topRatedEvents;

  const EventsWidget({
    super.key,
    required this.nowPlayingEvents,
    required this.popularEvents,
    required this.topRatedEvents,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSlider(
            itemBuilder: (context, itemIndex, _) {
              return SliderCard(
                media: nowPlayingEvents[itemIndex],
                itemIndex: itemIndex,
              );
            },
          ),
          SectionHeader(
            title: AppStrings.popularEvents,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.popularEventsRoute);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: popularEvents.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(media: popularEvents[index]);
            },
          ),
          SectionHeader(
            title: AppStrings.topRatedEvents,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.topRatedEventsRoute);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: topRatedEvents.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(media: topRatedEvents[index]);
            },
          ),
        ],
      ),
    );
  }
}
