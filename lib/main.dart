import 'package:app/model/repositories.dart';
import 'package:app/pages/recipe_search_page.dart';
import 'package:app/bloc/recipe_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(App(
      recipeRepository: ModelRepositoryFactory.instance.getRecipeRepository()
  ));
}

class App extends StatelessWidget {
  final RecipeRepository recipeRepository;

  const App({
    Key key,
    @required this.recipeRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VivaLaFocaccia',
      home: BlocProvider(
        create: (context) =>
            RecipeSearchBloc(recipeRepository: recipeRepository),
        child: RecipeSearchPage(),
      ),
    );
  }
}