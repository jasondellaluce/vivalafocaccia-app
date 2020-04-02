
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/model/repositories.dart';
import 'package:app/model/types.dart';

class WPRestJsonPostParser {
  Post parse(String jsonBody) {
    Map<String, dynamic> jsonObj = json.decode(jsonBody);
    return Post(
        int.parse(jsonObj['id'].toString()),
        jsonObj['slug']['rendered'].toString(),
        jsonObj['title']['rendered'].toString(),
        jsonObj['content']['rendered'].toString(),
        jsonObj['author_name'].toString(),
        jsonObj['link'].toString(),
        jsonObj['featured_image_url'],
        DateTime.parse(jsonObj['date_gmt']),
        DateTime.parse(jsonObj['modified_gmt'])
    );
  }

  List<Post> parseList(String jsonBody) {
    List<dynamic> jsonObj = json.decode(jsonBody);
    List<Post> result = new List();
    jsonObj.forEach((element) => result.add(parse(element)));
    return result;
  }
}

class WPRestJsonRecipeParser {
  RecipeIngredient _parseJsonRecipeIngredient(Map<String, dynamic> json) {
    return RecipeIngredient(
      json['is_separator'].toString().toLowerCase() == "true",
      json['name'].toString(),
      json['note'].toString(),
      json['amount'].toString(),
    );
  }

  RecipeStep _parseJsonRecipeStep(Map<String, dynamic> json) {
    List<dynamic> imageList = json['images'];
    return RecipeStep(
        json['title'].toString(),
        json['duration'].toString(),
        json['description'].toString(),
        imageList.map((e) => e['full_image_url'].toString()).toList()
    );
  }

  Recipe parse(String jsonBody) {
    Map<String, dynamic> jsonObj = json.decode(jsonBody);
    List<dynamic> ingredientList = jsonObj['recipe_ingredients'];
    List<dynamic> stepList = jsonObj['recipe_steps'];
    return Recipe(
        int.parse(jsonObj['id'].toString()),
        jsonObj['slug']['rendered'].toString(),
        jsonObj['title']['rendered'].toString(),
        jsonObj['content']['rendered'].toString(),
        jsonObj['author_name'].toString(),
        jsonObj['link'].toString(),
        jsonObj['featured_image_url'].toString(),
        DateTime.parse(jsonObj['date_gmt']),
        DateTime.parse(jsonObj['modified_gmt']),
        int.tryParse(jsonObj['recipe_serves'].toString()) ?? 0,
        int.tryParse(jsonObj['recipe_like_count'].toString()) ?? 0,
        jsonObj['recipe_cooking_time'].toString(),
        jsonObj['recipe_cooking_temperature'].toString(),
        jsonObj['recipe_difficulty'].toString(),
        jsonObj['recipe_quick_description'].toString(),
        ingredientList.map((e) => _parseJsonRecipeIngredient(e)).toList(),
        stepList.map((e) => _parseJsonRecipeStep(e)).toList()
    );
  }

  List<Recipe> parseList(String jsonBody) {
    List<dynamic> jsonObj = json.decode(jsonBody);
    List<Recipe> result = new List();
    jsonObj.forEach((element) => result.add(parse(element)));
    return result;
  }
}

class WPRestPostRepository implements PostRepository {
  final jsonParser = new WPRestJsonPostParser();
  final websiteUrl = "vivalafocaccia.com";
  final restRouteBase = "/wp-json/wp/v2";

  @override
  Future<Post> getFromCode(String code) async {
    Map<String, String> query = {
      'slug' : code
    };
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/posts", query));
    if (response.statusCode == 200) {
      return jsonParser.parse(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post List');
    }
  }

  @override
  Future<Post> getFromId(int id) async {
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/posts/" + id.toString()));
    if (response.statusCode == 200) {
      return jsonParser.parse(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post');
    }
  }

  @override
  Future<List<Post>> getMany({int offset, int count, PostOrder order}) async {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
      // TODO: Implement ordering
    };
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/posts", query));
    if (response.statusCode == 200) {
      return jsonParser.parseList(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post List');
    }
  }

  @override
  Future<List<Post>> getManyFromCategory(Category category,
      {int offset, int count, PostOrder order}) async {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
      'categories' : category.id.toString(),
      // TODO: Implement ordering
    };
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/posts", query));
    if (response.statusCode == 200) {
      return jsonParser.parseList(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post List');
    }
  }

}

class WPRestRecipeRepository implements RecipeRepository {
  final jsonParser = new WPRestJsonRecipeParser();
  final websiteUrl = "vivalafocaccia.com";
  final restRouteBase = "/wp-json/wp/v2";

  @override
  Future<Recipe> getFromCode(String code) async {
    Map<String, String> query = {
      'slug' : code
    };
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/recipes", query));
    if (response.statusCode == 200) {
      return jsonParser.parse(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post List');
    }
  }

  @override
  Future<Recipe> getFromId(int id) async {
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/recipes/" + id.toString()));
    if (response.statusCode == 200) {
      return jsonParser.parse(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post');
    }
  }

  @override
  Future<List<Recipe>> getMany({int offset, int count, RecipeOrder order})
      async {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString()
      // TODO: Implement ordering
    };
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/recipes", query));
    if (response.statusCode == 200) {
      return jsonParser.parseList(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post List');
    }
  }

  @override
  Future<List<Recipe>> getManyFromCategory(Category category,
      {int offset, int count, RecipeOrder order}) async {
    Map<String, String> query = {
      'offset' : offset.toString(),
      'per_page' : count.toString(),
      'categories' : category.id.toString(),
      // TODO: Implement ordering
    };
    final response = await http.get(Uri.https(websiteUrl, restRouteBase
        + "/recipes", query));
    if (response.statusCode == 200) {
      return jsonParser.parseList(response.body);
    }
    else {
      throw Exception('Failed HTTP request for Post List');
    }
  }

}