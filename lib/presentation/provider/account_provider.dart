import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/data/repo/account_repository.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  final AccountRepository _repository;
  AccountModel? _account;
  bool _isLoading = false;
  String _errorMessage = '';

  AccountProvider(this._repository);

  AccountModel? get account => _account;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      var isLoggedIn = await _repository.isLoggedIn();
      if (isLoggedIn) {
        _account = await _repository.getAccountDetails();
      }
    } catch (e) {
      _errorMessage = 'Error checking login status: ${e.toString()}';
      logout();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _repository.login(email, password);
      _account = await _repository.getAccountDetails();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(RegisterAccountModel account) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _repository.register(account);
      // You might want to automatically log in the user after registration
      // ...
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _repository.logout();
      _account = null; // Clear account details after logout
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<List<UniversityModel>> fetchUniversities() async {
    _isLoading = true;
    notifyListeners();

    try {
      return await _repository.getUniversities();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<String> createTransaction(int amount) async {
    try {
      final url = await _repository.createTransaction(amount);
        return url??'';
    } catch (e) {
      // Handle the exception (e.g., display an error message)
      _errorMessage = 'Failed to create transaction: ${e.toString()}';
      notifyListeners();
      return ''; // Or rethrow the exception if needed
    }
  }
  Future<bool> isLoggedIn() async {
    return await _repository.isLoggedIn();
  }
  // String extractHashKeyFromUrl(String url) {
  //   // Find the start of the hashkey parameter
  //   int startIndex = url.indexOf('vnp_SecureHash=');
  //   if (startIndex == -1) {
  //     return ''; // Hashkey not found
  //   }

  //   // Find the end of the hashkey (either end of string or '&' for next parameter)
  //   int endIndex = url.indexOf('&', startIndex + 'vnp_SecureHash='.length);
  //   if (endIndex == -1) {
  //     endIndex = url.length; // Hashkey is the last parameter
  //   }
  //
  //   // Extract the hashkey substring
  //   return url.substring(startIndex + 'vnp_SecureHash='.length, endIndex);
  // }
}