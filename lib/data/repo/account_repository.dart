import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountRepository {
  final AccountRemoteDataSource _remoteDataSource;
  final storage = const FlutterSecureStorage();

  AccountRepository(this._remoteDataSource);

  Future<bool> isLoggedIn() async {
    return await storage.read(key: 'jwt') != null; // Check for JWT existence
  }

  Future<AccountModel?> getAccountDetails() async {
    final jwtToken = await storage.read(key: 'jwt');

    if (jwtToken == null) {
      return null; // Not logged in
    }

    try {
      return await _remoteDataSource.getAccountDetails(jwtToken);
    } catch (e) {
      print('Failed to fetch account details: ${e.toString()}');
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final loginResponse = await _remoteDataSource.login(email, password);
      if ( loginResponse['status'] == true) {
        final jwtToken = loginResponse['jwt'] as String;
        final refreshToken = loginResponse['jwt-refresh-token'] as String;
        await storage.write(key: 'jwt', value: jwtToken);
        await storage.write(key: 'refresh_token', value: refreshToken);
      } else {
        final message = loginResponse['message'] as String? ?? 'Login failed';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }

  Future<void> register(AccountModel account) async {
    // Delegate to remote data source
    await _remoteDataSource.register(account);
  }

  Future<void> logout() async {
    await storage.delete(key: 'jwt');
    await storage.delete(key: 'refresh_token');
    // Potentially clear other relevant data
  }
}