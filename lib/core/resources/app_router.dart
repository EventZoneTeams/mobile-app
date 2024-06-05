import 'package:eventzone/events/presentation/views/events_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/presentation/pages/main_page.dart';
// import 'package:eventzone/tv_shows/presentation/views/tv_show_details_view.dart';
// import 'package:eventzone/tv_shows/presentation/views/tv_shows_view.dart';

import 'package:eventzone/core/resources/app_routes.dart';

import 'package:eventzone/events/presentation/views/event_details_view.dart';

// const String movieDetailsPath = 'movieDetails/:movieId';
const String watchlistPath = '/watchlist';
const String eventsPath = '/events';
const String eventDetailsPath = 'eventsDetails/:eventId';
const String searchPath = '/search';
const String userPath = '/user';

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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsView(),
            ),
            routes: [
              GoRoute(
              name: AppRoutes.eventDetails,
              path: eventDetailsPath,
              pageBuilder: (context, state) => CupertinoPage(
                child: EventDetailsView(
                    eventId: int.parse(state.params['eventId']!),
                  ),
                ),
              ),
              // GoRoute(
              //   name: AppRoutes.eventDetails,
              //   path: eventDetailsPath,
              //   // pageBuilder: (context, state) => const CupertinoPage(
              //   //   child: PopularMoviesView(),
              //   // ),
              // ),
              // GoRoute(
              //   name: AppRoutes.eventDetails,
              //   path: eventDetailsPath,
              //   // pageBuilder: (context, state) => const CupertinoPage(
              //   //   child: TopRatedMoviesView(),
              //   // ),
              // ),
            ],
          ),
          // GoRoute(
          //   name: AppRoutes.eventPackageEvent,
          //   path: eventsPath,
          //   pageBuilder: (context, state) => const NoTransitionPage(
          //     child: TVShowsView(),
          //   ),
          //   routes: [
          //     GoRoute(
          //       name: AppRoutes.eventPackageEvent,
          //       path: eventsPath,
          //       pageBuilder: (context, state) => CupertinoPage(
          //         child: TVShowDetailsView(
          //           tvShowId: int.parse(state.params['tvShowId']!),
          //         ),
          //       ),
          //     ),
          //     GoRoute(
          //       name: AppRoutes.eventPackageEvent,
          //       path: eventsPath,
          //       pageBuilder: (context, state) => const CupertinoPage(
          //         child: PopularTVShowsView(),
          //       ),
          //     ),
          //     GoRoute(
          //       name: AppRoutes.eventPackageEvent,
          //       path: eventsPath,
          //       pageBuilder: (context, state) => const CupertinoPage(
          //         child: TopRatedTVShowsView(),
          //       ),
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   name: AppRoutes.eventPackageEvent,
          //   path: eventsPath,
          //   pageBuilder: (context, state) => const NoTransitionPage(
          //     child: SearchView(),
          //   ),
          // ),
          // GoRoute(
          //   name: AppRoutes.eventPackageEvent,
          //   path: eventsPath,
          //   pageBuilder: (context, state) => const NoTransitionPage(
          //     child: WatchlistView(),
          //   ),
          // ),
        ],
      )
    ],
  );
}
