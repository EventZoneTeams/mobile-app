import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventzone/core/domain/entities/event_details.dart';
import 'package:eventzone/core/presentation/components/error_screen.dart';
import 'package:eventzone/core/presentation/components/section_listview.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/resources/app_values.dart';
import 'package:eventzone/core/utils/enums.dart';
import 'package:eventzone/core/utils/functions.dart';
import 'package:eventzone/movies/domain/entities/cast.dart';
import 'package:eventzone/movies/domain/entities/review.dart';
import 'package:eventzone/movies/presentation/components/cast_card.dart';
import 'package:eventzone/movies/presentation/components/movie_card_details.dart';
import 'package:eventzone/movies/presentation/components/review_card.dart';
import 'package:eventzone/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';

import 'package:eventzone/core/presentation/components/loading_indicator.dart';
import 'package:eventzone/core/presentation/components/details_card.dart';
import 'package:eventzone/core/presentation/components/section_title.dart';
import 'package:eventzone/core/services/service_locator.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<MovieDetailsBloc>()..add(GetMovieDetailsEvent(movieId)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return MovieDetailsWidget(movieDetails: state.movieDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<MovieDetailsBloc>()
                        .add(GetMovieDetailsEvent(movieId));
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
    required this.movieDetails,
    super.key,
  });

  final MediaDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: movieDetails,
            detailsWidget: MovieCardDetails(movieDetails: movieDetails),
          ),
          getOverviewSection(movieDetails.overview),
          _getCast(movieDetails.cast),
          _getReviews(movieDetails.reviews),
          getSimilarSection(movieDetails.similar),
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
