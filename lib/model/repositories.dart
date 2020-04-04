
import 'package:app/model/impl/mock_repositories.dart';
import 'package:app/model/models.dart';
import 'package:app/model/impl/wprest_repositories.dart';

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

class ModelRepositoryFactory {
  static final ModelRepositoryFactory _instance = ModelRepositoryFactory._privateConstructor();
  static ModelRepositoryFactory get instance => _instance;
  final _categoryRepository = new FixedCategoryRepository();
  final _postRepository = new WPRestPostRepository();
  final _recipeRepository = new WPRestRecipeRepository();

  ModelRepositoryFactory._privateConstructor();

  CategoryRepository getCategoryRepository() {
    return _categoryRepository;
  }

  PostRepository getPostRepository() {
    return _postRepository;
  }

  RecipeRepository getRecipeRepository() {
    return _recipeRepository;
  }
}