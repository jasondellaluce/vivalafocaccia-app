class Category {
  final int id;
  final String name;
  final String code;

  Category(this.id, this.name, this.code);

  bool get hasError => id < 0;
  String get errorMessage => code;
  factory Category.createInvalid(String errorMessage) {
    return Category(-1, '', errorMessage);
  }
}

class Post {
  final int id;
  final String code;
  final String title;
  final String content;
  final String authorName;
  final String pageUrl;
  final String featuredImageUrl;
  final DateTime creationDateTime;
  DateTime lastUpdateDateTime;

  Post(this.id, this.code, this.title, this.content, this.authorName, this.pageUrl,
      this.featuredImageUrl, this.creationDateTime, this.lastUpdateDateTime);

  bool get hasError => id < 0;
  String get errorMessage => code;
  factory Post.createInvalid(String errorMessage) {
    return Post(-1, errorMessage, '', '', '', '', '', null, null);
  }
}

class RecipeIngredient {
  final bool separator;
  final String name;
  final String note;
  final String quantity;

  RecipeIngredient(this.separator, this.name, this.note, this.quantity);
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

  Recipe(id, code, title, content, authorName, pageUrl, featuredImageUrl,
      creationDateTime, lastUpdateDateTime, this.servesCount, this.likeCount,
      this.cookingTime, this.cookingTemperature, this.difficulty,
      this.description, this.ingredientList, this.stepList)
      : super(id, code, title, content, authorName, pageUrl, featuredImageUrl,
      creationDateTime, lastUpdateDateTime);

  factory Recipe.createInvalid(String errorMessage) {
    return Recipe(-1, errorMessage, '', '', '', '', '', null, null, 0, 0, '',
        '', '', '', null, null);
  }
}
