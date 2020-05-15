import 'package:app/models/models.dart';
import 'package:app/repositories/repositories.dart';

class DataFetchService {
  
  final fetchPerRequest = 20;
  final CategoryRepository categoryRepository;
  final PostRepository postRepository;
  final RecipeRepository recipeRepository;

  DataFetchService(
      {this.categoryRepository, this.postRepository, this.recipeRepository});

  Future<List<Category>> getCategories() {
    return categoryRepository.readMany(CategoryMultiReadRequest(readCount: 100));
  }

  Future<List<Post>> getPostsPerCategory(Category category, int skipCount) {
    return postRepository.readMany(
        PostMultiReadRequest(categoryId: category.id, readOffset: skipCount, readCount: fetchPerRequest));
  }

  Future<List<Recipe>> getRecipesPerCategory(Category category, int skipCount) {
    return recipeRepository.readMany(
        RecipeMultiReadRequest(categoryId: category.id, readOffset: skipCount, readCount: fetchPerRequest));
  }

   Future<List<Post>> getPostsPerKeywords(String query, int skipCount) {
    return postRepository.readMany(
        PostMultiReadRequest(keyWordQuery: query, readOffset: skipCount, readCount: fetchPerRequest));
  }

  Future<List<Recipe>> getRecipesPerKeywords(String query, int skipCount) {
    return recipeRepository.readMany(
        RecipeMultiReadRequest(keyWordQuery: query, readOffset: skipCount, readCount: fetchPerRequest));
  }

}
