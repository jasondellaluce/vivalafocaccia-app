export 'category_repository.dart';
export 'comment_repository.dart';
export 'post_repository.dart';
export 'vote_repository.dart';
export 'recipe_repository.dart';
export 'user_repository.dart';
export 'common.dart';
export 'repository_factory.dart';

import 'category_repository.dart';
import 'comment_repository.dart';
import 'repository_factory.dart';
import 'post_repository.dart';
import 'recipe_repository.dart';
import 'user_repository.dart';
import 'vote_repository.dart';
import 'wprest_impl/wprest_post_repository.dart';
import 'wprest_impl/wprest_recipe_repository.dart';
import 'wprest_impl/wprest_user_repository.dart';
import 'wprest_impl/wprest_vote_repository.dart';
import 'static_impl/static_category_repository.dart';
import 'wprest_impl/wprest_comment_repository.dart';

import 'package:app/core/core.dart';

class Repositories implements RepositoryFactory {
  static final Repositories _instance = Repositories._cons();
  String urlEndpoint;
  HttpInterface _httpInterface;

  Repositories._cons() {
    urlEndpoint = "vivalafocaccia.com";
    _httpInterface = NetworkHttpInterface();
  }

  factory Repositories() {
    return _instance;
  }

  @override
  CategoryRepository forCategory() {
    return StaticCategoryRepository();
  }

  @override
  CommentRepository forComment() {
    return WpRestCommentRepository(_httpInterface, urlEndpoint);
  }

  @override
  PostRepository forPost() {
    return WpRestPostRepository(_httpInterface, urlEndpoint);
  }

  @override
  RecipeRepository forRecipe() {
    return WpRestRecipeRepository(_httpInterface, urlEndpoint);
  }

  @override
  UserRepository forUser() {
    return WpRestUserRepository(_httpInterface, urlEndpoint);
  }

  @override
  VoteRepository forVote() {
    return WpRestVoteRepository(_httpInterface, urlEndpoint);
  }

}