
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Simple abstractions for needed HTTP interactions. This abstracts the
/// need of Dart http.Client class, handles every open/close procedure,
/// and can be useful for testing.
abstract class HttpInterface {

  /// Handles an HTTP GET request
  Future<Response> doGet(String authority, String path, {
    Map<String, String> query,
    Map<String, String> headers
  });

  /// Handles an HTTP POST request
  Future<Response> doPost(String authority, String path, {
    Map<String, String> body,
    Map<String, String> query,
    Map<String, String> headers
  });

}

/// Concrete HttpInterface that actually handles network web HTTP requests
class NetworkHttpInterface implements HttpInterface {

  @override
  Future<Response> doGet(String authority, String path, {
      Map<String, String> query,
      Map<String, String> headers}) {
    var uri = query == null
        ? Uri.https(authority, path)
        : Uri.https(authority, path, query);

    return headers == null
        ? http.get(uri)
        : http.get(uri, headers: headers);
  }

  @override
  Future<Response> doPost(String authority, String path, {
      Map<String, String> body,
      Map<String, String> query,
      Map<String, String> headers}) {
    var uri = query == null
        ? Uri.https(authority, path)
        : Uri.https(authority, path, query);

    return headers == null
        ? http.post(uri, body: body ?? Map())
        : http.post(uri, body: body ?? Map(), headers: headers);
  }

}