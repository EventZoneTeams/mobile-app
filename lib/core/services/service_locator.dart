import 'package:eventzone/events/data/repository/events_repository_imp.dart';
import 'package:eventzone/events/domain/repository/events_repository.dart';
import 'package:eventzone/events/domain/usecases/get_event_details_usecase.dart';
import 'package:eventzone/events/domain/usecases/get_events_usecase.dart';
import 'package:get_it/get_it.dart';

import 'package:eventzone/events/data/datasource/events_remote_data_source.dart';
import 'package:eventzone/events/presentation/controllers/event_details_bloc/event_details_bloc.dart';
import 'package:eventzone/events/presentation/controllers/events_bloc/events_bloc.dart';

// import 'package:eventzone/movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
// import 'package:eventzone/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
// import 'package:eventzone/watchlist/data/datasource/watchlist_local_data_source.dart';
// import 'package:eventzone/watchlist/data/repository/watchlist_repository_impl.dart';
// import 'package:eventzone/watchlist/domain/repository/watchlist_repository.dart';
// import 'package:eventzone/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
// import 'package:eventzone/watchlist/domain/usecases/check_if_item_added_usecase.dart';
// import 'package:eventzone/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
// import 'package:eventzone/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
// import 'package:eventzone/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    // Data source
    sl.registerLazySingleton<EventsRemoteDataSource>(
        () => EventsRemoteDataSourceImpl());

    // Repository
    sl.registerLazySingleton<EventsRespository>(
        () => EventsRepositoryImp(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetEventDetailUseCase(sl()));
    sl.registerLazySingleton(() => GetEventsUseCase(sl()));
    // sl.registerLazySingleton(() => GetAllPopularEventsUseCase(sl()));

    // Bloc
    sl.registerFactory(() => EventsBloc(sl()));
    sl.registerFactory(() => EventDetailsBloc(sl()));
  }
}
