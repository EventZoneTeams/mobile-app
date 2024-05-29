import 'package:eventzone/events/data/datasource/events_remote_data_source.dart';
import 'package:eventzone/events/data/repository/events_repository_impl.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';
import 'package:eventzone/events/domain/usecases/get_event_details_usecase.dart';
import 'package:eventzone/events/presentation/controllers/event_details_bloc/event_details_bloc.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_bloc.dart';
import 'package:eventzone/events/presentation/controllers/popular_events_bloc/popular_events_bloc.dart';
import 'package:eventzone/events/presentation/controllers/top_rated_events_bloc/top_rated_events_bloc.dart';
import 'package:eventzone/search/data/datasource/search_remote_data_source.dart';
import 'package:eventzone/search/data/repository/search_repository_impl.dart';
import 'package:eventzone/search/domain/repository/search_repository.dart';
import 'package:eventzone/search/domain/usecases/search_usecase.dart';
import 'package:eventzone/search/presentation/controllers/search_bloc/search_bloc.dart';
import 'package:eventzone/tv_shows/data/datasource/tv_shows_remote_data_source.dart';
import 'package:eventzone/tv_shows/data/repository/tv_shows_repository_impl.dart';
import 'package:eventzone/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_all_popular_tv_shows_usecase.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_all_top_rated_tv_shows_usecase.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_season_details_usecase.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_tv_show_details_usecase.dart';
import 'package:eventzone/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:eventzone/tv_shows/presentation/controllers/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:eventzone/tv_shows/presentation/controllers/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';
import 'package:eventzone/tv_shows/presentation/controllers/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:eventzone/tv_shows/presentation/controllers/tv_shows_bloc/tv_shows_bloc.dart';
import 'package:eventzone/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:eventzone/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:eventzone/watchlist/domain/repository/watchlist_repository.dart';
import 'package:eventzone/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:eventzone/watchlist/domain/usecases/check_if_item_added_usecase.dart';
import 'package:eventzone/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:eventzone/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import 'package:eventzone/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    // Data source
    sl.registerLazySingleton<EventsRemoteDataSource>(
        () => EventsRemoteDataSourceImpl());
    sl.registerLazySingleton<TVShowsRemoteDataSource>(
        () => TVShowsRemoteDataSourceImpl());
    sl.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl());
    sl.registerLazySingleton<WatchlistLocalDataSource>(
        () => WatchlistLocalDataSourceImpl());

    // Repository
    sl.registerLazySingleton<EventsRespository>(
        () => EventsRepositoryImpl(sl()));
    sl.registerLazySingleton<TVShowsRepository>(
        () => TVShowsRepositoryImpl(sl()));
    sl.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(sl()));
    sl.registerLazySingleton<WatchlistRepository>(
        () => WatchListRepositoryImpl(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetEventsDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetEventsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularEventsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedEventsUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => GetTVShowDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetSeasonDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllPopularTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedTVShowsUseCase(sl()));
    sl.registerLazySingleton(() => SearchUseCase(sl()));
    sl.registerLazySingleton(() => GetWatchlistItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => CheckIfItemAddedUseCase(sl()));

    // Bloc
    sl.registerFactory(() => EventsBloc(sl()));
    sl.registerFactory(() => EventDetailsBloc(sl()));
    sl.registerFactory(() => PopularEventsBloc(sl()));
    sl.registerFactory(() => TopRatedEventsBloc(sl()));
    sl.registerFactory(() => TVShowsBloc(sl()));
    sl.registerFactory(() => TVShowDetailsBloc(sl(), sl()));
    sl.registerFactory(() => PopularTVShowsBloc(sl()));
    sl.registerFactory(() => TopRatedTVShowsBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => WatchlistBloc(sl(), sl(), sl(), sl()));
  }
}
