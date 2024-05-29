import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/presentation/components/custom_app_bar.dart';
import 'package:eventzone/core/presentation/components/error_screen.dart';
import 'package:eventzone/core/presentation/components/loading_indicator.dart';
import 'package:eventzone/core/presentation/components/vertical_listview.dart';
import 'package:eventzone/core/presentation/components/vertical_listview_card.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/services/service_locator.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/presentation/controllers/top_rated_events_bloc/top_rated_events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedEventsView extends StatelessWidget {
  const TopRatedEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TopRatedEventsBloc>()..add(GetTopRatedEventsEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.topRatedEvents,
        ),
        body: BlocBuilder<TopRatedEventsBloc, TopRatedEventsState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return TopRatedEventsWidget(events: state.events);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<TopRatedEventsBloc>()
                        .add(GetTopRatedEventsEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return TopRatedEventsWidget(events: state.events);
            }
          },
        ),
      ),
    );
  }
}

class TopRatedEventsWidget extends StatelessWidget {
  const TopRatedEventsWidget({
    required this.events,
    super.key,
  });

  final List<Media> events;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedEventsBloc, TopRatedEventsState>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: events.length + 1,
          itemBuilder: (context, index) {
            if (index < events.length) {
              return VerticalListViewCard(media: events[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context
                .read<TopRatedEventsBloc>()
                .add(FetchMoreTopRatedEventsEvent());
          },
        );
      },
    );
  }
}
