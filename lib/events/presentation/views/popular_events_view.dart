import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/presentation/components/custom_app_bar.dart';
import 'package:eventzone/core/presentation/components/error_screen.dart';
import 'package:eventzone/core/presentation/components/loading_indicator.dart';
import 'package:eventzone/core/presentation/components/vertical_listview.dart';
import 'package:eventzone/core/presentation/components/vertical_listview_card.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/services/service_locator.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/events/presentation/controllers/popular_events_bloc/popular_events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularEventsView extends StatelessWidget {
  const PopularEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<PopularEventsBloc>()..add(GetPopularEventsEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.popularEvents,
        ),
        body: BlocBuilder<PopularEventsBloc, PopularEventsState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return PopularEventsWidget(events: state.events);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<PopularEventsBloc>()
                        .add(GetPopularEventsEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return PopularEventsWidget(events: state.events);
            }
          },
        ),
      ),
    );
  }
}

class PopularEventsWidget extends StatelessWidget {
  const PopularEventsWidget({
    required this.events,
    super.key,
  });

  final List<Media> events;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularEventsBloc, PopularEventsState>(
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
                .read<PopularEventsBloc>()
                .add(FetchMorePopularEventsEvent());
          },
        );
      },
    );
  }
}
