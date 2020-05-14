import 'package:app/models/models.dart';
import 'package:app/repositories/repositories.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  final UserRepository userRepository;
  AuthUser _activeUser;
  Error _error;

  AuthenticationService({this.userRepository});

  bool get isLoggedIn => _activeUser != null;
  bool get hasError => _error != null;

  AuthUser get activeUser => _activeUser;
  Error get error => _error;

  void login(String username, String password) async {
    // TODO: Do it for real
    if (_activeUser != null) {
      _error = UserAuthenticationError("Already logged in");
      throw _error;
    } else {
      _error = null;
      _activeUser = AuthUser(id: 1, name: username, email: username);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _activeUser = null;
    _error = null;
    notifyListeners();
  }
}
