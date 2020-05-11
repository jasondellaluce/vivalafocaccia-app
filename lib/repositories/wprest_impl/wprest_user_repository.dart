import 'dart:convert';

import 'package:app/models/models.dart';
import '../../core/http_interface.dart';
import '../common.dart';
import '../user_repository.dart';

class WpRestUserRepository implements UserRepository {
  final HttpInterface httpClient;
  final String urlBase;

  WpRestUserRepository(this.httpClient, this.urlBase);

  @override
  Future<AuthUser> authenticateWithCredentials(
      String username, String password) async {
    /// Obtains token from WP JWT authentication plugin endpoint
    final jwtResponse = await httpClient.doPost(
      urlBase,
      '/wp-json/jwt-auth/v1/token',
      body: {
        'username': username,
        'password': password,
      },
    );

    /// Checks and formats eventual errors
    var jwtDecoded = json.decode(jwtResponse.body);
    if (jwtResponse.statusCode < 200 || jwtResponse.statusCode >= 300) {
      throw new UserAuthenticationError(jwtDecoded['message']);
    }

    /// Obtain authentication token and user email
    String token = jwtDecoded['token'];
    String email = jwtDecoded['user_email'];

    /// Obtain user information using the newly obtained token
    final userResponse = await httpClient.doGet(
        urlBase, '/wp-json/wp/v2/users/me',
        headers: {'Authorization': 'Bearer $token'});

    /// Checks and formats eventual errors
    if (userResponse.statusCode < 200 && userResponse.statusCode >= 300) {
      throw new UserAuthenticationError(
          json.decode(userResponse.body)['message']);
    }

    /// Create User object
    var userDecoded = json.decode(userResponse.body);
    return AuthUser(
        id: int.parse(userDecoded['id'].toString()),
        name: userDecoded['name'].toString(),
        email: email,
        featuredImageUrl: userDecoded['avatar_urls']['48'].toString(),
        authToken: token);
  }

  @override
  Future<AuthUser> authenticateWithFacebook(String facebookToken) {
    // TODO: implement authenticateWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> authenticateWithGoogle(String googleToken) {
    // TODO: implement authenticateWithGoogle
    throw UnimplementedError();
  }
}
