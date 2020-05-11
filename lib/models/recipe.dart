import 'post.dart';

class RecipeIngredient {
  final bool isTitle;
  final String name;
  final String note;
  final String quantity;

  RecipeIngredient({this.isTitle, this.name, this.note, this.quantity});
}

class RecipeStep {
  final String title;
  final String duration;
  final String description;
  final List<String> featuredImageUrlList;

  RecipeStep(
      {this.title, this.duration, this.description, this.featuredImageUrlList});
}

class Recipe extends Post {
  final int servesCount;
  final int votesCount;
  final int ratingsCount;
  final double averageRating;
  final double totalMixtureWeight;
  final double totalPanSurface;
  final String cookingTime;
  final String cookingTemperature;
  final String difficulty;
  final String description;
  final List<RecipeStep> stepList;
  final List<RecipeIngredient> ingredientList;

  Recipe(
      {id,
      authorId,
      code,
      title,
      content,
      authorName,
      pageUrl,
      featuredImageUrl,
      featuredVideoUrl,
      creationDateTime,
      lastUpdateDateTime,
      this.servesCount,
      this.votesCount,
      this.ratingsCount,
      this.averageRating,
      this.totalMixtureWeight,
      this.totalPanSurface,
      this.cookingTime,
      this.cookingTemperature,
      this.difficulty,
      this.description,
      this.ingredientList,
      this.stepList})
      : super(
          id: id,
          authorId: authorId,
          code: code,
          title: title,
          content: content,
          authorName: authorName,
          pageUrl: pageUrl,
          featuredImageUrl: featuredImageUrl,
          creationDateTime: creationDateTime,
          lastUpdateDateTime: lastUpdateDateTime,
        );
}
