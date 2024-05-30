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
  static String userLogin(String uid) {
    return '$user/$uid';
  }

  static String userRegister() {
    return '$user/register';
  }
}
