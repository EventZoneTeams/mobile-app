import 'package:eventzone/core/data/network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}

class DatabaseException implements Exception {}
class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException(this.message);
}