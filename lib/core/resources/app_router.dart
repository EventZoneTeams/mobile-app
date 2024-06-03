import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/presentation/pages/main_page.dart';
// import 'package:eventzone/tv_shows/presentation/views/tv_show_details_view.dart';
// import 'package:eventzone/tv_shows/presentation/views/tv_shows_view.dart';

import 'package:eventzone/core/resources/app_routes.dart';

const String eventsPath = '/events';
// const String movieDetailsPath = 'movieDetails/:movieId';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: eventsPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.event,
            path: eventsPath,
            // pageBuilder: (context, state) => const NoTransitionPage(
            //   child: MoviesView(),
            // ),
            routes: [
              GoRoute(
                name: AppRoutes.eventPackageEvent,
                path: movieDetailsPath,
                // pageBuilder: (context, state) => CupertinoPage(
                //   child: MovieDetailsView(
                //     movieId: int.parse(state.params['movieId']!),
                //   ),
                ),
              ),
              GoRoute(
                name: AppRoutes.popularMoviesRoute,
                path: popularMoviesPath,
                // pageBuilder: (context, state) => const CupertinoPage(
                //   child: PopularMoviesView(),
                // ),
              ),
              GoRoute(
                name: AppRoutes.topRatedMoviesRoute,
                path: topRatedMoviesPath,
                // pageBuilder: (context, state) => const CupertinoPage(
                //   child: TopRatedMoviesView(),
                // ),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.tvShowsRoute,
            path: tvShowsPath,
            // pageBuilder: (context, state) => const NoTransitionPage(
            //   child: TVShowsView(),
            // ),
            routes: [
              GoRoute(
                name: AppRoutes.tvShowDetailsRoute,
                path: tvShowDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  // child: TVShowDetailsView(
                  //   tvShowId: int.parse(state.params['tvShowId']!),
                  // ),
                ),
              ),
              GoRoute(
                name: AppRoutes.popularTvShowsRoute,
                path: popularTVShowsPath,
                // pageBuilder: (context, state) => const CupertinoPage(
                //   child: PopularTVShowsView(),
                // ),
              ),
              GoRoute(
                name: AppRoutes.topRatedTvShowsRoute,
                path: topRatedTVShowsPath,
                // pageBuilder: (context, state) => const CupertinoPage(
                //   child: TopRatedTVShowsView(),
                // ),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.searchRoute,
            path: searchPath,
            // pageBuilder: (context, state) => const NoTransitionPage(
            //   child: SearchView(),
            // ),
          ),
          GoRoute(
            name: AppRoutes.watchlistRoute,
            path: watchlistPath,
            // pageBuilder: (context, state) => const NoTransitionPage(
            //   child: WatchlistView(),
            // ),
          ),
        ],
      )
    ],
  );
}
