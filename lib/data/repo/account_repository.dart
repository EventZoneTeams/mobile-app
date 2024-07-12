import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/model/secure_storage.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';

class AccountRepository {
  final AccountRemoteDataSource _remoteDataSource;

  AccountRepository(this._remoteDataSource);

  Future<bool> isLoggedIn() async {
    return await StorageService.secureStorage.read(key: 'jwt') != null;
  }

  Future<AccountModel?> getAccountDetails() async {
    final jwtToken = await StorageService.secureStorage.read(key: 'jwt');
    if (jwtToken == null) {
      return null; // Not logged in
    }

    try {
      final result = await _remoteDataSource.getAccountDetails(jwtToken);
      await StorageService.secureStorage.write(key: 'userId', value: result.id.toString());
      return result;
    } catch (e) {
      StorageService.secureStorage.delete(key: 'jwt');
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final loginResponse = await _remoteDataSource.login(email, password);
      if (loginResponse['status'] == true) {
        final jwtToken = loginResponse['jwt'] as String;
        final refreshToken = loginResponse['jwt-refresh-token'] as String;
        await StorageService.secureStorage.write(key: 'jwt', value: jwtToken);
        await StorageService.secureStorage.write(key: 'refresh_token', value: refreshToken);
      } else {
        final message = loginResponse['message'] as String? ?? 'Login failed';
        throw Exception(message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(RegisterAccountModel account) async {
    await _remoteDataSource.register(account);
  }

  Future<void> logout() async {
    await StorageService.secureStorage.delete(key: 'jwt');
    await StorageService.secureStorage.delete(key: 'refresh_token');
  }

  Future<List<UniversityModel>> getUniversities() async {
    return await _remoteDataSource.getUniversities();
  }

  Future<String?> createTransaction(int amount) async {
    final token = await StorageService.secureStorage.read(key: 'jwt');
    if (token == null || token.isEmpty) throw Exception("jwt null");
    return _remoteDataSource.createTransaction(token, amount);
  }
}