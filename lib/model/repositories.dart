
import 'package:app/model/models.dart';
import 'package:app/model/wp_rest/wp_rest_post_repository.dart';
import 'package:app/model/wp_rest/wp_rest_recipe_repository.dart';
import 'package:app/model/local/local_category_repository.dart';

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