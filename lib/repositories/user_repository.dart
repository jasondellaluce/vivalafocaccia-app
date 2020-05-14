import 'package:app/models/models.dart';

/// Interface that represents a data repository for classes of the legacy.model.
/// It is compliant with the CRUD operations standard. Every result is wrapped
/// in a [Future] object in order to abstract the underlying implementation,
/// that can most likely work with asynchronous operations that mey involve
/// FileSystem, Network communications, and more. Every method can fail
/// and throw error that can be caught with proper handlers in the returned
/// futures.
abstract class UserRepository {
  /// Perform user authentication using regular username-password credentials
  /// pair. The returned user object will contain access info that will allow
  /// authenticated access to other functionality of the system.
  Future<AuthUser> authenticateWithCredentials(
      String username, String password);

  /// Perform user authentication using Google's authentication token.
  /// The returned user object will contain access info that will allow
  /// authenticated access to other functionality of the system.
  Future<AuthUser> authenticateWithGoogle(String googleToken);

  /// Perform user authentication using Facebooks's authentication token.
  /// The returned user object will contain access info that will allow
  /// authenticated access to other functionality of the system.
  Future<AuthUser> authenticateWithFacebook(String facebookToken);

  /// Performs deauthentication of a given pre-authenticated user.
  Future<void> deauthenticate(AuthUser user);
  
}
