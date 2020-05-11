import 'package:app/legacy/model/models.dart';
import 'package:app/legacy/model/wp_rest/wp_rest_comment_repository.dart';
import 'package:app/legacy/model/wp_rest/wp_rest_post_repository.dart';
import 'package:app/legacy/model/wp_rest/wp_rest_user_repository.dart';
import 'package:app/legacy/model/wp_rest/wp_rest_recipe_repository.dart';
import 'package:app/legacy/model/local/local_category_repository.dart';
import 'package:global_configuration/global_configuration.dart';

class Repositories {
  static final Repositories _instance = Repositories._privateConstructor();
  String _websiteUrl;
  var _categoryRepository;
  var _postRepository;
  var _recipeRepository;
  var _userRepository;
  var _commentRepository;

  Repositories._privateConstructor() {
    _websiteUrl =
        GlobalConfiguration().get("serverUrl") ?? "vivalafocaccia.com";
    _categoryRepository = new LocalCategoryRepository();
    _postRepository = new WPRestPostRepository(_websiteUrl);
    _recipeRepository = new WPRestRecipeRepository(_websiteUrl);
    _userRepository = new WPRestUserRepository(_websiteUrl);
    _commentRepository = new WPRestCommentRepository(_websiteUrl);
  }

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

  CommentRepository ofComment() {
    return _commentRepository;
  }

  UserRepository ofUser() {
    return _userRepository;
  }
}
