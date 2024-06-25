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
      final isLoggedIn = await _repository.isLoggedIn();
      if (isLoggedIn) {
        _account = await _repository.getAccountDetails();
      }
    } catch (e) {
      _errorMessage = 'Error checking login status: ${e.toString()}';
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
      _account = await _repository.getAccountDetails(); // Fetch account details after successful login
    } catch (e) {
      _errorMessage = 'Error logging in: ${e.toString()}';
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
      _errorMessage = 'Error registering: ${e.toString()}';
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
      _errorMessage = 'Error logging out: ${e.toString()}';
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
      _errorMessage = 'Error fetching universities: ${e.toString()}';
      return []; // Return an empty list in case of an error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}