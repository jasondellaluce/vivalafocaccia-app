/// Represents a user present in the system
class User {
  final int id;
  final String name;
  final String email;
  final String featuredImageUrl;

  User({this.id, this.name, this.email, this.featuredImageUrl});
}

/// Represents an authenticated user. This is useful for logging a user on the
/// system, which is performed with a token-based approach.
class AuthUser extends User {
  final String authToken;

  AuthUser({id, name, email, featuredImageUrl, this.authToken})
      : super(
            id: id,
            name: name,
            email: email,
            featuredImageUrl: featuredImageUrl);
}
