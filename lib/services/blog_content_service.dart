import 'package:app/models/models.dart';
import 'package:app/repositories/repositories.dart';

class BlogContentService {
  final CategoryRepository categoryRepository;
  final PostRepository postRepository;
  final RecipeRepository recipeRepository;

  BlogContentService(
      {this.categoryRepository, this.postRepository, this.recipeRepository});

  Future<List<Category>> getCategories() {
    return categoryRepository.readMany(CategoryMultiReadRequest());
  }

  Future<List<Post>> getPostsPerCategory(Category category, int skipCount) {
    return postRepository.readMany(
        PostMultiReadRequest(categoryId: category.id, readOffset: skipCount));
  }

  Future<List<Recipe>> getRecipesPerCategory(Category category, int skipCount) {
    return recipeRepository.readMany(
        RecipeMultiReadRequest(categoryId: category.id, readOffset: skipCount));
  }
}
