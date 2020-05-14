import 'package:app/legacy/common/errors.dart';
import 'package:app/models/models.dart';
import 'package:app/repositories/repositories.dart';
import 'package:flutter/material.dart';

// TODO: Persist token (SharedPreferences maybe?)
class AuthenticationService extends ChangeNotifier {

  final UserRepository userRepository;
  AuthUser _activeUser;
  var _error;

  AuthenticationService({this.userRepository});

  bool get isLoggedIn => _activeUser != null;
  bool get hasError => _error != null;

  AuthUser get activeUser => _activeUser;
  get error => _error;

  Future<void> login(String username, String password) async {
    try {
      if(_activeUser != null) {
        throw AuthenticationError("Another user is already logged in, You have to log them out first.");
      }
      AuthUser newUser = await userRepository.authenticateWithCredentials(username, password);
      _activeUser = newUser;
    }
    catch(e) {
      _error = e;
      throw e;
    }
    finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      if(_activeUser == null) {
        throw AuthenticationError("There is no logged user, execute a login first.");
      }
      await userRepository.deauthenticate(_activeUser);
      _activeUser = null;
      _error = null;
    }
    catch(e) {
      _error = e;
      throw e;
    }
    finally {
      notifyListeners();
    }
  }
  
}
