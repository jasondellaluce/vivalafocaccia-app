
import 'dart:convert';

import 'package:app/errors.dart';
import 'package:app/model/data/user.dart';
import 'package:http/http.dart' as http;

class WPRestUserRepository implements UserRepository {

  final String _baseUrl;
  final _httpClient = http.Client();
  ActiveUser _activeUser;
  final Map<String, String> _urlHeader = {
    'Authorization': ''
  };

  WPRestUserRepository(this._baseUrl);

  Future<ActiveUser> _authenticateViaJWT(username, password) async {
    final jwtResponse = await _httpClient.post(
      Uri.https(_baseUrl, '/wp-json/jwt-auth/v1/token'),
      body: {
        'username': username,
        'password': password,
      },
    );

    var jwtDecoded = json.decode(jwtResponse.body);
    if (jwtResponse.statusCode < 200 || jwtResponse.statusCode >= 300) {
      throw new AuthenticationError(jwtDecoded['message']);
    }


    String token = jwtDecoded['token'];
    String email = jwtDecoded['user_email'];
    _urlHeader['Authorization'] = 'Bearer $token';

    final userResponse = await _httpClient.get(
        Uri.https(_baseUrl, '/wp-json/wp/v2/users/me'),
        headers: _urlHeader
    );

    if (userResponse.statusCode < 200 && userResponse.statusCode >= 300) {
      throw new AuthenticationError(userResponse.body);
    }

    var userDecoded = json.decode(userResponse.body);

    return ActiveUser(
        int.parse(userDecoded['id'].toString()),
        userDecoded['name'].toString(),
        email,
        userDecoded['avatar_urls']['48'].toString(),
        AuthenticationValue(token)
    );

  }

  @override
  Future<ActiveUser> authenticateWithCredentials({String username,
    String password}) async {
    if(_activeUser != null)
      return _activeUser;
    _activeUser = await _authenticateViaJWT(username, password);
    return _activeUser;
  }

  @override
  Future<ActiveUser> authenticateWithFacebook({String facebookToken}) {
    // TODO: implement authenticateWithFacebook
    throw UnimplementedError("authenticateWithFacebook");
  }

  @override
  Future<ActiveUser> authenticateWithGoogle({String googleToken}) {
    // TODO: implement authenticateWithGoogle
    throw UnimplementedError("authenticateWithGoogle");
  }

  @override
  Future<ActiveUser> getAuthenticatedUser() {
    if(_activeUser != null)
      return Future.value(_activeUser);
    throw new AuthenticationError("Not authenticated yet");
  }

  @override
  bool isAuthenticated() {
    return _activeUser != null;
  }

}