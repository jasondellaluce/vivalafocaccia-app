abstract class _BaseError {
  final String message;

  const _BaseError(this.message);

  @override
  String toString() {
    return message;
  }
}

class DataRetrieveError extends _BaseError {
  const DataRetrieveError(message) : super(message);
}

class AuthenticationError extends _BaseError {
  const AuthenticationError(message) : super(message);
}
