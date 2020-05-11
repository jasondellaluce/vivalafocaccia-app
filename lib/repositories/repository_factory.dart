import 'package:app/core/http_interface.dart';
import 'package:app/core/third_party/network_http_interface.dart';
import 'package:app/repositories/static_impl/static_category_repository.dart';
import 'package:app/repositories/wprest_impl/wprest_comment_repository.dart';
import 'package:app/repositories/wprest_impl/wprest_post_repository.dart';
import 'package:app/repositories/wprest_impl/wprest_recipe_repository.dart';
import 'package:app/repositories/wprest_impl/wprest_user_repository.dart';
import 'package:app/repositories/wprest_impl/wprest_vote_repository.dart';

import 'category_repository.dart';
import 'comment_repository.dart';
import 'post_repository.dart';
import 'vote_repository.dart';
import 'recipe_repository.dart';
import 'user_repository.dart';

class RepositoryFactory {
  String urlEndpoint;
  HttpInterface _httpInterface;

  RepositoryFactory() {
    urlEndpoint = "vivalafocaccia.com";
    _httpInterface = NetworkHttpInterface();
  }

  CategoryRepository forCategory() {
    return StaticCategoryRepository();
  }

  CommentRepository forComment() {
    return WpRestCommentRepository(_httpInterface, urlEndpoint);
  }

  PostRepository forPost() {
    return WpRestPostRepository(_httpInterface, urlEndpoint);
  }

  RecipeRepository forRecipe() {
    return WpRestRecipeRepository(_httpInterface, urlEndpoint);
  }

  UserRepository forUser() {
    return WpRestUserRepository(_httpInterface, urlEndpoint);
  }

  VoteRepository forVote() {
    return WpRestVoteRepository(_httpInterface, urlEndpoint);
  }
}
