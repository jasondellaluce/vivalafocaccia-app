
import 'package:app/model/fixed-repositories.dart';
import 'package:app/model/types.dart';
import 'package:app/model/wprest-repositories.dart';

enum CategoryOrder {
  importance
}

enum PostOrder {
  date
}

enum RecipeOrder {
  date
}

abstract class CategoryRepository {
  Future<Category> getFromId(int id);
  Future<List<Category>> getMany({int offset, int count, CategoryOrder order});
}

abstract class PostRepository {
  Future<Post> getFromId(int id);
  Future<Post> getFromCode(String code);
  Future<List<Post>> getMany({int offset, int count, PostOrder order});
  Future<List<Post>> getManyFromCategory(Category category,
      {int offset, int count, PostOrder order});
}

abstract class RecipeRepository {
  Future<Recipe> getFromId(int id);
  Future<Recipe> getFromCode(String code);
  Future<List<Recipe>> getMany({int offset, int count, RecipeOrder order});
  Future<List<Recipe>> getManyFromCategory(Category category,
      {int offset, int count, RecipeOrder order});
}

class ModelRepositoryFactory {
  static final ModelRepositoryFactory _instance = ModelRepositoryFactory._privateConstructor();
  static ModelRepositoryFactory get instance => _instance;
  final _categoryRepositoty = new FixedCategoryRepository();
  final _postRepository = new WPRestPostRepository();
  final _recipeRepository = new WPRestRecipeRepository();

  ModelRepositoryFactory._privateConstructor();

  CategoryRepository getCategoryRepository() {
    return _categoryRepositoty;
  }

  PostRepository getPostRepository() {
    return _postRepository;
  }

  RecipeRepository getRecipeRepository() {
    return _recipeRepository;
  }
}