
import 'category_repository.dart';
import 'comment_repository.dart';
import 'post_repository.dart';
import 'vote_repository.dart';
import 'recipe_repository.dart';
import 'user_repository.dart';

abstract class RepositoryFactory {

  CategoryRepository forCategory();
  CommentRepository forComment();
  PostRepository forPost();
  RecipeRepository forRecipe();
  UserRepository forUser();
  VoteRepository forVote();

}