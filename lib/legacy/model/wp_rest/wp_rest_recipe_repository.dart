
import 'dart:convert';

import 'package:app/legacy/model/models.dart';
import 'abstract_wp_rest_post_repository.dart';

class WPRestRecipeRepository
    extends AbstractWpRestPostTypeRepository<Recipe, RecipeOrder>
    implements RecipeRepository {

  WPRestRecipeRepository(String websiteUrl) : super(websiteUrl);


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

  @override
  Recipe parseJson(String jsonBody) {
    Map<String, dynamic> jsonObj = json.decode(jsonBody);
    List<dynamic> ingredientList = jsonObj['recipe_ingredients'];
    List<dynamic> stepList = jsonObj['recipe_steps'];
    return Recipe(
        int.parse(jsonObj['id'].toString()),
        int.parse(jsonObj['author'].toString()),
        jsonObj['slug'].toString(),
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

  @override
  String formatOrderType(RecipeOrder order) {
    switch(order) {
      case RecipeOrder.date: return "date";
      case RecipeOrder.relevance: return "relevance";
    }
    return "";
  }

  @override
  String get wpRestRoute => "recipes";

  @override
  Future<Recipe> setUserVote({Recipe post, bool positive, user}) {
    // TODO: implement setUserVote
    throw UnimplementedError();
  }


}