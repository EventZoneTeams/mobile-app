import 'package:eventzone/tv_shows/domain/usecases/get_season_details_usecase.dart';

class ApiConstants {
  static const String baseUrl = '1';

  static const String event = '$baseUrl/events';

  static const String user = '$baseUrl/users';

  static const String category = '$baseUrl/event-categories';

  static const String eventPackage = '$baseUrl/event-packages';

  static const String eventProduct = '$baseUrl/event-products';

  // static const String eventPost = '$baseUrl/event-products';
  //
  // static const String eventComment = '$baseUrl/event-products';
  //
  // static const String eventPicture = '$baseUrl/event-products';
  //
  // static const String eventFeedback = '$baseUrl/event-products';

  // movies paths
  static String userLogin(String uid)
  {
    return  '$user/$uid';
  }

  static String userRegister(String )

  static const String topRatedMoviesPath =

  static String getMovieDetailsPath(int movieId) {
  }

  static String getAllPopularMoviesPath(int page) {
  }

  static String getAllTopRatedMoviesPath(int page) {
  }

  // tv shows paths
  static const String onAirTvShowsPath =

  static const String popularTvShowsPath =

  static const String topRatedTvShowsPath =

  static String getTvShowDetailsPath(int tvShowId) {
  }

  static String getSeasonDetailsPath(SeasonDetailsParams params) {
  }

  static String getAllPopularTvShowsPath(int page) {
  }

  static String getAllTopRatedTvShowsPath(int page) {
  }

  // search paths
  static String getSearchPath(String title) {
  }
}
