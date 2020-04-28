
import 'package:app/core/http_interface.dart';
import 'package:app/repositories/repositories.dart';
import 'package:app/models/models.dart';
import 'package:app/repositories/wprest_impl/wprest_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io' show Platform;

void main() {
  UserRepository repository;
  Map<String, String> envVars;

  setUp(() {
    repository = new WpRestUserRepository(
        NetworkHttpInterface(), 'vivalafocaccia.com');
    envVars = Platform.environment;
  });

  test("WpRestUserAuthenticator - authenticateWithCredentials", () {
    var result = repository.authenticateWithCredentials(
        envVars["TEST_AUTH_USERNAME"], envVars["TEST_AUTH_PASSWORD"]);
    expect(result.then((value) => value is AuthUser), completion(equals(true)));
    expect(result.then((value) => value.name),
        completion(equals(envVars["TEST_AUTH_USER_NAME"])));
  });

}