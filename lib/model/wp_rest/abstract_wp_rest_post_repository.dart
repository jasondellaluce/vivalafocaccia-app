
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/model/models.dart';
import 'package:app/common/errors.dart';

/// Abstract base class for implementation of repositories that
/// interact with WordPress REST endpoints derived from the
/// standard Post REST Controller. This can serve as simple base
/// for simple posts, but can be adapted for custom post types
/// (which should extend the Post model class for coherency).
abstract class AbstractWpRestPostTypeRepository <PostType extends Post, OrderType>
    implements PostTypeRepository<PostType, OrderType> {

  final String websiteUrl;
  final restRouteBase = "/wp-json/wp/v2";
  final httpClient = http.Client();

  AbstractWpRestPostTypeRepository(this.websiteUrl);

  PostType parseJson(String jsonBody);
  String formatOrderType(OrderType order);
  String get wpRestRoute;

  List<PostType> parseJsonList(String jsonBody) {
    List<dynamic> jsonObj = json.decode(jsonBody);
    List<PostType> result = new List();
    jsonObj.forEach((element) => result.add(parseJson(json.encode(element))));
    return result;
  }

  List<PostType> _parseHttpListResponse(response){
    if (response.statusCode == 200) {
      return parseJsonList(response.body);
    }
    throw DataRetrieveError(response.body['message']);
  }

  List<Future<PostType>> doListHttpRequest(uri, count) {
    final response = httpClient.get(uri)
        .then((value) => _parseHttpListResponse(value));
    return List.generate(count, (index) => response
        .then((value) => value[index])
        .catchError((err) => throw DataRetrieveError(err.toString())));
  }

  Future<PostType> doSingleHttpRequest(uri) async {
    final response = await httpClient.get(uri);
    if (response.statusCode == 200) {
      return parseJson(response.body);
    } else {
      throw DataRetrieveError(response.body.toString());
    }
  }

  @override
  Future<PostType> getFromCode({String code}) async {
    Map<String, String> query = {
      'slug' : code
    };
    var uri = Uri.https(websiteUrl, restRouteBase + "/" + wpRestRoute, query);
    return doSingleHttpRequest(uri);
  }

  @override
  Future<PostType> getFromId({int id}) async {
    var uri = Uri.https(websiteUrl, restRouteBase + "/"
        + wpRestRoute + "/" + id.toString());
    return doSingleHttpRequest(uri);
  }

  @override
  List<Future<PostType>> getMany({offset:0, count:10, order}) {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
    };
    if (order != null) query['orderby'] = formatOrderType(order);

    return doListHttpRequest(
        Uri.https(websiteUrl, restRouteBase + "/" + wpRestRoute, query), count);
  }

  @override
  List<Future<PostType>> getManyFromCategory({Category category,
      offset:0, count:10, order}) {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
      'categories' : category.id.toString(),
    };
    if (order != null) query['orderby'] = formatOrderType(order);
    return doListHttpRequest(
        Uri.https(websiteUrl, restRouteBase + "/" + wpRestRoute, query), count);
  }

  @override
  List<Future<PostType>> getManyFromKeyWords({String keyWords,
      offset:0, count:10, order}) {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
      'search' : keyWords,
    };
    if (order != null) query['orderby'] = formatOrderType(order);
    return doListHttpRequest(
        Uri.https(websiteUrl, restRouteBase + "/" + wpRestRoute, query), count);
  }

}