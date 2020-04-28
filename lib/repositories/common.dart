/// Enumerates the basic order in which results of a read request can
/// be disposed, which can be either in ascending or descending order.
enum ReadOrderType {
  asc, desc
}

class RepositoryInvalidRequestError extends Error {
  final String message;

  RepositoryInvalidRequestError(this.message);

  @override
  String toString() {
    return message;
  }
}

class RepositorySingleReadError extends Error {
  final String message;

  RepositorySingleReadError(this.message);

  @override
  String toString() {
    return message;
  }
}

class RepositoryMultiReadError extends Error {
  final String message;

  RepositoryMultiReadError(this.message);

  @override
  String toString() {
    return message;
  }
}

class RepositoryCreateError extends Error {
  final String message;

  RepositoryCreateError(this.message);

  @override
  String toString() {
    return message;
  }
}

class UserAuthenticationError extends Error {
  final String message;

  UserAuthenticationError(this.message);

  @override
  String toString() {
    return message;
  }

}