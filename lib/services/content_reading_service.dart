import 'package:app/models/models.dart';
import 'package:flutter/cupertino.dart';

class ContentReadingService extends ChangeNotifier {
  Future<Post> _selectedPost = Future.value(Post());
  Future<Recipe> _selectedRecipe = Future.value(Recipe());

  Future<Post> get selectedPost => _selectedPost;

  set selectedPost(Future<Post> value) {
    _selectedPost = value;
    notifyListeners();
  }

  Future<Recipe> get selectedRecipe => _selectedRecipe;

  set selectedRecipe(Future<Recipe> value) {
    _selectedRecipe = value;
    notifyListeners();
  }
}
