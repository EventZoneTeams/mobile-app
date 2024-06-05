import 'package:eventzone/events/presentation/controllers/events_bloc/events_bloc.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/entities/event.dart';
import '../../../core/presentation/components/custom_slider.dart';
import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/presentation/components/section_header.dart';
import '../../../core/presentation/components/section_listview.dart';
import '../../../core/presentation/components/section_listview_card.dart';
import '../../../core/presentation/components/slider_card.dart';
import '../../../core/resources/app_routes.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../controllers/events_bloc/events_state.dart';
// import 'package:movies_app/core/domain/entities/media.dart';
// import 'package:movies_app/core/presentation/components/error_screen.dart';
// import 'package:movies_app/core/presentation/components/loading_indicator.dart';
// import 'package:movies_app/core/presentation/components/slider_card.dart';
// import 'package:movies_app/core/resources/app_routes.dart';
//
// import 'package:movies_app/core/presentation/components/custom_slider.dart';
// import 'package:movies_app/core/presentation/components/section_listview_card.dart';
// import 'package:movies_app/core/presentation/components/section_header.dart';
// import 'package:movies_app/core/presentation/components/section_listview.dart';
// import 'package:movies_app/core/resources/app_strings.dart';
// import 'package:movies_app/core/resources/app_values.dart';
// import 'package:movies_app/core/services/service_locator.dart';
// import 'package:movies_app/core/utils/enums.dart';
// import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
// import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_event.dart';
// import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_state.dart';

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
                  eventList1: state.events,
                  eventList2: state.events,
                  eventList3: state.events,
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
  final List<Event> eventList1;
  final List<Event> eventList2;
  final List<Event> eventList3;

  const EventsWidget({
    super.key,
    required this.eventList1,
    required this.eventList2,
    required this.eventList3,
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
                event: eventList1[itemIndex],
                itemIndex: itemIndex,
              );
            },
          ),
          SectionHeader(
            title: AppStrings.popularMovies,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.event);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: eventList2.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(event: eventList2[index]);
            },
          ),
          SectionHeader(
            title: AppStrings.event,
            onSeeAllTap: () {
              context.goNamed(AppRoutes.event);
            },
          ),
          SectionListView(
            height: AppSize.s240,
            itemCount: eventList3.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(event: eventList3[index]);
            },
          ),
        ],
      ),
    );
  }
}
