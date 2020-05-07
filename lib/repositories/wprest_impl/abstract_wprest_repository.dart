
import 'dart:convert';

import 'package:app/core/core.dart';
import 'package:app/models/models.dart';
import '../common.dart';

/// Base abstract class for repositories implemented using WordPress REST API
/// as a backend.
abstract class AbstractWpRestRepository<T> {

  final HttpInterface httpClient;

  AbstractWpRestRepository(this.httpClient);

  /// Parses the json object represented by [map] and returns an instance of
  /// type [T].
  T parseJsonMap(Map<String, dynamic> map);

  Future<T> delegateRead(
      String urlBase,
      String urlEndpoint,
      Map<String, String> query,
      Map<String, String> headers) async {
    query.removeWhere((key, value) => value == null);
    headers.removeWhere((key, value) => value == null);
    final response = await httpClient.doGet(urlBase, urlEndpoint,
        query: query, headers: headers);
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      if(decoded is List)
        return parseJsonList(decoded)[0];
      return parseJsonMap(json.decode(response.body));
    }
    throw RepositorySingleReadError(json.decode(response.body)['message']);
  }

  Future<List<T>> delegateReadMany(
      String urlBase,
      String urlEndpoint,
      Map<String, String> query,
      Map<String, String> headers) async {
    query.removeWhere((key, value) => value == null);
    headers.removeWhere((key, value) => value == null);
    final response = await httpClient.doGet(urlBase, urlEndpoint,
        query: query, headers: headers);
    if (response.statusCode == 200) {
      return parseJsonList(json.decode(response.body));
    }
    throw RepositoryMultiReadError(json.decode(response.body)['message']);
  }

  Future<T> delegateCreate(
      String urlBase,
      String urlEndpoint,
      Map<String, dynamic> queryBody,
      Map<String, dynamic> headers) async {
    queryBody.removeWhere((key, value) => value == null);
    headers.removeWhere((key, value) => value == null);
    final response = await httpClient.doPost(urlBase, urlEndpoint,
        body: queryBody, headers: headers);
    if (response.statusCode == 200) {
      return parseJsonMap(json.decode(response.body));
    }
    throw RepositoryCreateError(json.decode(response.body)['message']);
  }

  /// Parses the json list object represented by [list], and returns a list
  /// of elements of type [T].
  List<T> parseJsonList(List<dynamic> list) {
    List<T> result = new List();
    list.forEach((element) => result.add(parseJsonMap(element)));
    return result;
  }

  String formatResultOrderType(ReadOrderType order) {
    switch(order) {
      case ReadOrderType.asc:
        return "asc";
      case ReadOrderType.desc:
        return "desc";
    }
    return null;
  }

  Map<String, String> formatAuthUserTokenToHeader(AuthUser user) {
    return {
      'Authorization' : 'Bearer ${user.authToken}'
    };
  }

}

