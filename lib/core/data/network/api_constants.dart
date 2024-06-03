class ApiConstants {
  static const String baseUrl = 'https://eventzone.azurewebsites.net/api/v1';

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
  static String userLogin(int uid) {
    return '$user/$uid';
  }

  static String userRegister() {
    return '$user/register';
  }

  static String getEventDetailPath(int eventId){
    return '$event/$eventId';
  }
}
