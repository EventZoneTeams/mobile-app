import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/presentation/components/error_screen.dart';
import 'package:eventzone/core/presentation/components/loading_indicator.dart';
import 'package:eventzone/core/presentation/components/custom_app_bar.dart';
import 'package:eventzone/core/presentation/components/vertical_listview_card.dart';
import 'package:eventzone/core/resources/app_strings.dart';

import 'package:eventzone/core/presentation/components/vertical_listview.dart';
import 'package:eventzone/core/services/service_locator.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/movies/presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';

class TopRatedMoviesView extends StatelessWidget {
  const TopRatedMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TopRatedMoviesBloc>()..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.topRatedMovies,
        ),
        body: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return TopRatedMoviesWidget(movies: state.movies);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<TopRatedMoviesBloc>()
                        .add(GetTopRatedMoviesEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return TopRatedMoviesWidget(movies: state.movies);
            }
          },
        ),
      ),
    );
  }
}

class TopRatedMoviesWidget extends StatelessWidget {
  const TopRatedMoviesWidget({
    required this.movies,
    super.key,
  });

  final List<Media> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return VerticalListViewCard(media: movies[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context
                .read<TopRatedMoviesBloc>()
                .add(FetchMoreTopRatedMoviesEvent());
          },
        );
      },
    );
  }
}
