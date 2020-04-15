
import 'package:meta/meta.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String pictureUrl;

  User(this.id, this.name, this.email, this.pictureUrl);
}

class AuthUser extends User {
  final String jwtAuthToken;

  AuthUser(id, name, email, pictureUrl, this.jwtAuthToken)
    : super(id, name, email, pictureUrl);
}

abstract class UserRepository {

  Future<AuthUser> authenticateWithCredentials({
    @required String username,
    @required String password
  });

  Future<AuthUser> authenticateWithGoogle({
    @required String googleToken
  });

  Future<AuthUser> authenticateWithFacebook({
    @required String facebookToken
  });

  Future<AuthUser> getLastAuthUser();

  bool hasAuthUser();

}