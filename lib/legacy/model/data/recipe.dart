
import 'user.dart';
import 'package:meta/meta.dart';

import 'post.dart';

class RecipeIngredient {
  final bool title;
  final String name;
  final String note;
  final String quantity;

  RecipeIngredient(this.title, this.name, this.note, this.quantity);
}

class RecipeStep {
  final String title;
  final String duration;
  final String description;
  final List<String> imageUrlList;

  RecipeStep(this.title, this.duration, this.description, this.imageUrlList);
}

class Recipe extends Post {
  final int servesCount;
  final int likeCount;
  final String cookingTime;
  final String cookingTemperature;
  final String difficulty;
  final String description;
  final List<RecipeIngredient> ingredientList;
  final List<RecipeStep> stepList;

  Recipe(id, authorId, code, title, content, authorName, pageUrl,
      featuredImageUrl, creationDateTime, lastUpdateDateTime, this.servesCount,
      this.likeCount, this.cookingTime, this.cookingTemperature,
      this.difficulty, this.description, this.ingredientList, this.stepList)
      : super(id, authorId, code, title, content, authorName, pageUrl,
      featuredImageUrl, creationDateTime, lastUpdateDateTime);
}

enum RecipeOrder {
  date, relevance
}

abstract class RecipeRepository
    extends PostTypeRepository<Recipe, RecipeOrder> {

  Future<Recipe> setUserVote({
    @required Recipe post,
    @required bool positive,
    @required AuthUser user
  });

}