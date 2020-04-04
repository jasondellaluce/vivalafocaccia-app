
class ModelRetrieveError {
  final String message;

  const ModelRetrieveError({this.message});

  @override
  String toString() {
    return message;
  }
}