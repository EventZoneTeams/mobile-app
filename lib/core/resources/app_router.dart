import 'package:eventzone/core/presentation/pages/main_page.dart';
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/search/presentation/views/search_view.dart';
import 'package:eventzone/tv_shows/presentation/views/popular_tv_shows_view.dart';
import 'package:eventzone/tv_shows/presentation/views/top_rated_tv_shows_view.dart';
import 'package:eventzone/tv_shows/presentation/views/tv_show_details_view.dart';
import 'package:eventzone/tv_shows/presentation/views/tv_shows_view.dart';
import 'package:eventzone/watchlist/presentation/views/watchlist_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

const String eventsPath = '/events';
const String eventDetailsPath = 'eventDetails/:eventId';
const String popularEventsPath = 'popularEvents';
const String topRatedEventsPath = 'topRatedEvents';
const String tvShowsPath = '/tvShows';
const String tvShowDetailsPath = 'tvShowDetails/:tvShowId';
const String popularTVShowsPath = 'popularTVShows';
const String topRatedTVShowsPath = 'topRatedTVShows';
const String searchPath = '/search';
const String watchlistPath = '/watchlist';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: eventsPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.eventsRoute,
            path: eventsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsView(),
            ),
            routes: [
              GoRoute(
                name: AppRoutes.eventDetailsRoute,
                path: eventDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  child: EventDetailsView(
                    eventId: int.parse(state.params['eventId']!),
                  ),
                ),
              ),
              GoRoute(
                name: AppRoutes.popularEventsRoute,
                path: popularEventsPath,
                pageBuilder: (context, state) => const CupertinoPage(
                  child: PopularEventsView(),
                ),
              ),
              GoRoute(
                name: AppRoutes.topRatedEventsRoute,
                path: topRatedEventsPath,
                pageBuilder: (context, state) => const CupertinoPage(
                  child: TopRatedEventsView(),
                ),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.tvShowsRoute,
            path: tvShowsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TVShowsView(),
            ),
            routes: [
              GoRoute(
                name: AppRoutes.tvShowDetailsRoute,
                path: tvShowDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  child: TVShowDetailsView(
                    tvShowId: int.parse(state.params['tvShowId']!),
                  ),
                ),
              ),
              GoRoute(
                name: AppRoutes.popularTvShowsRoute,
                path: popularTVShowsPath,
                pageBuilder: (context, state) => const CupertinoPage(
                  child: PopularTVShowsView(),
                ),
              ),
              GoRoute(
                name: AppRoutes.topRatedTvShowsRoute,
                path: topRatedTVShowsPath,
                pageBuilder: (context, state) => const CupertinoPage(
                  child: TopRatedTVShowsView(),
                ),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.searchRoute,
            path: searchPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchView(),
            ),
          ),
          GoRoute(
            name: AppRoutes.watchlistRoute,
            path: watchlistPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WatchlistView(),
            ),
          ),
        ],
      )
    ],
  );
}
