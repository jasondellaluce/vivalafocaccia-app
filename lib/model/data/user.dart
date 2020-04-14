
import 'package:meta/meta.dart';

/// This class abstracts what kind of data is used for
/// the authentication system. In this way, the JWT token system can be
/// easily replaced
class AuthenticationValue {
  final String token;

  AuthenticationValue(this.token);
}

class User {
  final int id;
  final String name;
  final String email;
  final String pictureUrl;

  User(this.id, this.name, this.email, this.pictureUrl);
}

class ActiveUser extends User {
  final AuthenticationValue authenticationData;

  ActiveUser(id, name, email, pictureUrl, this.authenticationData)
    : super(id, name, email, pictureUrl);
}

abstract class UserRepository {

  Future<ActiveUser> authenticateWithCredentials({
    @required String username,
    @required String password
  });

  Future<ActiveUser> authenticateWithGoogle({
    @required String googleToken
  });

  Future<ActiveUser> authenticateWithFacebook({
    @required String facebookToken
  });

  Future<ActiveUser> getAuthenticatedUser();

  bool isAuthenticated();

}