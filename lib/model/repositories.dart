
import 'package:app/model/models.dart';
import 'package:app/model/wp_rest/wp_rest_post_repository.dart';
import 'package:app/model/wp_rest/wp_rest_recipe_repository.dart';
import 'package:app/model/local/local_category_repository.dart';

enum CategoryOrder {
  importance
}

enum PostOrder {
  date, relevance
}

enum RecipeOrder {
  date, relevance
}

abstract class CategoryRepository {
  Future<Category> getFromId(int id);
  List<Future<Category>> getMany({int offset, int count, CategoryOrder order});
}

abstract class PostRepository {
  Future<Post> getFromId(int id);
  Future<Post> getFromCode(String code);
  List<Future<Post>> getMany({int offset, int count, PostOrder order});
  List<Future<Post>> getManyFromCategory(Category category,
      {int offset, int count, PostOrder order});
  List<Future<Post>> getManyFromKeyWords(String keyWords,
      {int offset, int count, PostOrder order});
}

abstract class RecipeRepository {
  Future<Recipe> getFromId(int id);
  Future<Recipe> getFromCode(String code);
  List<Future<Recipe>> getMany({int offset, int count, RecipeOrder order});
  List<Future<Recipe>> getManyFromCategory(Category category,
      {int offset, int count, RecipeOrder order});
  List<Future<Recipe>> getManyFromKeyWords(String keyWords,
      {int offset, int count, RecipeOrder order});
}

class Repositories {
  static final Repositories _instance = Repositories._privateConstructor();
  final _categoryRepository = new LocalCategoryRepository();
  final _postRepository = new WPRestPostRepository();
  final _recipeRepository = new WPRestRecipeRepository();

  Repositories._privateConstructor();

  factory Repositories() {
    return _instance;
  }

  CategoryRepository ofCategory() {
    return _categoryRepository;
  }

  PostRepository ofPost() {
    return _postRepository;
  }

  RecipeRepository ofRecipe() {
    return _recipeRepository;
  }
}