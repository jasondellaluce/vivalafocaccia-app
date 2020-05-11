import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../http_interface.dart';

/// Concrete HttpInterface that actually handles network web HTTP requests
class NetworkHttpInterface implements HttpInterface {
  @override
  Future<Response> doGet(String authority, String path,
      {Map<String, String> query, Map<String, String> headers}) {
    var uri = query == null
        ? Uri.https(authority, path)
        : Uri.https(authority, path, query);

    return headers == null ? http.get(uri) : http.get(uri, headers: headers);
  }

  @override
  Future<Response> doPost(String authority, String path,
      {Map<String, String> body,
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
